$ 'form[data-confirm]'
.submit (event) ->
    message = $ this
    .data 'confirm'

    unless confirm message
        do event.preventDefault
