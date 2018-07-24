$.fn.center = ->
	viewport = $ window
	element = $ this

	vOffset = (viewport.height() - element.outerHeight()) / 2
	hOffset = (viewport.width() - element.outerWidth()) / 2

	element.css
		top  : "#{vOffset}px"
		left : "#{hOffset}px"

$.fn.modal = (settings) ->
	settings = $.extend $.fn.modal.defaults, settings

	dialog = $ this
	body = $ 'body'
	overlay = $ '.overlay'

	if ! overlay.length
		overlay = $ '<div>'
		.addClass 'overlay'
		.appendTo 'body'

	# dismiss = dialog.dismiss.bind dialog
	dismiss = (eventType) ->
		eventType ||= 'dismiss'
		body.removeClass 'no-scroll'
		overlay.removeClass 'visible'
		dialog.removeClass 'visible'
		.trigger eventType

	do dismiss

	overlay.toggleClass 'dim', !!settings.overlay
	.addClass 'visible'
	.unbind 'click'
	.click dismiss unless settings.overlay == 'static'

	body.addClass 'no-scroll' if !!settings.overlay

	dialog.addClass 'visible'
	.toggleClass 'dim', !!settings.overlay

	$ window
	.resize ->
		do dialog.center

	setTimeout dismiss, settings.duration if settings.duration

	do dialog.center

	dialog.find 'a.ok, .btn.ok'
	.one 'click', (event) ->
		do event.preventDefault
		dialog.dismiss 'ok'

	dialog.find 'a.cancel, .btn.cancel'
	.one 'click', (event) ->
		do event.preventDefault
		dialog.dismiss 'cancel'

$.fn.modal.defaults =
	overlay  : true
	duration : 0

$ '*[data-action="modal"]'
.on 'click', (event) ->
	do event.preventDefault

	button = $ this

	unless event.type == 'click' && button.attr 'href'
		$ button.data 'target'
		.modal do button.data
