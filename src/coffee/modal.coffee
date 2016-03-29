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

		dismiss = dialog.dismiss.bind dialog

		do dismiss

		overlay = $ '.overlay'

		if ! overlay.length
			overlay = $ '<div>'
			.addClass 'overlay'
			.appendTo 'body'

		body.addClass 'no-scroll' if opts.dim

		dialog.addClass 'visible'
		dialog.toggleClass 'dim', opts.dim
		dialog.toggleClass 'alert', opts.alert

		overlay.toggleClass 'dim', opts.dim
		.addClass 'visible'
		.unbind 'click'
		.click dismiss

		$ window
		.resize ->
			do dialog.center

		setTimeout dismiss, opts.timeout if opts.timeout

		do dialog.center

	dismiss : (eventType) ->
		eventType ||= 'dismiss'

		$ 'body'
		.removeClass 'no-scroll'

		$ '.overlay'
		.removeClass 'visible'

		$ this
		.removeClass 'visible'
		.trigger eventType

$ '*[data-action="modal"]'
.click (event) ->
	do event.preventDefault

	button = $ this
	target = button.data 'target'

	data = do button.data
	data.timeout ?= 0
	data.alert   ?= false
	data.dim     ?= false

	$ target
	.modal data

$ '.modal .close'
.click (event) ->
	do event.preventDefault

	$ this
	.parents '.modal'
	.dismiss()

$ '.modal .btn.cancel'
.click (event) ->
	do event.preventDefault

	$ this
	.parents '.modal'
	.dismiss 'cancel'

$ '.modal .btn.ok'
.click (event) ->
	do event.preventDefault

	$ this
	.parents '.modal'
	.dismiss 'ok'
