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

  def self.posture_message(postures)
    arr = []
    postures.each do |posture, value|
      if value
        arr.push(SECTIONS[posture])
      end
    end

    "Correct your posture #{arr.join(', ')}"
  end

end