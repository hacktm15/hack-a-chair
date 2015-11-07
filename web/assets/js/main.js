angular.module('chair', [])
  .controller('MainController', ['$scope', function($scope){
    $scope.reads = {top_back: 0, middle_back: 0, bottom_back: 0, left_seat: 0, right_seat: 0, angle: 0};

    $scope.getState = function(value) {
      debugger
      return value < 100 ? 'red' : 'green';
    }

    Pusher.log = function(message) {
      if (window.console && window.console.log) {
        window.console.log(message);
      }
    };

    var pusher = new Pusher('a20f1cdf04ebda07f351', {
      encrypted: true
    });

    var channel = pusher.subscribe('sensors');
    channel.bind('read', function(data) {
      $scope.reads = data;
      process_data(data);
      console.log($scope.reads);
    });

    function process_data(data) {
      if(data.top_back > 100)
        $('.bad-position .tt').css('background-color', 'green');
      else 
        $('.bad-position .tt').css('background-color', 'red');

      if(data.middle_back > 100)
        $('.bad-position .tm').css('background-color', 'green');
      else 
        $('.bad-position .tm').css('background-color', 'red');

      if(data.bottom_back > 100)
        $('.bad-position .tb').css('background-color', 'green');
      else 
        $('.bad-position .tb').css('background-color', 'red');

      if(data.left_seat > 100)
        $('.bad-position .bl').css('background-color', 'green');
      else 
        $('.bad-position .bl').css('background-color', 'red');

      if(data.right_seat > 100)
        $('.bad-position .br').css('background-color', 'green');
      else 
        $('.bad-position .br').css('background-color', 'red');

      if (data.top_back > 100 && data.middle_back > 100 && data.bottom_back > 100 && data.left_seat > 100 && data.right_seat > 100)
        $(".bad-position img").attr("src", "assets/images/good.png");
      else 
        $(".bad-position img").attr("src", "assets/images/bad.png");

      // angular.element('.tm').style('background-color')
      // angular.element('.tb').style('background-color')
      // angular.element('.bl').style('background-color')
      // angular.element('.br').style('background-color')
    }

  }]);
