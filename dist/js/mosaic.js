jQuery(document).ready(function($) {
  $('*[data-action="modal"]').click(function(event) {
    var button, target;
    button = $(this);
    target = button.data('target');
    $(target).modal({
      dim: button.data('dim')
    });
    return event.preventDefault();
  });
  return $.fn.extend({
    modal: function(opts) {
      var attr, dialog;
      dialog = $(this);
      attr = {
        "class": 'overlay'
      };
      if (opts.dim) {
        attr["class"] += ' dim';
      }
      $('.overlay').remove();
      $('<div>', attr).appendTo('body').click(function() {
        $('body').removeClass('no-scroll');
        dialog.removeClass('visible');
        return $(this).remove();
      });
      $('body').addClass('no-scroll');
      if (opts.dim) {
        dialog.addClass('dim');
      }
      dialog.addClass('visible');
      return dialog.css('top', '32px');
    }
  });
});
