$.fn.extend
	center : ->
		viewport = $ window
		element = $ this

		vOffset = (viewport.height() - element.outerHeight()) / 2
		hOffset = (viewport.width() - element.outerWidth()) / 2

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

		overlay.toggleClass 'dim', !!opts.overlay
		.addClass 'visible'
		.unbind 'click'

		overlay.click dismiss unless opts.overlay == 'static'

		body.addClass 'no-scroll' if !!opts.overlay

		dialog.addClass 'visible'
		dialog.toggleClass 'dim', !!opts.overlay

		$ window
		.resize ->
			do dialog.center

		setTimeout dismiss, opts.duration if opts.duration

		do dialog.center

		dialog.find 'a.ok, .btn.ok'
		.one 'click', (event) ->
			do event.preventDefault
			dialog.dismiss 'ok'

		dialog.find 'a.cancel, .btn.cancel'
		.one 'click', (event) ->
			do event.preventDefault
			dialog.dismiss 'cancel'

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
	data.duration ?= 0
	data.overlay  ?= true

	if source = button.attr 'href'
		parent = button.data 'parent'
		parent = target unless parent

		$.get source, (result) ->
			$ parent
			.html result

			$ target
			.modal data
	else
		$ target
		.modal data
