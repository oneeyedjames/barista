$.fn.collapse = (min) ->
	box = $ this

	if box.hasClass 'card'
		if box.hasClass 'collapsed'
			box.css 'height', ''
		else
			header = box.children 'header'
			height = do header.innerHeight
			box.css 'height', "#{height}px"
	else
		if box.hasClass 'collapsed'
			box.css 'overflow', 'hidden'
			box.css 'padding', ''
		else
			height = do box.innerHeight
			box.css 'max-height', "#{height}px"
			box.css 'padding', '0'

	box.toggleClass 'collapsed'
	box.trigger 'collapse', box.hasClass 'collapsed'

	this

$ '*[data-action="collapse"]'
.each ->
	button = $ this
	target = $ button.data 'target'

	caret = button.find '.caret'

	if caret.length > 0
		collapsed = target.hasClass 'collapsed'

		caret.addClass 'fa'
		.toggleClass 'fa-caret-down', collapsed
		.toggleClass 'fa-caret-up', ! collapsed

		target.on 'collapse', (target, collapsed) ->
			caret
			.toggleClass 'fa-caret-down', collapsed
			.toggleClass 'fa-caret-up', ! collapsed

	button.click (event) ->
		do event.preventDefault
		do target.collapse

$ '.card.collapsible header'
.each ->
	header = $ this
	card = do header.parent

	caret = header.find '.caret'

	if caret.length == 0
		caret = $ '<i>'
		.addClass 'fa caret'

		header.append caret

	collapsed = card.hasClass 'collapsed'

	caret.addClass 'fa'
	.toggleClass 'fa-caret-down', collapsed
	.toggleClass 'fa-caret-up', ! collapsed

	card.on 'collapse', (card, collapsed) ->
		caret
		.toggleClass 'fa-caret-down', collapsed
		.toggleClass 'fa-caret-up', ! collapsed

	header.click (event) ->
		do event.preventDefault
		do card.collapse
