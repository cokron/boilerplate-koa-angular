'use strict'
app = angular.module('app')

app.controller 'HomeController', ($scope) ->
  $scope.user = {name: "hans"}
