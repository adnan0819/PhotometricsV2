(function() {
   
    var app = angular.module('photoMetricsApp', ['ngRoute']);
    
    app.config(function($routeProvider) {
    
       $routeProvider
        .when('/', {
            controller: 'ImagesController',
            templateUrl: 'app/views/images.html'
       })
       .when('/images/:imageId', {
            controller: 'ResultsController',
            templateUrl: 'app/views/results.html'
       })
       .otherwise({ redirectTo: '/'});
        
    });
    
} ());
