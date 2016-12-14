$ '.btn'
.click (event) ->
	button = $ this

	if button.hasClass 'disabled' or button.attr 'disabled'
		do event.preventDefault
