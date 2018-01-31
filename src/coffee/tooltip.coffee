$.fn.extend
	tooltip : (opts) ->
		target = $ this

		opts = $.extend
			title : target.attr 'title'
			side  : 'top'
		, opts

		target.removeAttr 'title'
		.data 'title', opts.title
		.hover ->
			message = $ '<div>'
			.addClass 'message'
			.text opts.title

			pointer = $ '<div>'
			.addClass 'pointer'

			tooltip = $ '<div>'
			.addClass 'tooltip'
			.addClass opts.color
			.addClass opts.side
			.insertAfter target
			.append pointer
			.append message

			target.data 'tooltip', tooltip

			offset = target.offset()

			switch opts.side
				when 'top' then offset.top -= tooltip.outerHeight() + 3
				when 'left' then offset.left -= tooltip.outerWidth() + 3
				when 'right' then offset.left += target.outerWidth() + 3
				when 'bottom' then offset.top += target.outerHeight() + 3

			hOffset = (tooltip.outerWidth() - target.outerWidth()) / 2
			vOffset = (tooltip.outerHeight() - target.outerHeight()) / 2

			switch opts.side
				when 'left', 'right' then offset.top -= vOffset
				when 'top', 'bottom' then offset.left -= hOffset

			tooltip.offset offset
		, ->
			tooltip = $ this
			.data 'tooltip'
			.remove()

		this

$ '*[data-hover="tooltip"]'
.each ->
	target = $ this

	data = do target.data

	target.tooltip data
