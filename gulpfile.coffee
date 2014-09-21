gulp       = require 'gulp'
jade       = require 'gulp-jade'
gutil      = require 'gulp-util'
mocha      = require 'gulp-mocha'
coffee     = require 'gulp-coffee'
stylus     = require 'gulp-stylus'
concat     = require 'gulp-concat'
uglify     = require 'gulp-uglify'
nodemon    = require 'gulp-nodemon'
imagemin   = require 'gulp-imagemin'
coffeeES6  = require 'gulp-coffee-es6'
livereload = require 'gulp-livereload'
gulpFilter = require('gulp-filter')
rename     = require("gulp-rename");
minifycss  = require('gulp-minify-css')
flatten    = require('gulp-flatten')
ngAnnotate = require 'gulp-ng-annotate'

mainBowerFiles = require('main-bower-files')

paths =
  views       : 'src/public/**/*.jade'
  styles      : 'src/public/stylesheets/**/*.styl'
  images      : 'src/public/images/**/*'
  scripts     : 'src/public/scripts/**/*.coffee'
  server      : ['src/*.coffee', 'src/routes/*.coffee']
  dest        : 'public'

gulp.task 'server-scripts', ->
  gulp.src paths.server
    .pipe coffeeES6 bare: yes
    .pipe gulp.dest './'

gulp.task 'scripts', ->
  gulp.src paths.scripts
    .pipe coffee()
    .pipe(ngAnnotate())
    .pipe uglify()
    .pipe concat 'app.min.js'
    .pipe gulp.dest paths.dest + '/scripts'
    .pipe livereload()

gulp.task 'styles', ->
  gulp.src paths.styles
    .pipe stylus()
    .pipe gulp.dest paths.dest + '/stylesheets'
    .pipe livereload()

gulp.task 'images', ->
  gulp.src paths.images
    .pipe imagemin()
    .pipe gulp.dest paths.dest + '/images'
    .pipe livereload()

gulp.task 'views', ->
  gulp.src paths.views
    .pipe jade()
    .pipe gulp.dest paths.dest
    .pipe livereload()

gulp.task 'rendered-views', ->
  gulp.src 'views/**/*.jade'
    .pipe livereload()

gulp.task "libs", ->

  minJsFilter = gulpFilter("*.min.js")
  jsFilter = gulpFilter("*.js")
  cssFilter = gulpFilter("*.css")
  fontFilter = gulpFilter(["*.eot", "*.woff", "*.svg", "*.ttf"])

  gulp.src(mainBowerFiles())
    .pipe(jsFilter)
    .pipe(gulp.dest(paths.dest + "/scripts/vendor"))
    .pipe(uglify())
    .pipe(rename(suffix: ".min"))
    .pipe(gulp.dest(paths.dest + "/scripts/vendor"))
    .pipe(jsFilter.restore())

    .pipe(minJsFilter)
    .pipe concat 'vendor.min.js'
    .pipe(gulp.dest(paths.dest + "/scripts"))
    .pipe(jsFilter.restore())

    .pipe(cssFilter)
    .pipe(gulp.dest(paths.dest + "/stylesheets/vendor"))
    .pipe(minifycss())
    .pipe concat '../vendor.min.css'
    .pipe(gulp.dest(paths.dest + "/stylesheets/vendor"))
    .pipe(cssFilter.restore())

    .pipe(fontFilter)
    .pipe(flatten())
    .pipe(gulp.dest(paths.dest + "/fonts"))

gulp.task 'server', ->
  nodemon
    script: 'app.js'
    nodeArgs: ['--harmony']
    ignore: [
      './src/**'
      './test/**'
      './public/**'
      './node_modules/**'
    ]

gulp.task 'watch', ->
  gulp.watch paths.views       , ['views']
  gulp.watch paths.styles      , ['styles']
  gulp.watch paths.scripts     , ['scripts']
  gulp.watch paths.server      , ['server-scripts']
  gulp.watch 'views/**/*.jade' , ['rendered-views']


gulp.task 'default', ['views', 'styles', 'scripts', 'images', 'server-scripts', 'watch', 'libs', 'server']
