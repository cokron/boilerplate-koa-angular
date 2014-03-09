koa = require 'koa'
logger = require 'koa-logger'
router = require 'koa-router'
serve = require 'koa-static'
parse = require 'co-body'
views = require 'co-views'
json = require 'koa-json'
session = require 'koa-session'

app = koa()

app.use logger()
app.use json()
app.use session()
app.use router app
render = views 'views/'
app.use serve './public'
require('koa-qs')(app)

app.get '/', ->*
  @body = yield render 'index.jade'

app.get '/api/:id', ->*
  @body =
    id: @params.id
    query: @query

app.listen 3000
