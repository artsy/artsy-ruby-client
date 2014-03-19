require 'bundler'
Bundler.setup(:default, :development)

require 'artsy_client'

Artsy::Client.authenticate!

Artsy::Client.recently_published_artworks(size: 5).each do |artwork|
  puts "#{artwork.title}, #{artwork.date} by #{artwork.artist.name}"
end
