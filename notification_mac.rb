require 'terminal-notifier'

class NotificationMac

  def send(title, message, link = nil, picture= nil)
    TerminalNotifier.notify(
        message,
        :title   => title,
        :open    => link,
        :appIcon => picture
    )
  end

end