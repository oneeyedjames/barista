(function($) {
  $(function() {
    $.fn.extend({
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
        dialog.css('top', '32px');
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
})(jQuery);
