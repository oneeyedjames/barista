$ 'a[target]'
.click (event) ->
	button = $ this
	source = button.attr 'href'
	target = button.attr 'target'

	if source && target not in ['_blank', '_parent', '_self', '_top']
		do event.preventDefault

		$.get source, (result) ->
			$ target
			.html result

			button.attr 'href', ''
			button.trigger 'click'
			button.attr 'href', source
