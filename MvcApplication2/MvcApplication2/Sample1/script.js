'use strict';

var $urlRouterProviderRef = null;
var $stateProviderRef = null;

var app = angular.module('nesting', [
  'ui.router'
]);

app.config(function( $urlRouterProvider, $stateProvider) {

    $urlRouterProvider.otherwise('/alpha');


    $stateProvider
      .state('main', {
          url: "",
          abstract: true,
          templateUrl: 'tpl.main.html',
      })
      .state('main.middle', {
          url: "",
          abstract: true,
          templateUrl: 'tpl.middle.html',
      })
      .state('main.middle.alpha', {
          url: "/alpha",
          templateUrl: 'tpl.leaf.html',
          controller: function ($scope, $state){
            $scope.state = $state.current;
          },
      })
      .state('main.middle.beta', {
          url: "/beta",
          templateUrl: 'tpl.leaf.html',
          controller: function ($scope, $state){
            $scope.state = $state.current;
          },
      })
      .state('main.middle.gama', {
          url: "/gama",
          templateUrl: 'tpl.leaf.html',
          controller: function ($scope, $state){
            $scope.state = $state.current;
          },
      })
      ;
});