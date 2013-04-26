require 'bundler'
Bundler.setup(:default, :development)

require 'artsy-client'

Artsy::Client.authenticate!

andy_warhol = Artsy::Client.artist("andy-warhol")
puts "#{andy_warhol.name}, #{andy_warhol.years}"

