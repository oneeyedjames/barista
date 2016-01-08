$.fn.extend
	center : ->
		viewport = $ window
		element = $ this

		vOffset = ( viewport.height() - element.outerHeight() ) / 2
		hOffset = ( viewport.width() - element.outerWidth() ) / 2

		element.css
			'top'  : "#{vOffset}px"
			'left' : "#{hOffset}px"

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
			do overlay.remove
			dialog.removeClass 'visible'
			body.removeClass 'no-scroll'

		body.addClass 'no-scroll'

		dialog.addClass 'visible'
		dialog.toggleClass 'dim', opts.dim
		dialog.toggleClass 'alert', opts.alert

		$ window
		.resize ->
			do dialog.center

		do dialog.center

$ '*[data-action="modal"]'
.click (event) ->
	do event.preventDefault

	button = $ this
	target = button.data 'target'

	data = do button.data
	data.alert ?= false
	data.dim   ?= false

	$(target).modal data
