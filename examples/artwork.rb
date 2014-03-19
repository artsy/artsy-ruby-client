require 'bundler'
Bundler.setup(:default, :development)

require 'artsy_client'

Artsy::Client.authenticate!

andy_warhol_skull = Artsy::Client.artwork("andy-warhol-skull")
puts "#{andy_warhol_skull.title}, #{andy_warhol_skull.date} by #{andy_warhol_skull.artist.name}"
