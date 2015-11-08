require 'libnotify'

class Notification

  def self.show_notification(title, message)
    Libnotify.show(
        :body    => message,
        :summary => title,
        :timeout => 1.5
    )
  end
end