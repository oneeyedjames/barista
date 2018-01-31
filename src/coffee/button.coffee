$ '.btn'
.click (event) ->
	button = $ this
	do event.preventDefault if button.hasClass 'disabled' or button.attr 'disabled'

$ '.btn.toggle'
.click (event) ->
	button = $ this
	button.toggleClass 'active' unless button.hasClass 'disabled' or button.attr 'disabled'

$ '.btn-group.single'
.each ->
	group = $ this

	buttons = group.find '.btn'
	buttons.click (event) ->
		button = $ this

		isActive = button.hasClass 'active'

		buttons.removeClass 'active'
		button.toggleClass 'active', !isActive
