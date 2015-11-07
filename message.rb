class Message
  TOP    = 'cervical'
  MIDDLE = 'thoracic'
  BOTTOM = 'lumbar zone'
  LEFT   = 'left leg'
  RIGHT  = 'right leg'

  SECTIONS = {
      :top    => TOP,
      :middle => MIDDLE,
      :bottom => BOTTOM,
      :left   => LEFT,
      :right  => RIGHT
  }

  def self.fix_position(positions)
    test = []
    positions.each do |position, value|
      if value
        test.push(SECTIONS[position])
      end
    end
    "Correct your posture #{test.join(', ')}"
  end

end