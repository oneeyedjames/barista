$ 'form[data-confirm]'
.submit (event) ->
	form = $ this

	do event.preventDefault unless 'true' == form.data 'confirmed'

	data = $.extend
		duration : 0
		overlay  : true
		header   : 'Warning'
		cancel   : 'Cancel'
		ok       : 'Ok'
	, do form.data

	header = $ '<header>'
	.text ' ' + data.header
	.prepend $ '<i class="fa fa-warning">'
	.append ($ '<a class="caret cancel">'
	.append $ '<i class="fa fa-close">')

	footer = $ '<footer class="btns">'
	.append ($ '<button class="btn cancel">'
	.text data.cancel)
	.append ($ '<button class="btn danger ok">'
	.text data.ok)

	dialog = $ '<div class="card warning modal">'
	.text data.confirm
	.prepend header
	.append footer
	.one 'ok', (event) ->
		form.data 'confirmed', 'true'
		do form.submit

	$ 'body'
	.append dialog

	dialog.modal data
