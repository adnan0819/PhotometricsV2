(function(){
    
    var ResultsController = function($scope, $routeParams, imagesFactory) {

        var imageId = $routeParams.imageId;
        $scope.image = null;
        
        var socket = null;
        
        function init() {
            socket = io.connect();
            
            imagesFactory.getImage(imageId)
                .success(function(image) {
                    $scope.image = image;
                })
                .error(function(data, status, headers, config) {
                    // handle error
                });
        }
        
        init();
        
        socket.on('updated', function(data) {
            $scope.$apply(function(){
                $scope.data = data;
            });
        });
        
    };
    
    ResultsController.$inject = ['$scope', '$routeParams', 'imagesFactory'];
    
    angular.module('photoMetricsApp').controller('ResultsController', ResultsController);
    
} ());