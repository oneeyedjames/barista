(function() {
  jQuery(function($) {
    $.fn.extend({
      center: function() {
        var element, hOffset, vOffset, viewport;
        viewport = $(window);
        element = $(this);
        vOffset = (viewport.height() - element.outerHeight()) / 2;
        hOffset = (viewport.width() - element.outerWidth()) / 2;
        element.css({
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
        if (opts.dim) {
          dialog.addClass('dim');
        }
        dialog.center();
        $(window).resize(function() {
          return dialog.center();
        });
      }
    });
    $('*[data-action="modal"]').click(function(event) {
      var button, target;
      button = $(this);
      target = button.data('target');
      $(target).modal({
        dim: button.data('dim')
      });
      return event.preventDefault();
    });
  });

}).call(this);
