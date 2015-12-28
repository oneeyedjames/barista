fs   = require 'fs'
proc = require 'child_process'

# Specify path to YUI Compressor jar
yui = '/usr/local/jar/yuicompressor.jar'

coffee_src  = 'src/coffee'
coffee_dest = 'dist/js'
coffee_root = 'barista'

sass_src  = 'src/sass'
sass_dest = 'dist/css'
sass_root = 'barista'

task 'build', 'Build all source files into destination', ->
	record 'build', ->
		invoke 'build:js'
		invoke 'build:css'

task 'build:js', 'Build CoffeeScript files into JS', ->
	invoke 'clean:js'
	record 'build:js', ->
		source = fs.readdirSync coffee_src
		.map (file) ->
			fs.readFileSync "#{coffee_src}/#{file}", 'utf8'
		.join '\n'

		outFile = "#{coffee_dest}/#{coffee_root}.js"
		minFile = "#{coffee_dest}/#{coffee_root}.min.js"

		try
			script = proc.execSync 'coffee -sp', input: source
			minify = proc.execSync "java -jar #{yui} --type js", input: script

			fs.writeFileSync outFile, script
			fs.writeFileSync minFile, minify
		catch err
			console.error "[#{new Date}] : Error executing '#{err.cmd}'"

task 'build:css', 'Build Sass files into CSS', ->
	invoke 'clean:css'
	record 'build:css', ->
		inFile  = "#{sass_src}/#{sass_root}.scss"
		outFile = "#{sass_dest}/#{sass_root}.css"
		minFile = "#{sass_dest}/#{sass_root}.min.css"

		try
			css = proc.execSync "sass -t expanded --trace #{inFile}"
			min = proc.execSync "java -jar #{yui} --type css", input: css

			fs.writeFileSync outFile, css
			fs.writeFileSync minFile, min
		catch err
			console.error "[#{new Date}] : Error executing '#{err.cmd}'"

task 'clean', 'Clean all files from destination folder', ->
	record 'clean', ->
		invoke 'clean:js'
		invoke 'clean:css'

task 'clean:js', 'Clean JS files from destination folder', ->
	record 'clean:js', ->
		files = fs.readdirSync 'dist/js'
		.map (file) -> "dist/js/#{file}"
		fs.unlinkSync file for file in files

task 'clean:css', 'Clean CSS files from destination folder', ->
	record 'clean:css', ->
		files = fs.readdirSync 'dist/css'
		.map (file) -> "dist/css/#{file}"
		fs.unlinkSync file for file in files

task 'watch', 'Watch all source files for changes', ->
	invoke 'watch:js'
	invoke 'watch:css'

task 'watch:js', 'Watch CoffeeScript files for changes', ->
	invoke 'build:js'
	console.log "[#{new Date}] : Watching #{coffee_src} for changes ..."
	fs.watch coffee_src, ->
		invoke 'build:js'

task 'watch:css', 'Watch Sass files for changes', ->
	invoke 'build:css'
	console.log "[#{new Date}] : Watching #{sass_src} for changes ..."
	csswatch = fs.watch sass_src, ->
		invoke 'build:css'

	csswatch.on 'error', (err) ->
		console.log err

record = (name, something) ->
	starting = new Date
	console.log "[#{starting}] : Starting task '#{name}' ..."

	do something

	finished = new Date
	ellapsed = finished.valueOf() - starting.valueOf()
	console.log "[#{finished}] : Finished task '#{name}' in #{ellapsed} millisecond(s)"
