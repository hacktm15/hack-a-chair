$(document).ready(function() {
    ws = new WebSocket("ws://localhost:8080");

    ws.onopen = function() {
        ws.send("hello server");
    };
 
    ws.onmessage = function(event) {
        var message = JSON.parse(event.data);
        // ws.send("next message please!");
    }
});
