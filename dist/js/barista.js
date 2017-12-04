jQuery(function($) {
  $('.btn').click(function(event) {
    var button;
    button = $(this);
    if (button.hasClass('disabled' || button.attr('disabled'))) {
      return event.preventDefault();
    }
  });
  $.fn.extend({
    collapse: function(min) {
      var box, height;
      box = $(this);
      if (box.hasClass('collapsed')) {
        box.css('overflow', 'hidden');
        box.css('padding', '');
      } else {
        height = box.innerHeight();
        box.css('max-height', height + "px");
        box.css('padding', '0');
      }
      return box.toggleClass('collapsed');
    }
  });
  $('*[data-action="collapse"]').click(function(event) {
    var button, caret, collapsed, target;
    event.preventDefault();
    button = $(this);
    target = $(button.data('target'));
    target.toggleClass('collapsed');
    caret = button.find('.caret');
    if (caret.length > 0) {
      collapsed = target.hasClass('collapsed');
      return caret.toggleClass('fa-caret-down', collapsed).toggleClass('fa-caret-up', !collapsed);
    }
  });
  $('.card.collapsible header').each(function() {
    var card, caret, header;
    header = $(this);
    card = header.parent();
    caret = header.find('.caret');
    if (caret.length === 0) {
      caret = $('<i>').addClass('caret');
      header.append(caret);
    }
    return caret.addClass('fa fa-caret-up').click(function(event) {
      var active, height;
      event.preventDefault();
      if (card.hasClass('collapsed')) {
        card.css('height', '');
      } else {
        height = header.innerHeight();
        card.css('height', height + "px");
      }
      card.toggleClass('collapsed');
      active = card.hasClass('collapsed');
      return header.children('.caret').toggleClass('fa-caret-down', active).toggleClass('fa-caret-up', !active);
    });
  });
  $('form[data-confirm]').submit(function(event) {
    var message;
    message = $(this).data('confirm');
    if (!confirm(message)) {
      return event.preventDefault();
    }
  });
  $.fn.extend({
    refreshTabs: function() {
      return $(this).children('li').each(function() {
        var tab;
        tab = $(this);
        return tab.children('a').each(function() {
          return $(this.hash).toggle(tab.hasClass('active'));
        });
      });
    }
  });
  $('.menu').each(function() {
    var active, hashed, menu;
    menu = $(this);
    active = menu.children('li.active');
    hashed = menu.children('li').children("a[href='" + location.hash + "']");
    if (active.length) {
      active.removeClass('active');
      active.first().addClass('active');
    } else if (hashed.length && menu.hasClass('tabs')) {
      hashed.first().parent().addClass('active');
    } else {
      menu.children('li:first').addClass('active');
    }
    if (menu.hasClass('tabs')) {
      menu.children('li').each(function() {
        var tab;
        tab = $(this);
        return tab.children('a').click(function(event) {
          tab.siblings('li').removeClass('active');
          tab.addClass('active');
          menu.refreshTabs();
          return event.preventDefault();
        });
      });
      return menu.refreshTabs();
    }
  });
  $.fn.extend({
    center: function() {
      var element, hOffset, vOffset, viewport;
      viewport = $(window);
      element = $(this);
      vOffset = (viewport.height() - element.outerHeight()) / 2;
      hOffset = (viewport.width() - element.outerWidth()) / 2;
      return element.css({
        'top': vOffset + "px",
        'left': hOffset + "px"
      });
    },
    modal: function(opts) {
      var body, dialog, dismiss, overlay;
      dialog = $(this);
      body = $('body');
      dismiss = dialog.dismiss.bind(dialog);
      dismiss();
      overlay = $('.overlay');
      if (!overlay.length) {
        overlay = $('<div>').addClass('overlay').appendTo('body');
      }
      overlay.toggleClass('dim', !!opts.overlay).addClass('visible').unbind('click');
      if (opts.overlay !== 'static') {
        overlay.click(dismiss);
      }
      if (!!opts.overlay) {
        body.addClass('no-scroll');
      }
      dialog.addClass('visible');
      dialog.toggleClass('dim', !!opts.overlay);
      $(window).resize(function() {
        return dialog.center();
      });
      if (opts.duration) {
        setTimeout(dismiss, opts.duration);
      }
      dialog.center();
      dialog.find('a.ok, .btn.ok').one('click', function(event) {
        event.preventDefault();
        return dialog.dismiss('ok');
      });
      return dialog.find('a.cancel, .btn.cancel').one('click', function(event) {
        event.preventDefault();
        return dialog.dismiss('cancel');
      });
    },
    dismiss: function(eventType) {
      eventType || (eventType = 'dismiss');
      $('body').removeClass('no-scroll');
      $('.overlay').removeClass('visible');
      return $(this).removeClass('visible').trigger(eventType);
    }
  });
  $('*[data-action="modal"]').click(function(event) {
    var button, data, source, target;
    event.preventDefault();
    button = $(this);
    target = button.data('target');
    data = button.data();
    if (data.duration == null) {
      data.duration = 0;
    }
    if (data.overlay == null) {
      data.overlay = true;
    }
    if (source = button.attr('href')) {
      return $.get(source, function(result) {
        return $(target).html(result).modal(data);
      });
    } else {
      return $(target).modal(data);
    }
  });
  $.fn.extend({
    toggleMenu: function(button) {
      var active;
      active = $(this).hasClass('active');
      $('.navbar ul.nav ul').removeClass('active');
      $(this).toggleClass('active', !active);
      return button.children('.caret').toggleClass('fa-caret-down', active).toggleClass('fa-caret-up', !active);
    }
  });
  $('.navbar *[data-action="menu"]').each(function() {
    return $(this).children('.caret').addClass('fa fa-caret-down');
  });
  $('.navbar *[data-action="menu"]').click(function(event) {
    var button;
    event.preventDefault();
    button = $(this);
    return button.next('ul').toggleMenu(button);
  });
  $('*[data-action="submit"]').click(function(event) {
    var button, data, field, key, target, value;
    event.preventDefault();
    button = $(this);
    target = $(button.data('target'));
    data = button.data();
    for (key in data) {
      value = data[key];
      if (key.startsWith('input')) {
        field = key.substr(5).toLowerCase();
        target.find('[name=' + field + ']').val(value);
      }
    }
    return target.submit();
  });
  $.fn.extend({
    tooltip: function(opts) {
      var target;
      target = $(this);
      if (opts == null) {
        opts = {};
      }
      if (opts.title == null) {
        opts.title = target.attr('title');
      }
      if (opts.side == null) {
        opts.side = target.data('side') || 'top';
      }
      return target.removeAttr('title').data('title', opts.title).hover(function() {
        var hOffset, message, offset, pointer, tooltip, vOffset;
        message = $('<div>').addClass('message').text(opts.title);
        pointer = $('<div>').addClass('pointer');
        tooltip = $('<div>').addClass('tooltip').addClass(opts.side).insertAfter(target).append(pointer).append(message);
        target.data('tooltip', tooltip);
        offset = target.offset();
        switch (opts.side) {
          case 'top':
            offset.top -= tooltip.outerHeight() + 3;
            break;
          case 'left':
            offset.left -= tooltip.outerWidth() + 3;
            break;
          case 'right':
            offset.left += target.outerWidth() + 3;
            break;
          case 'bottom':
            offset.top += target.outerHeight() + 3;
        }
        hOffset = (tooltip.outerWidth() - target.outerWidth()) / 2;
        vOffset = (tooltip.outerHeight() - target.outerHeight()) / 2;
        switch (opts.side) {
          case 'left':
          case 'right':
            offset.top -= vOffset;
            break;
          case 'top':
          case 'bottom':
            offset.left -= hOffset;
        }
        return tooltip.offset(offset);
      }, function() {
        var tooltip;
        return tooltip = $(this).data('tooltip').remove();
      });
    }
  });
  $('*[data-hover="tooltip"]').each(function() {
    return $(this).tooltip();
  });
});
