# SerialPort DOCS http://rubygems.org/gems/serialport
require 'serialport'
require 'pry'

# Open the comunication
sp = SerialPort.new("/dev/cu.RNBT-E153-RNI-SPP", 57600, 8, 1, SerialPort::NONE)

begin
  while true do
    while (i = sp.gets) do
        puts i
    end
  end
rescue SystemExit, Interrupt
  sp.close
rescue Exception => e
  puts e
end
