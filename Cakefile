fs   = require 'fs'
path = require 'path'
proc = require 'child_process'

coffee_src  = 'src/coffee'
coffee_dest = 'dist/js'
coffee_root = 'barista'

sass_src  = 'src/sass'
sass_dest = 'dist/css'
sass_root = 'barista'

haml_src  = 'src/haml'
haml_dest = 'dist/html'
haml_root = 'index'

sass_ver  = proc.execSync 'sass --version'
sass_flag = if sass_ver.includes 'Ruby Sass' then 't' else 's'

task 'build', 'Build all source files', ->
	record 'build', ->
		invoke 'build:js'
		invoke 'build:css'
		invoke 'build:html'

task 'build:js', 'Build CoffeeScript files into JS', ->
	invoke 'clean:js'
	record 'build:js', ->
		inFile  = "#{coffee_src}/#{coffee_root}.coffee"
		outFile = "#{coffee_dest}/#{coffee_root}.js"
		minFile = "#{coffee_dest}/#{coffee_root}.min.js"

		try
			source = parse inFile, (line) ->
				match = line.match /^(\s*)#import\s([0-9A-Z/\\-_.]+$)/i

				return line unless match

				lead = match[1]
				file = match[2].replace '\\', '/'

				dir  = path.dirname file
				base = path.basename file, '.coffee'
				file = path.resolve coffee_src, dir, base

				unless fs.existsSync "#{file}.coffee"
					file = path.resolve coffee_src, dir, "_#{base}"

				if fs.existsSync "#{file}.coffee"
					return parse "#{file}.coffee", (line) -> "#{lead}#{line}"

			proc.execSync "coffee -sbp > #{outFile}", input: source
			proc.execSync "uglifyjs #{outFile} -cmo #{minFile}"
		catch err
			console.error "[#{new Date}] : Error executing '#{err.cmd}'"

task 'build:css', 'Build Sass files into CSS', ->
	record 'build:css', ->
		invoke 'build:css:core'
		invoke 'build:css:plugins'
		invoke 'build:css:themes'

task 'build:css:core', 'Build core Sass files into CSS', ->
	invoke 'clean:css:core'
	record 'build:css:core', ->
		inFile  = "#{sass_src}/#{sass_root}.sass"
		outFile = "#{sass_dest}/#{sass_root}.css"
		minFile = "#{sass_dest}/#{sass_root}.min.css"

		try
			proc.execSync "sass -#{sass_flag} expanded --trace #{inFile} > #{outFile}"
			proc.execSync "sass -#{sass_flag} compressed --trace #{inFile} > #{minFile}"
		catch err
			console.error "[#{new Date}] : Error executing '#{err.cmd}'"

		inFile  = "#{sass_src}/#{sass_root}-effects.sass"
		outFile = "#{sass_dest}/#{sass_root}-effects.css"
		minFile = "#{sass_dest}/#{sass_root}-effects.min.css"

		try
			proc.execSync "sass -#{sass_flag} expanded --trace #{inFile} > #{outFile}"
			proc.execSync "sass -#{sass_flag} compressed --trace #{inFile} > #{minFile}"
		catch err
			console.error "[#{new Date}] : Error executing '#{err.cmd}'"

task 'build:css:plugins', 'Build Sass plugin files into CSS', ->
	invoke 'clean:css:plugins'
	record 'build:css:plugins', ->
		pluginDir = "#{sass_src}/plugins"
		plugins = fs.readdirSync pluginDir
		.map (file) -> file.replace /\.sass$/, ""

		for plugin in plugins
			inFile  = "#{sass_src}/plugins/#{plugin}.sass"
			outFile = "#{sass_dest}/plugins/#{sass_root}-#{plugin}.css"
			minFile = "#{sass_dest}/plugins/#{sass_root}-#{plugin}.min.css"

			try
				proc.execSync "sass -#{sass_flag} expanded --trace #{inFile} > #{outFile}"
				proc.execSync "sass -#{sass_flag} compressed --trace #{inFile} > #{minFile}"
			catch err
				console.error "[#{new Date}] : Error executing '#{err.cmd}'"

task 'build:css:themes', 'Build Sass theme files into CSS', ->
	invoke 'clean:css:themes'
	record 'build:css:themes', ->
		themeDir = "#{sass_src}/themes"
		themes = fs.readdirSync themeDir
		.map (file) -> file.replace /\.sass$/, ""

		for theme in themes
			inFile  = "#{sass_src}/themes/#{theme}.sass"
			outFile = "#{sass_dest}/themes/#{sass_root}-#{theme}.css"
			minFile = "#{sass_dest}/themes/#{sass_root}-#{theme}.min.css"

			try
				proc.execSync "sass -#{sass_flag} expanded --trace #{inFile} > #{outFile}"
				proc.execSync "sass -#{sass_flag} compressed --trace #{inFile} > #{minFile}"
			catch err
				console.error "[#{new Date}] : Error executing '#{err.cmd}'"

task 'build:html', 'Build HAML files ino HTML', ->
	invoke 'clean:html'
	record 'build:html', ->
		(file for file in fs.readdirSync haml_src when file.match /^[^_].*\.haml$/)
		.forEach (file) ->
			inFile  = "#{haml_src}/#{file}"
			outFile = "#{haml_dest}/#{path.basename file, '.haml'}.html"

			try
				outCode = proc.execSync "haml -r ./helpers.rb --trace #{inFile}"
				fs.writeFileSync outFile, outCode
			catch err
				console.error "[#{new Date}] : Error executing '#{err.cmd}'"

task 'clean', 'Clean all files from distribution folder', ->
	record 'clean', ->
		invoke 'clean:js'
		invoke 'clean:css'

task 'clean:js', 'Clean JS files from distribution folder', ->
	record 'clean:js', -> clean coffee_dest

task 'clean:css', 'Clean CSS files from distribution folder', ->
	record 'clean:css', ->
		invoke 'clean:css:core'
		invoke 'clean:css:plugins'
		invoke 'clean:css:themes'

task 'clean:css:core', 'Clean core CSS files from distribution folder', ->
	record 'clean:css:core', ->
		clean sass_dest

task 'clean:css:plugins', 'Clean CSS plugin files from distribution folder', ->
	record 'clean:css:plugins', ->
		clean "#{sass_dest}/plugins"

task 'clean:css:themes', 'Clean CSS theme files from distribution folder', ->
	record 'clean:css:themes', ->
		clean "#{sass_dest}/themes"

task 'clean:html', 'Clean HTML files from distribution folder', ->
	record 'clean:html', -> clean haml_dest

task 'watch', 'Watch all source files for changes', ->
	invoke 'watch:js'
	invoke 'watch:css'
	invoke 'watch:html'

task 'watch:js', 'Watch CoffeeScript files for changes', ->
	watch coffee_src, 'build:js'

task 'watch:css', 'Watch Sass files for changes', ->
	watch sass_src, 'build:css'

task 'watch:html', 'Watch HAML files for changes', ->
	watch haml_src, 'build:html'

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

	try
		fs.unlinkSync file for file in files
	catch err
		console.error "[#{new Date}] : #{err}"

watch = (dir, task) ->
	invoke task

	console.log "[#{new Date}] : Watching #{dir} for changes ..."

	fs.watch dir, recursive: true, ->
		console.log "[#{new Date}] : Changes detected in #{dir}"
		invoke task
	.on 'error', (err) ->
		console.error err

parse = (file, transform) ->
	fs.readFileSync file
	.toString()
	.split /[\r\n]+/
	.map transform
	.join '\n'
