$.fn.tabbar = ->
	tabbar = this

	select = (index) ->
		tabs   = tabbar.find '.tab'
		panels = tabbar.find '.panel'

		tabs.removeClass 'active'
		panels.removeClass 'active'

		$ tabs[index]
		.addClass 'active'

		$ panels[index]
		.addClass 'active'

	tabbar.find '.tab'
	.click (event) ->
		do event.preventDefault

		tab = $ this

		select do tab.index unless tab.hasClass 'disabled' or tab.attr 'disabled'

	activeTab = tabbar.find '.tab.active'

	index = if activeTab.length then do activeTab.index else 0

	select index

	this

$ '.tabbar'
.each ->
	$ this
	.tabbar()
