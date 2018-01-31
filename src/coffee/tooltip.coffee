$.fn.tooltip = (settings) ->
	target = $ this

	settings ?= {}
	settings.title ?= target.attr 'title'
	settings.color ?= target.data 'color'
	settings.side  ?= target.data('side') || 'top'

	target.removeAttr 'title'
	.data 'title', settings.title
	.hover ->
		message = $ '<div>'
		.addClass 'message'
		.text settings.title

		pointer = $ '<div>'
		.addClass 'pointer'

		tooltip = $ '<div>'
		.addClass 'tooltip'
		.addClass settings.color
		.addClass settings.side
		.insertAfter target
		.append pointer
		.append message

		target.data 'tooltip', tooltip

		offset = target.offset()

		switch settings.side
			when 'top' then offset.top -= tooltip.outerHeight() + 3
			when 'left' then offset.left -= tooltip.outerWidth() + 3
			when 'right' then offset.left += target.outerWidth() + 3
			when 'bottom' then offset.top += target.outerHeight() + 3

		hOffset = (tooltip.outerWidth() - target.outerWidth()) / 2
		vOffset = (tooltip.outerHeight() - target.outerHeight()) / 2

		switch settings.side
			when 'left', 'right' then offset.top -= vOffset
			when 'top', 'bottom' then offset.left -= hOffset

		tooltip.offset offset
	, ->
		$ this
		.data 'tooltip'
		.remove()

	this

$ '*[data-hover="tooltip"]'
.each ->
	target = $ this

	data = do target.data

	target.tooltip data
