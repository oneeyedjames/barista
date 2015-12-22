fs   = require 'fs'
proc = require 'child_process'

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
		closure = "/usr/local/jar/closure-compiler.jar"

		source = fs.readdirSync coffee_src
		.map (file) ->
			fs.readFileSync "#{coffee_src}/#{file}", 'utf8'
		.join '\n'

		compile = proc.spawnSync 'coffee', ['-sbp'], input: source

		script = do compile.stdout.toString

		fs.createWriteStream "#{coffee_dest}/#{coffee_root}.js"
		.write script, 'utf8'

		minify = proc.spawnSync "java", ['-jar', closure], input: script

		minified = do minify.stdout.toString

		fs.createWriteStream "#{coffee_dest}/#{coffee_root}.min.js"
		.write minified, 'utf8'

task 'build:css', 'Build Sass files into CSS', ->
	invoke 'clean:css'
	record 'build:css', ->
		opts = [
			'-t expanded'
			'--trace'
		]

		inFile = "#{sass_src}/#{sass_root}.scss"
		outFile = "#{sass_dest}/#{sass_root}.css"

		proc.execSync "sass #{opts.join ' '} #{inFile} > #{outFile}", handle

		opts[0] = '-t compressed'

		outFile = "#{sass_dest}/#{sass_root}.min.css"

		proc.execSync "sass #{opts.join ' '} #{inFile} > #{outFile}", handle

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
	console.log "[#{new Date}] : Watching #{coffee_src} for changes ..."
	fs.watch coffee_src, ->
		invoke 'build:js'

task 'watch:css', 'Watch Sass files for changes', ->
	console.log "[#{new Date}] : Watching #{sass_src} for changes ..."
	fs.watch sass_src, ->
		invoke 'build:css'

record = (name, something) ->
	starting = new Date
	console.log "[#{starting}] : Starting task '#{name}' ..."

	do something

	finished = new Date
	ellapsed = finished.valueOf() - starting.valueOf()
	console.log "[#{finished}] : Finished task '#{name}' in #{ellapsed} millisecond(s)"

handle = (err, stdout, stderr) ->
	console.error err if err
	console.error stderr if stderr
	console.log stdout if stdout