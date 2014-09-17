koa        = require 'koa'
parse      = require 'co-body'
json       = require 'koa-json'
views      = require 'co-views'
logger     = require 'koa-logger'
router     = require 'koa-router'
serve      = require 'koa-static'
session    = require 'koa-session'
livereload = require 'koa-livereload'

app = module.exports = koa()

app.use logger()
app.use json()
app.use session()
app.use livereload()
app.use router app
render = views 'views/'
app.use serve 'public/'
require('koa-qs')(app)

app.get '/', ->*
  @body = yield render 'index.jade'

app.get '/partials/:name', ->*
  partial = "partials/#{@params.name}.jade"
  @body = yield render(partial)

app.get '/api/:id', ->*
  @body =
    id: @params.id
    query: @query

app.listen 3000
