# SerialPort DOCS http://rubygems.org/gems/serialport
require 'serialport'
require 'em-websocket'
require 'json'

index = 0
values = []
isSequence = false

# Open the comunication
serial = SerialPort.new("/dev/cu.Bluetooth-Incoming-Port", 9600, 8, 1, SerialPort::NONE)

EventMachine::WebSocket.start(:host => '0.0.0.0', :port => 8080) do |ws|
  ws.onopen    { ws.send "WebSocket opened" }
  ws.onclose   { puts "WebSocket closed" }
 
  while true do 
    while (message = serial.gets) do
      message.chop!
      # push the data inside the array
      # if in a sequence
      if isSequence 
        values << message.to_i
      end

      # started a sequence
      if message == 'BEGIN' 
        isSequence = true
      end

      # ended the sequence
      if message == 'END'
        isSequence = false
        send_message(ws) 
      end
    end
  end
end

def send_message(ws) 
  object = { presure_sensors: values }
  ws.send onject.to_json
end
