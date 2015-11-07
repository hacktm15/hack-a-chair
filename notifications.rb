require 'libnotify'
Libnotify.show(:body => "hello", :summary => "world", :timeout => 2.5)