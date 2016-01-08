$.fn.extend
	refreshTabs : ->
		$ this
		.children 'li'
		.each ->
			tab = $ this
			tab.children 'a'
			.each ->
				$ this.hash
				.toggle tab.hasClass 'active'

$ '.menu'
.each ->
	menu = $ this

	active = menu.children 'li.active'
	hashed = menu.children 'li'
	.children "a[href='#{location.hash}']"

	if active.length
		active.removeClass 'active'
		active.first().addClass 'active'
	else if hashed.length and menu.hasClass 'tabs'
		hashed.first().parent().addClass 'active'
	else
		menu.children 'li:first'
		.addClass 'active'

	if menu.hasClass 'tabs'
		menu.children 'li'
		.each ->
			tab = $ this
			tab.children 'a'
			.click (event) ->
				tab.siblings 'li'
				.removeClass 'active'

				tab.addClass 'active'

				do menu.refreshTabs
				do event.preventDefault

		do menu.refreshTabs
