require 'bundler'
Bundler.setup(:default, :development)

require 'artsy_client'

me = Artsy::Client.me
puts "User: #{me.name} <#{me.email}> (#{me.id})"
