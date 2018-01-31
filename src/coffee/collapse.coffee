$.fn.collapse = (min) ->
	box = $ this

	if box.hasClass 'collapsed'
		box.css 'overflow', 'hidden'
		box.css 'padding', ''
	else
		height = do box.innerHeight
		box.css 'max-height', "#{height}px"
		box.css 'padding', '0'

	box.toggleClass 'collapsed'

	this

$ '*[data-action="collapse"]'
.click (event) ->
	do event.preventDefault

	button = $ this
	target = $ button.data 'target'

	do target.collapse

	caret = button.find '.caret'

	if caret.length > 0
		collapsed = target .hasClass 'collapsed'
		caret
		.toggleClass 'fa-caret-down', collapsed
		.toggleClass 'fa-caret-up', ! collapsed

$ '.card.collapsible header'
.each ->
	header = $ this
	card = do header.parent

	caret = header.find '.caret'

	if caret.length == 0
		caret = $ '<i>'
		.addClass 'caret'

		header.append caret

	caret
	.addClass 'fa fa-caret-up'
	.click (event) ->
		do event.preventDefault

		if card.hasClass 'collapsed'
			card.css 'height', ''
		else
			height = do header.innerHeight
			card.css 'height', "#{height}px"

		card.toggleClass 'collapsed'

		active = card.hasClass 'collapsed'

		header.children '.caret'
		.toggleClass 'fa-caret-down', active
		.toggleClass 'fa-caret-up', ! active
