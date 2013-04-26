require 'bundler'
Bundler.setup(:default, :development)

require 'artsy-client'

Artsy::Client.authenticate!

Artsy::Client.artists({ :size => 3 }).each do |artist|
  puts "#{artist.name}, #{artist.years}"
end


