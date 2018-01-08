$ 'form[data-confirm]'
.submit (event) ->
	form = $ this

	do event.preventDefault unless 'true' == form.data 'confirmed'

	data = do form.data
	data.duration ?= 0
	data.overlay  ?= true

	dialog = $ '<div class="card warning modal">'
	.text data.confirm

	header = $ '<header> Warning</header>'
	.prepend $ '<i class="fa fa-warning">'
	.append ($ '<a class="caret cancel">'
	.append $ '<i class="fa fa-close">')

	footer = $ '<footer class="btns">'
	.append $ '<button class="btn cancel">Cancel</button>'
	.append $ '<button class="btn danger ok">Ok</button>'

	dialog.prepend header
	dialog.append footer

	dialog.one 'ok', (event) ->
		form.data 'confirmed', 'true'
		do form.submit

	$ 'body'
	.append dialog

	dialog.modal data
