Artsy::Client [![Build Status](https://travis-ci.org/artsy/artsy-ruby-client.png?branch=master)](https://travis-ci.org/artsy/artsy-ruby-client)
===============

A Ruby client for the [Artsy](http://artsy.net) API.

Important
=========

This is work in progress. Unfortunately, due to copyright issues we cannot let people use our API to display artworks anywhere outside of the Artsy site. We're working on it. Please email engineering@artsy.net if you would like to be notified when we launch our API program.

Getting Started
===============

``` ruby
require 'artsy-client'
```

Authenticate with a client ID and secret.

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
andy_warhol = Artsy::Client.artist("andy-warhol")
puts "#{andy_warhol.name}, #{andy_warhol.years}"
```

Contributing
------------

Fork the project. Make your feature addition or bug fix with tests. Send a pull request. Bonus points for topic branches.

Copyright and License
---------------------

MIT License, see [LICENSE](http://github.com/dblock/mongoid-scroll/raw/master/LICENSE.md) for details.

(c) 2013 [Daniel Doubrovkine](http://github.com/dblock), [Artsy Inc.](http://artsy.net)
