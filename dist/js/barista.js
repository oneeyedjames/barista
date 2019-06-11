jQuery(function($) {
  $('.btn').click(function(event) {
    var button;
    button = $(this);
    if (button.hasClass('disabled' || button.attr('disabled'))) {
      return event.preventDefault();
    }
    if (button.hasClass('toggle')) {
      return button.toggleClass('active');
    }
  });
  $('.btn-group.single').each(function() {
    var buttons, group;
    group = $(this);
    buttons = group.find('.btn');
    return buttons.click(function(event) {
      var button, isActive;
      button = $(this);
      isActive = button.hasClass('active');
      buttons.removeClass('active');
      return button.toggleClass('active', !isActive);
    });
  });
  $('.btn-group.toggle').each(function() {
    var buttons, group;
    group = $(this);
    buttons = group.find('.btn');
    return buttons.addClass('toggle');
  });
  $.fn.collapse = function(min) {
    var box, header, height;
    box = $(this);
    if (box.hasClass('card')) {
      if (box.hasClass('collapsed')) {
        box.css('height', '');
      } else {
        header = box.children('header');
        height = header.innerHeight();
        box.css('height', height + "px");
      }
    } else {
      if (box.hasClass('collapsed')) {
        box.css('overflow', 'hidden');
        box.css('padding', '');
      } else {
        height = box.innerHeight();
        box.css('max-height', height + "px");
        box.css('padding', '0');
      }
    }
    box.toggleClass('collapsed');
    box.trigger('collapse', box.hasClass('collapsed'));
    return this;
  };
  $('*[data-action="collapse"]').each(function() {
    var button, caret, collapsed, target;
    button = $(this);
    target = $(button.data('target'));
    caret = button.find('.caret');
    if (caret.length > 0) {
      collapsed = target.hasClass('collapsed');
      caret.addClass('fa').toggleClass('fa-caret-down', collapsed).toggleClass('fa-caret-up', !collapsed);
      target.on('collapse', function(target, collapsed) {
        return caret.toggleClass('fa-caret-down', collapsed).toggleClass('fa-caret-up', !collapsed);
      });
    }
    return button.click(function(event) {
      event.preventDefault();
      return target.collapse();
    });
  });
  $('.card.collapsible header').each(function() {
    var card, caret, collapsed, header;
    header = $(this);
    card = header.parent();
    caret = header.find('.caret');
    if (caret.length === 0) {
      caret = $('<i>').addClass('fa caret');
      header.append(caret);
    }
    collapsed = card.hasClass('collapsed');
    caret.addClass('fa').toggleClass('fa-caret-down', collapsed).toggleClass('fa-caret-up', !collapsed);
    card.on('collapse', function(card, collapsed) {
      return caret.toggleClass('fa-caret-down', collapsed).toggleClass('fa-caret-up', !collapsed);
    });
    return header.click(function(event) {
      event.preventDefault();
      return card.collapse();
    });
  });
  $('form[data-confirm]').submit(function(event) {
    var data, dialog, footer, form, header;
    form = $(this);
    if ('true' !== form.data('confirmed')) {
      event.preventDefault();
    }
    data = $.extend({}, {
      duration: 0,
      overlay: true,
      header: 'Warning',
      cancel: 'Cancel',
      ok: 'Ok'
    }, form.data());
    header = $('<header>').text(' ' + data.header).prepend($('<i class="fa fa-warning">')).append($('<a class="caret cancel">').append($('<i class="fa fa-close">')));
    footer = $('<footer class="btns">').append($('<button class="btn cancel">').text(data.cancel)).append($('<button class="btn danger ok">').text(data.ok));
    dialog = $('<div class="card warning modal">').text(data.confirm).prepend(header).append(footer).one('ok', function(event) {
      form.data('confirmed', 'true');
      return form.submit();
    });
    $('body').append(dialog);
    return dialog.modal(data);
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
  $('ul.menu').each(function() {
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
  $.fn.modal = function(settings) {
    var body, dialog, dismiss, overlay;
    settings = $.extend({}, $.fn.modal.defaults, settings);
    dialog = $(this);
    body = $('body');
    overlay = $('.overlay');
    if (!overlay.length) {
      overlay = $('<div>').addClass('overlay').appendTo('body');
    }
    dismiss = function(eventType) {
      eventType || (eventType = 'dismiss');
      body.removeClass('no-scroll');
      overlay.removeClass('visible');
      return dialog.removeClass('visible').trigger(eventType);
    };
    dismiss();
    if (settings.overlay !== 'static') {
      overlay.toggleClass('dim', !!settings.overlay).addClass('visible').unbind('click').click(dismiss);
    }
    if (!!settings.overlay) {
      body.addClass('no-scroll');
    }
    dialog.addClass('visible').toggleClass('dim', !!settings.overlay);
    $(window).resize(function() {
      return dialog.center();
    });
    if (settings.duration) {
      setTimeout(dismiss, settings.duration);
    }
    dialog.center();
    dialog.find('a.ok, .btn.ok').one('click', function(event) {
      event.preventDefault();
      return dismiss('ok');
    });
    return dialog.find('a.cancel, .btn.cancel').one('click', function(event) {
      event.preventDefault();
      return dismiss('cancel');
    });
  };
  $.fn.modal.defaults = {
    overlay: true,
    duration: 0
  };
  $('*[data-action="modal"]').on('click', function(event) {
    var button;
    event.preventDefault();
    button = $(this);
    if (!(event.type === 'click' && button.attr('href'))) {
      return $(button.data('target')).modal(button.data());
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
    event.preventDefault();
    return $(this).next('ul').toggleMenu(button);
  });
  $('[data-action=toggle]').click(function(event) {
    var button, target;
    event.preventDefault();
    button = $(this);
    target = $(button.data('target'));
    target.toggle();
    return target.find('ul.nav ul').toggleClass('active');
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
  $.fn.tabbar = function() {
    var activeTab, index, select, tabbar;
    tabbar = this;
    select = function(index) {
      var panels, tabs;
      tabs = tabbar.find('.tab');
      panels = tabbar.find('.panel');
      tabs.removeClass('active');
      panels.removeClass('active');
      $(tabs[index]).addClass('active');
      return $(panels[index]).addClass('active');
    };
    tabbar.find('.tab').click(function(event) {
      var tab;
      event.preventDefault();
      tab = $(this);
      if (!tab.hasClass('disabled' || tab.attr('disabled'))) {
        return select(tab.index());
      }
    });
    activeTab = tabbar.find('.tab.active');
    index = activeTab.length ? activeTab.index() : 0;
    select(index);
    return this;
  };
  $('.tabbar').each(function() {
    return $(this).tabbar();
  });
  $('a[target]').click(function(event) {
    var button, source, target;
    button = $(this);
    source = button.attr('href');
    target = button.attr('target');
    if (source && (target !== '_blank' && target !== '_parent' && target !== '_self' && target !== '_top')) {
      event.preventDefault();
      return $.get(source, function(result) {
        $(target).html(result);
        button.attr('href', '');
        button.trigger('click');
        return button.attr('href', source);
      });
    }
  });
  $.fn.tooltip = function(settings) {
    var target;
    target = $(this);
    if (settings == null) {
      settings = {};
    }
    if (settings.title == null) {
      settings.title = target.attr('title');
    }
    if (settings.color == null) {
      settings.color = target.data('color');
    }
    if (settings.side == null) {
      settings.side = target.data('side') || 'top';
    }
    target.removeAttr('title').data('title', settings.title).hover(function() {
      var hOffset, message, offset, pointer, tooltip, vOffset;
      message = $('<div>').addClass('message').text(settings.title);
      pointer = $('<div>').addClass('pointer');
      tooltip = $('<div>').addClass('tooltip').addClass(settings.color).addClass(settings.side).insertAfter(target).append(pointer).append(message);
      target.data('tooltip', tooltip);
      offset = target.offset();
      switch (settings.side) {
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
      switch (settings.side) {
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
      return $(this).data('tooltip').remove();
    });
    return this;
  };
  $('*[data-hover="tooltip"]').each(function() {
    var data, target;
    target = $(this);
    data = target.data();
    return target.tooltip(data);
  });
  $.fn.center = function() {
    var element, hOffset, vOffset, viewport;
    viewport = $(window);
    element = $(this);
    vOffset = (viewport.height() - element.outerHeight()) / 2;
    hOffset = (viewport.width() - element.outerWidth()) / 2;
    return element.css({
      top: vOffset + "px",
      left: hOffset + "px"
    });
  };
});
