angular.module('chair', [])
  .controller('MainController', ['$scope', function($scope){
    $scope.reads = {top_back: 0, middle_back: 0, bottom_back: 0, left_seat: 0, right_seat: 0, angle: 0};

    $scope.getState = function(value) {
      return value < 100 ? 'red' : 'green';
    }

    $scope.your_image = "assets/images/good.png";

    $scope.$watch('reads', function(newVal){
      // if (newVal) {
      //   if (newVal.top_back == 0 && newVal.middle_back == 0 && newVal.bottom_back == 0 && newVal.left_seat == 0 && newVal.right_seat == 0) {
      //     $scope.your_image = "assets/images/empty.png";
      //   } else {
      //     $scope.your_image = "assets/images/good.png";
      //   }
      // } 
    });

    var socket = io('http://localhost:3000');

    socket.on('front:update', function(data){
      console.log(data);
      $scope.reads = JSON.parse(data.sensor_data);
      process_data($scope.reads);
    })

    function process_leds(data) {
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
    }

    function notOnChair(data) {
      return data.top_back < 30 && data.middle_back < 30 && data.bottom_back < 30 && data.left_seat < 30 && data.right_seat < 30;
    }

    function process_data(data) {
      process_leds(data);
      
      if ((data.angle < 130 || data.angle > 160) && !notOnChair(data)) {
        $(".bad-position img").attr("src", "assets/images/adjust_spatar.svg");
      } else if (notOnChair(data)) {
        $(".bad-position img").attr("src", "assets/images/empty.svg");
      }  else if (data.top_back < 30 || data.middle_back < 30 || data.bottom_back < 30 ) {
        $(".bad-position img").attr("src", "assets/images/chair_w.svg");
      } else if (data.left_seat < 30 || data.right_seat < 30) {
        $(".bad-position img").attr("src", "assets/images/foot_w.svg");
      } else {
        $(".bad-position img").attr("src", "assets/images/good.svg");
      }
    }

  }]);
