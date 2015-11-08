angular.module('chair', [])
  .controller('MainController', ['$scope', function($scope){
    $scope.reads = {top_back: 0, middle_back: 0, bottom_back: 0, left_seat: 0, right_seat: 0, angle: 0};

    $scope.getState = function(value) {
      return value < 100 ? 'red' : 'green';
    }

    var socket = io('http://localhost:3000');

    socket.on('front:update', function(data){
      console.log(data);
      $scope.reads = JSON.parse(data.sensor_data);
      process_data($scope.reads);
    })

    function process_data(data) {
      if(data.top_back > 0)
        $('.bad-position .tt').css('background-color', 'green');
      else 
        $('.bad-position .tt').css('background-color', 'red');

      if(data.middle_back > 35)
        $('.bad-position .tm').css('background-color', 'green');
      else 
        $('.bad-position .tm').css('background-color', 'red');

      if(data.bottom_back > 35)
        $('.bad-position .tb').css('background-color', 'green');
      else 
        $('.bad-position .tb').css('background-color', 'red');

      if(data.left_seat > 35)
        $('.bad-position .bl').css('background-color', 'green');
      else 
        $('.bad-position .bl').css('background-color', 'red');

      if(data.right_seat > 35)
        $('.bad-position .br').css('background-color', 'green');
      else 
        $('.bad-position .br').css('background-color', 'red');

      if (data.top_back > 0 && data.middle_back > 35 && data.bottom_back > 35 && data.left_seat > 35 && data.right_seat > 35)
        $(".bad-position img").attr("src", "assets/images/good.png");
      else 
        $(".bad-position img").attr("src", "assets/images/bad.png");
    }

  }]);
