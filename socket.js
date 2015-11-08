var express = require('express');  
var app = express();  
var server = require('http').createServer(app);  
var io = require('socket.io')(server);

io.on('connection', function(socket){

  console.log("connected");

  socket.on('read', function(data){
    socket.broadcast.emit('front:update', data);
    console.log(data);
  });

});

server.listen(3000);
