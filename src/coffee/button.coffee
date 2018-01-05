$ '.btn'
.click (event) ->
	button = $ this

	if button.hasClass 'disabled' or button.attr 'disabled'
		do event.preventDefault

$ '.btn.toggle'
.click (event) ->
	button = $ this
	button.toggleClass('active')

$ '.btn-group.single'
.each (index, group) ->
	group = $ group

	buttons = group.find '.btn'
	buttons.click (event) ->
		button = $ this

		isActive = button.hasClass 'active'

		buttons.removeClass 'active'
		button.toggleClass 'active', !isActive
