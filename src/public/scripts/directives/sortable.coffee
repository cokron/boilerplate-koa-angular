"use strict"
app = angular.module('app.directives')

app.directive "sortable", ["$compile", ($compile) ->
    transclude: true

    restrict: "A"

    scope:
      columnKey: '@'
      orderByField: '='
      reverseSort: '='

    template: "<span ng-click=\"sort()\" >" +
              "  <span ng-transclude></span>" +
              "  <span ng-show=\"orderByField == '{{columnKey}}'\">" +
              "    <span ng-show=\"!reverseSort\">&#x25BC;</span>" +
              "    <span ng-show=\"reverseSort\">&#x25B2;</span>" +
              "  </span>" +
              "</span>"

    link: ($scope, element, attrs) ->
      $scope.sort = (columnKey) ->
        if $scope.orderByField == $scope.columnKey
          if !$scope.reverseSort
            $scope.reverseSort = true
          else #remove ordering
            $scope.reverseSort = false
            $scope.orderByField = "created_at"  #null
        else # initial     
          $scope.orderByField = $scope.columnKey
          $scope.reverseSort = false
]  
