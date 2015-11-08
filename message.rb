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
    postures = wrong_posture(postures)
    "Correct your posture #{postures.join(', ')}"
  end

  def wrong_posture(postures)
    arr = []
    postures.each do |posture, value|
      if value
        arr.push(SECTIONS[posture])
      end
    end
    arr
  end

end