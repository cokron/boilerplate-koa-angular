'use strict'
app = angular.module('app')

app.controller 'HomeController', ['$scope', '$http', '$location', ($scope, $http, $location) ->
  #DataService.retrieveUser($scope, $http, Data, false)
  $scope.user = {name: "hans"}

  $scope.show_events = ->
    $location.path "/events"      
        
  #$scope.logout = ->
  #  DataService.logout()

          
]