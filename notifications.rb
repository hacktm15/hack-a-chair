require 'libnotify'

class Notification

  def take_a_walk
      show_notification(
          "Take a walk. You've spent 50 minutes on your computer",
          "You should"
      )
  end

  def correct_your_legs
    show_notification(
        "Correct your legs position",
        "You should"
    )
  end

  def correct_your_back
    show_notification(
        "Correct your back position",
        "You should"
    )
  end

  def show_notification(message, summary)
    Libnotify.show(
        :body    => message,
        :summary => summary,
        :timeout => 2.5
    )
  end
end

# a = Notification.new
# a.correct_your_legs