angular.module('chair', [])
  .controller('MainController', ['$scope', function($scope){
    // default variable
    $scope.reads = {top_back: 0, middle_back: 0, bottom_back: 0, left_seat: 0, right_seat: 0, angle: 0};
    $scope.your_image = "assets/images/good.png";
    var socket = io('http://localhost:3000');
    var isNotOnChair = false;

    // Images 
    var spatar_w = "assets/images/adjust_spatar.svg";
    var empty = "assets/images/empty.svg";
    var chair_w = "assets/images/chair_w.svg";
    var foot_w = "assets/images/foot_w.svg";
    var good = "assets/images/good.svg";

    // ranges
    var angle_left_bound = 130;
    var angle_right_bound = 160;
    var error_range = 30;

    $scope.getState = function(value) {
      return isNotOnChair ? '#cacaca' : value < error_range ? 'red' : 'green';
    }

    socket.on('front:update', function(data){
      console.log(data);
      $scope.reads = JSON.parse(data.sensor_data);
      process_data($scope.reads);
      $scope.$apply();
    });

    function notOnChair(data) {
      return (data.top_back < error_range && data.middle_back < error_range && data.bottom_back < error_range && data.left_seat < error_range && data.right_seat < error_range);
    }

    function backError(data) {
      return data.top_back < error_range || data.middle_back < error_range || data.bottom_back < error_range;
    }

    function seatError(data) {
      return data.left_seat < error_range || data.right_seat < error_range;
    }

    function process_data(data) {
      isNotOnChair = false;
      
      if ((data.angle < angle_left_bound || data.angle > angle_right_bound) && !notOnChair(data)) {
        $(".bad-position img").attr("src", spatar_w);
      } else if (notOnChair(data)) {
        isNotOnChair = true;
        $(".bad-position img").attr("src", empty);
      }  else if (backError(data) ) {
        $(".bad-position img").attr("src", chair_w);
      } else if (seatError(data)) {
        $(".bad-position img").attr("src", foot_w);
      } else {
        $(".bad-position img").attr("src", good);
      }
    }

  }]);
