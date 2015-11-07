require 'terminal-notifier'

class NotificationMac

  def send(message, link = nil, picture= nil)
    TerminalNotifier.notify(
        message,
        :title => 'ChairAware',
        :open  => link,
        :appIcon => picture
    )
  end

end