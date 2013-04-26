$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'rspec'
require 'artsy-client'

require 'webmock/rspec'
WebMock.disable_net_connect!

require 'stubs'

require 'timecop'
