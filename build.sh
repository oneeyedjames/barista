#!/bin/bash

build_css () {
	echo -n "  Compiling CSS    "

	if [ ! -d dist ]
	then
		mkdir dist
	fi

	if [ -d dist/css ]
	then
		rm dist/css/*.css
	else
		mkdir dist/css
	fi

	scss -t expanded src/scss/mosaic.scss > dist/css/mosaic.css
	scss -t compressed src/scss/mosaic.scss > dist/css/mosaic.min.css

	echo -e "\033[0;32mDone\033[0m"
}

build_js() {
	echo -n "  Compiling JS     "

	if [ ! -d dist ]
	then
		mkdir dist
	fi

	if [ -d dist/js ]
	then
		rm dist/js/*.js
	else
		mkdir dist/js
	fi

	find src/coffee/ -type f -exec cat {} \; | coffee -sbp > dist/js/mosaic.js
	java -jar /usr/local/jar/closure-compiler.jar dist/js/mosaic.js > dist/js/mosaic.min.js

	echo -e "\033[0;32mDone\033[0m"
}

path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

case "$1" in
	watch)
		echo -e "Building from source in \033[0;36m$path/src/\033[0m"

		build_css
		build_js

		echo -e "Watching for changes in \033[0;36m$path/src/\033[0m"

		cssmtime1=`find src/scss -type f -exec md5 {} \;`
		jsmtime1=`find src/coffee -type f -exec md5 {} \;`

		while [[ true ]]
		do
			cssmtime2=`find src/scss -type f -exec md5 {} \;`
			jsmtime2=`find src/coffee -type f -exec md5 {} \;`

			if [[ $cssmtime1 != $cssmtime2 ]]
			then
				echo -e "Changes detected in \033[0;36m$path/src/scss/\033[0m"
				build_css
				cssmtime1=$cssmtime2
			fi

			if [[ $jsmtime1 != $jsmtime2 ]]
			then
				echo -e "Changes detected in \033[0;36m$path/src/coffee/\033[0m"
				build_js
				jsmtime1=$jsmtime2
			fi
		done
		;;
	css)
		echo -e "Building from source in \033[0;36m$path/src/scss/\033[0m"
		build_css
		;;
	js)
		echo -e "Building from source in \033[0;36m$path/src/coffee/\033[0m"
		build_js
		;;
	*)
		echo -e "Building from source in \033[0;36m$path/src/\033[0m"
		build_css
		build_js
		;;
esac