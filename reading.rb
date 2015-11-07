class Reading
  include Mongoid::Document
  field :top_back, type: Integer
  field :middle_back, type: Integer
  field :bottom_back, type: Integer
  field :left_seat, type: Integer
  field :right_seat, type: Integer
  field :angle, type: Integer
  field :timestamp, type: DateTime, default: DateTime.now
end