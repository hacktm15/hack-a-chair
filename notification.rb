require './os'
class Notification

  def send(title, message, link = nil, picture= nil)
    if Os.mac?
      exec(build_mac_notification(title, message, link, picture))
    elsif Os.linux?
      exec(build_notification(title, message, picture))
    elsif Os.windows?
      # NotImplementedError
      exec(build_notification(title, message, picture))
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

  def build_notification(title, message, picture = nil)
    command = "notify-send #{title} #{message} "
    if picture
      command += "--icon #{picture}"
    end
  end

end

#absolute url for images
#for ubuntu local image mandatory, does not work well for remote pictures

a = Notification.new
a.send('Hack-A-Chair', 'Whatever', 'http://google.com', 'http://alturl.com/wjdmg')
a.send('Hack-A-Chair', 'Whatever', 'http://google.com', '/home/lavinia/projects/hack-a-chair/test.ico')