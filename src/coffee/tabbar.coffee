$.fn.extend
	selectTab : (index) ->
		tabbar = $ this

		return this unless tabbar.hasClass 'tabbar'

		tabs   = tabbar.find '.tab'
		panels = tabbar.find '.panel'

		tabs.removeClass 'active'
		panels.removeClass 'active'

		$ tabs[index]
		.addClass 'active'

		$ panels[index]
		.addClass 'active'

		this

$ '.tabbar'
.each (index, tabbar) ->
	tabbar = $ tabbar
	tabbar.find '.tab'
	.click (event) ->
		do event.preventDefault

		tab = $ this

		return if tab.hasClass 'disabled' or tab.attr 'disabled'

		tabIndex = do tab.index
		tabbar.selectTab tabIndex

	activeTab = tabbar.find '.tab.active'

	index = if activeTab.length then do activeTab.index else 0

	tabbar.selectTab index
