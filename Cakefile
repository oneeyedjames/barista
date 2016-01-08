fs   = require 'fs'
proc = require 'child_process'

coffee_src  = 'src/coffee'
coffee_dest = 'dist/js'
coffee_root = 'barista'

sass_src  = 'src/sass'
sass_dest = 'dist/css'
sass_root = 'barista'

yui = true

try
	which = proc.execSync 'which yui'
catch err
	console.error 'YUI compressor is not installed. Scripts and styles will not be minified.'
	yui = false

task 'build', 'Build all source files', ->
	record 'build', ->
		invoke 'build:js'
		invoke 'build:css'

task 'build:js', 'Build CoffeeScript files into JS', ->
	invoke 'clean:js'
	record 'build:js', ->
		outFile = "#{coffee_dest}/#{coffee_root}.js"
		minFile = "#{coffee_dest}/#{coffee_root}.min.js"

		try
			inCode = fs.readdirSync coffee_src
			.map (file) -> fs.readFileSync "#{coffee_src}/#{file}", 'utf8'
			.join '\n'
			.split '\n'
			.join '\n\t'

			inCode  = "jQuery ($) ->\n\t#{inCode}\n\treturn"
			outCode = proc.execSync 'coffee -sbp', input: inCode
			fs.writeFileSync outFile, outCode

			if yui
				minCode = proc.execSync "yui --type js", input: outCode
				fs.writeFileSync minFile, minCode
		catch err
			console.error "[#{new Date}] : Error executing '#{err.cmd}'"

task 'build:css', 'Build Sass files into CSS', ->
	invoke 'clean:css'
	record 'build:css', ->
		try
			proc.execSync 'which bourbon'
			proc.execSync "bourbon install --path=#{sass_src}"
		catch err
			throw err

		inFile  = "#{sass_src}/#{sass_root}.sass"
		outFile = "#{sass_dest}/#{sass_root}.css"
		minFile = "#{sass_dest}/#{sass_root}.min.css"

		try
			outCode = proc.execSync "sass -t expanded --trace #{inFile}"
			fs.writeFileSync outFile, outCode

			if yui
				minCode = proc.execSync "yui --type css", input: outCode
				fs.writeFileSync minFile, minCode
		catch err
			console.error "[#{new Date}] : Error executing '#{err.cmd}'"

task 'clean', 'Clean all files from distribution folder', ->
	record 'clean', ->
		invoke 'clean:js'
		invoke 'clean:css'

task 'clean:js', 'Clean JS files from distribution folder', ->
	record 'clean:js', -> clean 'dist/js'

task 'clean:css', 'Clean CSS files from distribution folder', ->
	record 'clean:css', -> clean 'dist/css'

task 'watch', 'Watch all source files for changes', ->
	invoke 'watch:js'
	invoke 'watch:css'

task 'watch:js', 'Watch CoffeeScript files for changes', ->
	watch coffee_src, 'build:js'

task 'watch:css', 'Watch Sass files for changes', ->
	watch sass_src, 'build:css'

record = (name, something) ->
	starting = new Date
	console.log "[#{starting}] : Starting task '#{name}' ..."

	do something

	finished = new Date
	ellapsed = finished.valueOf() - starting.valueOf()
	console.log "[#{finished}] : Finished task '#{name}' in #{ellapsed} millisecond(s)"

clean = (dir) ->
	files = fs.readdirSync dir
	.map (file) -> "#{dir}/#{file}"

	fs.unlinkSync file for file in files

watch = (dir, task) ->
	invoke task

	console.log "[#{new Date}] : Watching #{dir} for changes ..."

	fs.watch dir, ->
		console.log "[#{new Date}] : Changes detected in #{dir}"
		invoke task
	.on 'error', (err) ->
		console.error err