jQuery document
.ready ($) ->
	$ '*[data-action="modal"]'
	.click (event) ->
		button = $ this
		target = button.data 'target'

		$(target).modal
			dim : button.data 'dim'

		event.preventDefault()

	$.fn.extend
		modal : (opts) ->
			dialog = $ this

			attr =
				class : 'overlay'

			attr.class += ' dim' if opts.dim

			$('.overlay').remove()

			$ '<div>', attr
			.appendTo 'body'
			.click ->
				$('body').removeClass 'no-scroll'
				dialog.removeClass 'visible'
				$(this).remove()

			$('body').addClass 'no-scroll'

			dialog.addClass 'visible'
			dialog.css 'top', '32px'
