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

Artsy::Client.configure do |config|
  config.access_token = ...
end
```

Is Artsy Up?
------------

``` ruby
Artsy::Client.up?
```

Who am I logged in as?
----------------------

```
me = Artsy::Client.me
puts "User: #{me.name} <#{me.email}> (#{me.id})"
```

Contributing
------------

Fork the project. Make your feature addition or bug fix with tests. Send a pull request. Bonus points for topic branches.

Copyright and License
---------------------

MIT License, see [LICENSE](http://github.com/dblock/mongoid-scroll/raw/master/LICENSE.md) for details.

(c) 2013 [Daniel Doubrovkine](http://github.com/dblock), [Artsy Inc.](http://artsy.net)
