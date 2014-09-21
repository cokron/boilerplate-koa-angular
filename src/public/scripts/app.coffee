'use strict'
# declaring modules here, so that we can split the implementation into different files
angular.module('app.filters', [])
angular.module('app.directives', [])

app = angular.module("app", ["app.filters", "app.directives", "ngRoute"])

app.config ($routeProvider, $locationProvider) ->
  $routeProvider
    .when "/",
      templateUrl: "partials/home"
      controller: 'HomeController'
                
    .otherwise
      template: '<div class="alert alert-error">Sorry, the requested page does not exist.</div>'
  
  $locationProvider.html5Mode true
