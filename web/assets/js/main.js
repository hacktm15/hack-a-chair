angular.module('chair', [])
  .controller('MainController', ['$scope', function($scope){
    $scope.reads = [0, 555, 555, 555, 555];

    $scope.getState = function(value) {
      return value < 100 ? 'red' : 'green';
    }

  }]);
