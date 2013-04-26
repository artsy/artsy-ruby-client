require 'bundler'
Bundler.setup(:default, :development)

require 'artsy-client'

Artsy::Client.authenticate!

Artsy::Client.artists({ :size => 3 }).each do |artist|
  puts "#{artist.name}, #{artist.years}"
  artist.artworks({ :size => 3 }).each do |artwork|
    puts "  #{artwork.title}, #{artwork.date}"
  end
end


