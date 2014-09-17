"use strict"

# Filters 
app = angular.module('app.filters', [])
app.filter "format_time", ->
  (time) ->
    date = new Date(time)
    padStr(date.getHours()) + ':' + padStr(date.getMinutes())

app.filter "format_date_time", ->
  (time) ->    
    date = new Date(time)
    padStr(date.getDate()) + '.' +
    padStr(1 + date.getMonth()) + '. ' +
    #padStr(date.getFullYear()) + ' ' +
    padStr(date.getHours()) + ':' +
    padStr(date.getMinutes()) + ' Uhr'# +
    #padStr(date.getSeconds())

padStr = (i) ->
  if (i < 10) then "0" + i else "" + i
