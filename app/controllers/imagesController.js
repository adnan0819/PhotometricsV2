(function(){
    
    var ImagesController = function($scope, imagesFactory) {

        $scope.images = [];
        
        function init() {
            imagesFactory.getImages()
                .success(function(images) {
                    $scope.images = images;
                })
                .error(function(data, status, headers, config) {
                    // handle error
                });
        }
        
        init();
    };
    
    ImagesController.$inject = ['$scope', 'imagesFactory'];
    
    angular.module('photoMetricsApp').controller('ImagesController', ImagesController);
    
} ());
