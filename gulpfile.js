var gulp = require('gulp');
var gutil = require('gulp-util');
var clean = require('gulp-rimraf');
var concat = require('gulp-concat');
var rename = require('gulp-rename');
var soften = require('gulp-soften');

var sass = require('gulp-sass');
var prefixCss = require('gulp-autoprefixer');
var minifyCss = require('gulp-minify-css');

var coffee = require('gulp-coffee');
var coffeeLint = require('gulp-coffeelint');
var minifyJs = require('gulp-uglify');

var paths = {
	sass: {
		src: 'src/scss/**/*.scss',
		dest: 'dist/css'
	},
	coffee: {
		src: 'src/coffee/**/*.coffee',
		dest: 'dist/js'
	}
};

gulp.task('sass', ['clean-sass'], function() {
	return gulp.src('src/scss/mosaic.scss')
	.pipe(sass({ style: 'expanded' }))
	.pipe(prefixCss())
	.pipe(gulp.dest(paths.sass.dest))
	.pipe(minifyCss())
	.pipe(rename({ suffix: '.min' }))
	.pipe(gulp.dest(paths.sass.dest));
});

gulp.task('coffee', ['clean-coffee'], function() {
	return gulp.src(paths.coffee.src)
	.pipe(soften(2))
	.pipe(coffeeLint())
	.pipe(coffeeLint.reporter())
	.pipe(coffee({ bare: true }).on('error', gutil.log))
	.pipe(concat('mosaic.js'))
	.pipe(gulp.dest(paths.coffee.dest))
	.pipe(minifyJs())
	.pipe(rename({ suffix: '.min' }))
	.pipe(gulp.dest(paths.coffee.dest));
});

gulp.task('clean-sass', function() {
	return gulp.src(paths.sass.dest, { read: false }).pipe(clean());
});

gulp.task('clean-coffee', function() {
	return gulp.src(paths.coffee.dest, { read: false }).pipe(clean());
});

gulp.task('clean', ['clean-sass', 'clean-coffee']);

gulp.task('build', ['sass', 'coffee']);

gulp.task('watch', function() {
	gulp.watch(paths.sass.src, ['sass']);
	gulp.watch(paths.coffee.src, ['coffee']);
});

gulp.task('default', ['build']);