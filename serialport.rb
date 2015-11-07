# tt,tm,tb,bl,br

	# tt

	# tm

	# tb
 #  bl   br

require 'serialport'
require 'active_support'
require 'pry'
require 'mongoid'
require 'em-websocket'
require_relative 'utils'
require_relative 'reading'

PERMITTED_RANGE = 10
ANGLE = 165..190

Mongoid.load!("mongoid.yml", :development)

port_str = '/dev/rfcomm0' 
baud_rate = 57600
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE

sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

begin
  while true do
    while (data = sp.gets) do
      begin
        sensor_data = data.split(',')
      rescue ArgumentError
        next
      end
      time_now = Time.now

      tt = sensor_data[0].to_i
      tm = sensor_data[1].to_i      
      tb = sensor_data[2].to_i
      bl = sensor_data[3].to_i
      br = sensor_data[4].to_i
      angle = sensor_data[5].to_i

      Reading.create(top_back: tt, middle_back: tm, bottom_back: tb, left_seat: bl, right_seat: br, angle: angle)

      back_errors = Utils.get_back_errors(sensor_data[0].to_i, sensor_data[1].to_i, sensor_data[2].to_i)

      if back_errors.key(true)
        puts "back_error!"
      end

      seat_errors = Utils.get_seat_errors(sensor_data[3].to_i, sensor_data[4].to_i)
      if seat_errors.key(true)
        puts "seat_errors!"
      end

      unless ANGLE.include? sensor_data[5]
        puts "angle error! #{sensor_data[5]}"
      end

      score = Utils.get_overall_score(sensor_data)

      if score >= 1 
        sit_time ||= time_now
        if (time_now - sit_time).to_i > 10
          stand_time = nil
          puts "siting"
        end

        if (time_now - sit_time).to_i > 30
          puts "take a break"
        end
      else
        stand_time ||= time_now
        if (time_now - stand_time).to_i > 10
          sit_time = nil
          puts "standing"
        end
      end
    end
  end
rescue SystemExit, Interrupt
  sp.close
rescue Exception => e
  puts e.backtrace
  raise e
  sp.close
end