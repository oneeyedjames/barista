$ '*[data-action="submit"]'
.click (event) ->
	do event.preventDefault

	button = $ this
	target = button.data 'target'

	message = $ target
	.data 'message'

	if message and not confirm message
		return false

	data = do button.data

	for key, value of data
		$ target
		.find '#' + key.substr 6
		.val value if key.startsWith 'input-'

	$ target
	.submit
