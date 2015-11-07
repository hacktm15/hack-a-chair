require 'libnotify'

class Notification
  DEFAULT_TIME = 50

  def check_user_status(time_spent)
    if time_spent > DEFAULT_TIME
      Libnotify.show(
          :body    => "Take a walk. You've spent #{time_spent} minutes on your computer",
          :summary => "You should",
          :timeout => 2.5
      )
    end
  end

end