require 'bundler'
Bundler.setup(:default, :development)

require 'artsy-client'

Artsy::Client.authenticate!

art21 = Artsy::Client.profile("art21")
puts "#{art21.owner.name}: #{art21.short_description}"
