require 'bundler'
Bundler.setup(:default, :development)

require 'artsy-client'

puts "Artsy up? => #{Artsy::Client.up?}"
puts "Artsy website up? => #{Artsy::Client.up.rails?}"
