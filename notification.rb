class Notification
  def send(message, link = nil, picture= nil)
    if OS.windows? || OS.linux?
      raise NotImplementedError
    end
    else if OS.mac?
      notify = new NotificationMac
      notify.send(message, link, picture)
    end
  end

  def OS.windows?
    (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  end

  def OS.mac?
    (/darwin/ =~ RUBY_PLATFORM) != nil
  end

  def OS.unix?
    !OS.windows?
  end

  def OS.linux?
    OS.unix? and not OS.mac?
  end

end