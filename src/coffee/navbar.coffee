$.fn.toggleMenu = (button) ->
	active = $ this
	.hasClass 'active'

	$ '.navbar ul.nav ul'
	.removeClass 'active'

	$ this
	.toggleClass 'active', ! active

	button.children '.caret'
	.toggleClass 'fa-caret-down', active
	.toggleClass 'fa-caret-up', ! active

$ '.navbar *[data-action="menu"]'
.each ->
	$ this
	.children '.caret'
	.addClass 'fa fa-caret-down'

$ '.navbar *[data-action="menu"]'
.click (event) ->
	do event.preventDefault

	$ this
	.next 'ul'
	.toggleMenu button

$ '[data-action=toggle]'
.click (event) ->
	do event.preventDefault

	button = $ this
	target = $ button.data 'target'

	do target.toggle

	target.find 'ul.nav ul'
	.toggleClass 'active'
