'use strict'

# Declare app level module which depends on filters, and services
angular.module("app", ["app.filters", "app.directives", "ngRoute"]).
  config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
    $routeProvider
      .when "/",
        templateUrl: "partials/home"
        controller: 'HomeController'
                  
      .otherwise
        template: '<div class="alert alert-error">Sorry, the requested page does not exist.</div>'
  
    $locationProvider.html5Mode true
  ]