require 'bundler'
Bundler.setup(:default, :development)

require 'artsy_client'

Artsy::Client.authenticate!

cursor = nil
3.times do
  options = {}
  options[:cursor] = cursor if cursor
  r = Artsy::Client.featured_posts(options)
  r[:results].each do |post|
    puts "#{post.title} by #{post.author}"
  end
  cursor = r[:next]
  break unless cursor
end
