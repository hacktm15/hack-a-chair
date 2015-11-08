# tt,tm,tb,bl,br

	# tt

	# tm

	# tb
 #  bl   br

require 'serialport'

port_str = '/dev/rfcomm0' 
baud_rate = 57600
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE
 
sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

begin
	while true do
		while (data = sp.gets) do
	    	puts data
		end
	end
rescue SystemExit, Interrupt
  	sp.close
rescue Exception => e
  	puts e.backtrace
  	raise e
  	sp.close
end
