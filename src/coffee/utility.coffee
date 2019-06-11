$.fn.center = ->
	viewport = $ window
	element  = $ this

	vOffset = (viewport.height() - element.outerHeight()) / 2
	hOffset = (viewport.width()  - element.outerWidth() ) / 2

	element.css
		top  : "#{vOffset}px"
		left : "#{hOffset}px"
