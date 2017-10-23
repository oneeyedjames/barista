$ '*[data-action="submit"]'
.click (event) ->
	do event.preventDefault

	button = $ this
	target = $ button.data 'target'

	message = target.data 'message'

	if message and not confirm message
		return false

	data = do button.data

	for key, value of data
		if key.startsWith 'input'
			field = do key.substr 5
			.toLowerCase

			target.find '[name=' + field + ']'
			.val value

	do target.submit
