$.fn.extend
	tooltip : (opts) ->
		target = $ this

		opts ?= {}
		opts.title ?= target.attr 'title'
		opts.side  ?= target.data('side') || 'top'

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

$ '*[data-hover="tooltip"]'
.each ->
	$ this
	.tooltip()
