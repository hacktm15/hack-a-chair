require './os'
class Notification

  #absolute url for images

  def send(title, message, link = nil, picture= nil)
    if Os.mac?
      exec(build_mac_notification(title, message, link, picture))
    elsif Os.linux?
      exec(build_ubuntu_notification(title, message, picture))
    elsif Os.windows?
      exec(build_win_notification(title, message, picture))
    end
  end

  def build_mac_notification(title, message, link = nil, picture = nil)
    command = "terminal-notifier -title #{title} -message #{message} "
    if link
      command += "-open #{link} "
    end
    if picture
      command += "-contentImage #{picture}"
    end
  end

  def build_ubuntu_notification(title, message, picture = nil)
    command = "notify-send #{title} #{message} "
    if picture
      command += "-i #{picture}"
    end
  end

  def build_win_notification(title, message, picture = nil)

  end

end

a = Notification.new
a.send('Hack-A-Chair', 'Whatever', 'http://google.com', 'http://alturl.com/wjdmg')