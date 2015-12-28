jQuery ($) ->
	$.fn.extend
		center : ->
			viewport = $ window
			element = $ this

			vOffset = ( viewport.height() - element.outerHeight() ) / 2
			hOffset = ( viewport.width() - element.outerWidth() ) / 2

			element.css
				'top'  : "#{vOffset}px"
				'left' : "#{hOffset}px"

			return

		modal : (opts) ->
			dialog = $ this
			body = $ 'body'

			attr =
				class : 'overlay'

			attr.class += ' dim' if opts.dim

			$ '.overlay'
			.remove()

			$ '<div>', attr
			.appendTo 'body'
			.click ->
				overlay = $ this
				overlay.remove()
				dialog.removeClass 'visible'
				body.removeClass 'no-scroll'

			body.addClass 'no-scroll'

			dialog.addClass 'visible'
			dialog.addClass 'dim' if opts.dim

			do dialog.center

			$ window
			.resize ->
				do dialog.center

			return

	$ '*[data-action="modal"]'
	.click (event) ->
		button = $ this
		target = button.data 'target'

		$(target).modal
			dim : button.data 'dim'

		event.preventDefault()

	return