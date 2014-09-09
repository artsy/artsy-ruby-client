Artsy::Client [![Build Status](https://travis-ci.org/artsy/artsy-ruby-client.png?branch=master)](https://travis-ci.org/artsy/artsy-ruby-client) [![Code Climate](https://codeclimate.com/github/artsy/artsy-ruby-client.png)](https://codeclimate.com/github/artsy/artsy-ruby-client)
===============

A Ruby client for the [Artsy](http://artsy.net) APIv1.

Important
=========

This project is obsolete. We have since released a public API that no longer requires a specific artsy-ruby-client gem. Check out our public API at [developers.artsy.net](https://developers.artsy.net).

Getting Started
===============

``` ruby
require 'artsy_client'
```

Authenticate with a client ID and secret.

``` ruby
Artsy::Client.configure do |config|
  config.client_id = ...
  config.client_secret = ...
end

Artsy::Client.authenticate! # retrieves a short lived xapp_token
```

Alternatively, if you have an access token granted for offline access.

``` ruby
Artsy::Client.configure do |config|
  config.access_token = ... # access token granted for offline access
end
```

This token lasts for 25 years and can be obtained from the command-line.

```
curl -v "https://artsy.net/oauth2/access_token
  ?client_id=...
  &client_secret=...
  &email=...
  &password=...
  &grant_type=credentials
  &scope=offline_access"
```

The client also supports logging in with a username and password, however, using credentials sent in plain-text is not recommended.

``` ruby
Artsy::Client.configure do |config|
  config.client_id = ...
  config.client_secret = ...
  config.user_email = ...
  config.user_password = ...
end

Artsy::Client.authenticate! # retrieves a short lived access_token
```

Is Artsy Up?
------------

``` ruby
Artsy::Client.up?
```

Who am I logged in as?
----------------------

``` ruby
me = Artsy::Client.me
puts "#{me.name} <#{me.email}> (#{me.id})"
```

Andy Warhol
-----------

``` ruby
# an artist
andy_warhol = Artsy::Client.artist("andy-warhol")
puts "#{andy_warhol.name}, #{andy_warhol.years}"

# an artwork by Andy Warhol
andy_warhol_skull = Artsy::Client.artwork("andy-warhol-skull")
puts "#{andy_warhol_skull.title}, #{andy_warhol_skull.date} by #{andy_warhol_skull.artist.name}"

# 3 works by Andy Warhol
andy_warhol.artworks({ :size => 3 }).each do |artwork|
  puts "#{artwork.title}, #{artwork.date}"
end
```

Creating and Updating Artworks
------------------------------

Artworks must be created before they can be published.

```ruby
artwork = Artsy::Client.create_artwork(title: 'Mona Lisa')
Artsy::Client.update_artwork(artwork.id, private: false, published: true)
```

Shows
-----

Shows can be returned in a virtually infinite feed. Each response contains a set of results and a cursor for the next query.

``` ruby
cursor = nil
3.times do
  options = {}
  options[:cursor] = cursor if cursor
  r = Artsy::Client.shows_feed(options)
  r[:results].each do |show|
    puts "#{show.name}"
    show.artworks.each do |artwork|
      puts "  #{artwork.title}, #{artwork.date}"
    end
  end
  cursor = r[:next]
  break unless cursor
end
```

You can retrieve a sample show.

``` ruby
Artsy::Client.shows(sample: 1, status: :current, published_with_eligible_artworks: true).each do |show|
  puts "#{show.name} at #{show.partner.name}"
end
```

Featured Posts
--------------

Featured posts can be returned in a virtually infinite feed. Each response contains a set of results and a cursor for the next query.

``` ruby
cursor = nil
3.times do
  options = {}
  options[:cursor] = cursor if cursor
  r = Artsy::Client.featured_posts(options)
  r[:results].each do |post|
    puts "#{post.title}"
  end
  cursor = r[:next]
  break unless cursor
end
```

Autocomplete
------------

Autocomplete search terms.

``` ruby
Artsy::Client.autocomplete('andy warhol').each do |search_query|
  puts search_query.query
end
```

Pages
-----

Create content pages.

```ruby
Artsy::Client.create_page(name: 'About', content: 'Foo bar baz.', published: true)
```

Logging
-------

Setup verbose logging.

``` ruby
Artsy::Client.configure do |config|
  config.logger = Logger.new(STDOUT)
  config.logger.level = Logger::DEBUG
end
```

Contributing
------------

Fork the project. Make your feature addition or bug fix with tests. Send a pull request. Bonus points for topic branches.

Copyright and License
---------------------

MIT License, see [LICENSE](http://github.com/dblock/mongoid-scroll/raw/master/LICENSE.md) for details.

(c) 2013 [Daniel Doubrovkine](http://github.com/dblock), [Artsy Inc.](http://artsy.net)
