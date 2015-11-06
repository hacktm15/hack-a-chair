# SerialPort DOCS http://rubygems.org/gems/serialport
require 'serialport'
require 'em-websocket'
require 'json'
require 'sqlite3'

index = 0
values = []
isSequence = false

# Open a database
db = SQLite3::Database.new "stats.db"

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


# Database methods
def store_values(values)
  string = values.split(' ')
  db.execute('INSERT INTO chair_reads (val) 
            VALUES (?)', [string])
end

def create_table()
  rows = db.execute <<-SQL
    create table chair_reads (
      val string
    );
  SQL
end

def get_from_db
  rows = []
  db.execute( "select * from numbers" ) do |row|
    values << row
  end
  rows
end
