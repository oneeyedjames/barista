$.fn.extend
	collapse : ->
		box = $ this

		if box.hasClass 'collapsed'
			box.css 'overflow', 'hidden'
		else
			height = do box.innerHeight
			box.css 'max-height', "#{height}px"

		#setTimeout ->
			box.toggleClass 'collapsed'
		#, 1

$ '.collapsible'
.click ->
	$ this
	.collapse()