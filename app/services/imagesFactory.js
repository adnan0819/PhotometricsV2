(function() {
    var imagesFactory = function($http) {
        
        var factory = {};
        
        factory.getImages = function(){
            return $http.get('/images');
        };
        
        factory.getImage = function(imageId) {
            return $http.get('/images/' + imageId);
        }
        
        return factory;
    };
    
    imagesFactory.$inject = ['$http'];
    
    angular.module('photoMetricsApp').factory('imagesFactory', imagesFactory);
    
}());