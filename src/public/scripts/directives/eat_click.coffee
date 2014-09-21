"use strict"
app = angular.module('app.directives'

app.directive "eatClick", ->
  (scope, element, attrs) ->
    $(element).click (event) ->
      event.preventDefault()
      false


