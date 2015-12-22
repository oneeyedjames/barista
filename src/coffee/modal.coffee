do ($=jQuery) ->
	$ ->
		$.fn.extend
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
				dialog.css 'top', '32px'

				return

		$ '*[data-action="modal"]'
		.click (event) ->
			button = $ this
			target = button.data 'target'

			$(target).modal
				dim : button.data 'dim'

			event.preventDefault()

		return
	return