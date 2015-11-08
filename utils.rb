class Utils

	def self.get_overall_score(values)
    score = 0
    values.each_with_index do |value, index|
      if index < 5
        score += 1 if value.to_i > 35
      end
    end
    score
  end

  def self.get_back_errors(top, middle, bottom)
    data = [top, middle, bottom]
    back = {:top => false, :middle => false, :bottom => false}
    
    if (data.max < 10)
      back = {:top => true, :middle => true, :bottom => true}
    end

    if (data.max > 10 && data.min < 10)
      if top < 10
        back[:top] = true
      end

      if middle < 10
        back[:middle] = true
      end

      if bottom < 10
        back[:bottom] = true
      end
    end

    if (data.max > 10 && data.min > 10)
      back = {:top => false, :middle => false, :bottom => false}
    end

    back
  end

  def self.get_seat_errors(left, right)
    seat_errors = {:left => false, :right => false}
      
    if left < 10
      seat_errors[:left] = true
    end

    if right < 10 
      seat_errors[:right] = true
    end

    seat_errors
  end
end
