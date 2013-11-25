require 'bundler'
Bundler.setup(:default, :development)

require 'artsy-client'

Artsy::Client.authenticate!

Artsy::Client.autocomplete('andy warhol').each do |search_query|
  puts search_query.query.downcase
end
