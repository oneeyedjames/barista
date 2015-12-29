jQuery ($) ->
	console.log location

	$.fn.extend
		refreshTabs : ->
			$ this
			.find 'li a'
			.each ->
				button = $ this
				tab = do button.parent
				target = this.hash

				$ target
				.toggle tab.hasClass 'active'

	$('.menu').each ->
		menu = $ this
		active = menu.children 'li.active'
		hashed = menu.find "a[href='#{location.hash}']"

		if active.length
			active.removeClass 'active'
			active.first().addClass 'active'
		else if hashed.length and menu.hasClass 'tabs'
			hashed.first().parent().addClass 'active'
		else
			menu.children 'li:first'
			.addClass 'active'

		if menu.hasClass 'tabs'
			do menu.refreshTabs

			menu.find 'li a'
			.click (event) ->
				do event.preventDefault

				tab = $ this
					.parent()

				tab.siblings 'li'
				.removeClass 'active'

				tab.addClass 'active'

				do menu.refreshTabs

	return