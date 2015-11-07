require 'libnotify'

class Notification

  def show_notification(message, title)
    Libnotify.show(
        :body    => message,
        :summary => title,
        :timeout => 1
    )
  end
end

# a = Notification.new
# a.fix_position({:top => true, :middle => false, :bottom => true})
# b = Notification.new
# b.fix_position({:left => true, :right => true})