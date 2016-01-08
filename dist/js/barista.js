jQuery(function($) {
  $.fn.extend({
    collapse: function() {
      var box, height;
      box = $(this);
      if (box.hasClass('collapsed')) {
        return box.css('overflow', 'hidden');
      } else {
        height = box.innerHeight();
        box.css('max-height', height + "px");
        return box.toggleClass('collapsed');
      }
    }
  });
  $('.collapsible').click(function() {
    return $(this).collapse();
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
      var attr, body, dialog;
      dialog = $(this);
      body = $('body');
      attr = {
        "class": 'overlay'
      };
      if (opts.dim) {
        attr["class"] += ' dim';
      }
      $('.overlay').remove();
      $('<div>', attr).appendTo('body').click(function() {
        var overlay;
        overlay = $(this);
        overlay.remove();
        dialog.removeClass('visible');
        return body.removeClass('no-scroll');
      });
      body.addClass('no-scroll');
      dialog.addClass('visible');
      dialog.toggleClass('dim', opts.dim);
      dialog.toggleClass('alert', opts.alert);
      $(window).resize(function() {
        return dialog.center();
      });
      return dialog.center();
    }
  });
  $('*[data-action="modal"]').click(function(event) {
    var button, data, target;
    event.preventDefault();
    button = $(this);
    target = button.data('target');
    data = button.data();
    if (data.alert == null) {
      data.alert = false;
    }
    if (data.dim == null) {
      data.dim = false;
    }
    return $(target).modal(data);
  });
});
