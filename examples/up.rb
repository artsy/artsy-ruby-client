require 'bundler'
Bundler.setup(:default, :development)

require 'artsy_client'

puts "Artsy up? => #{Artsy::Client.up?}"
puts "Artsy website up? => #{Artsy::Client.up.rails?}"
