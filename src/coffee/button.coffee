$ '.btn'
.click (event) ->
	button = $ this

	return do event.preventDefault if button.hasClass 'disabled' or button.attr 'disabled'

	button.toggleClass 'active' if button.hasClass 'toggle'

$ '.btn-group.single'
.each ->
	group = $ this

	buttons = group.find '.btn'
	buttons.click (event) ->
		button = $ this

		isActive = button.hasClass 'active'

		buttons.removeClass 'active'
		button.toggleClass 'active', !isActive

$ '.btn-group.toggle'
.each ->
	group = $ this

	buttons = group.find '.btn'
	buttons.addClass 'toggle'
