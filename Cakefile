fs = require 'fs'
proc = require 'child_process'

coffee_src = 'src/coffee'
coffee_dest = 'dist/js'
coffee_temp = "#{coffee_dest}/barista.coffee"

sass_src = 'src/sass/barista.scss'
sass_dest = 'dist/css/barista.css'
sass_opts = '-t expanded --trace'
sass_min_dest = 'dist/css/barista.min.css'
sass_min_opts = '-t compressed --trace'

task 'build', 'Build all source files into destination', ->
	#record 'build:all', ->
		invoke 'build:js'
		invoke 'build:css'

task 'build:js', 'Build CoffeeScript files into JS', ->
	invoke 'clean:js'
	record 'build:js', ->
		source = fs.readdirSync coffee_src
		.map (file) ->
			fs.readFileSync "#{coffee_src}/#{file}", 'utf8'
		.join '\n'

		compile = proc.spawn 'coffee', ['-sbp']

		compile.on 'error', (err) ->
			console.error error

		compile.on 'exit', ->
			proc.execSync "java -jar /usr/local/jar/closure-compiler.jar #{coffee_dest}/barista.js > #{coffee_dest}/barista.min.js", handle

		compile.stdout.pipe fs.createWriteStream "#{coffee_dest}/barista.js"
		compile.stdin.write source
		compile.stdin.end()

task 'build:css', 'Build Sass files into CSS', ->
	invoke 'clean:css'
	record 'build:css', ->
		proc.execSync "sass #{sass_opts} #{sass_src} > #{sass_dest}", handle
		proc.execSync "sass #{sass_min_opts} #{sass_src} > #{sass_min_dest}", handle

task 'clean', 'Clean all files from destination folder', ->
	#record 'clean:all', ->
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

record = (name, something) ->
	starting = new Date
	console.log "[#{starting}] : Starting task '#{name}' ..."

	do something

	finished = new Date
	ellapsed = finished.valueOf() - starting.valueOf()
	console.log "[#{finished}] : Finished task '#{name}' in #{ellapsed} millisecond(s)"

handle = (err, stdout, stderr) ->
	console.error stderr if stderr
	console.log stdout if stdout
	throw err if err