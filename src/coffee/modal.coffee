$.fn.extend
	modal : (opts) ->
		opts = $.extend
			duration : 0
			overlay  : true
		, opts

		dialog = $ this
		body   = $ 'body'

		dismiss = dialog.dismiss.bind dialog

		do dismiss

		overlay = $ '.overlay'

		unless overlay.length
			overlay = $ '<div>'
			.addClass 'overlay'
			.appendTo 'body'

		overlay.toggleClass 'dim', !!opts.overlay
		.addClass 'visible'
		.unbind 'click'

		overlay.click dismiss unless opts.overlay == 'static'

		body.toggleClass 'no-scroll', !!opts.overlay

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

		this

	dismiss : (eventType) ->
		eventType ||= 'dismiss'

		$ 'body'
		.removeClass 'no-scroll'

		$ '.overlay'
		.removeClass 'visible'

		$ this
		.removeClass 'visible'
		.trigger eventType

		this

$ '*[data-action="modal"]'
.on 'click post:click', (event) ->
	do event.preventDefault

	button = $ this
	target = $ button.data 'target'

	data = do button.data

	unless event.type == 'click' && button.attr 'href'
		target.modal data
