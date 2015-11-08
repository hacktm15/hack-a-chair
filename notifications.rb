require 'libnotify'

class Notification

  def show_notification(title, message)
    Libnotify.show(
        :body    => message,
        :summary => title,
        :timeout => 1.5
    )
  end
end

# a = Notification.new
# a.fix_position({:top => true, :middle => false, :bottom => true})
# b = Notification.new
# b.fix_position({:left => true, :right => true})