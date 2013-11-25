require 'bundler'
Bundler.setup(:default, :development)

require 'artsy-client'

Artsy::Client.authenticate!

cursor = nil
3.times do
  r = Artsy::Client.featured_posts(cursor: cursor)
  r[:results].each do |post|
    puts "#{post.title} by #{post.author}"
  end
  cursor = r[:next]
  break unless cursor
end
