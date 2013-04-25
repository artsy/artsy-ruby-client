# heavily inspired from https://github.com/sferik/twitter

require 'i18n'

I18n.load_path << File.join(File.dirname(__FILE__), "config", "locales", "en.yml")

require 'forwardable'
require 'faraday'

require 'artsy/client/version'
require 'artsy/client/errors'
require 'artsy/client/base'
require 'artsy/client/response'
require 'artsy/client/default'
require 'artsy/client/configurable'
require 'artsy/client/instance'

module Artsy
  module Client
    class << self
      include Artsy::Client::Configurable

      # Delegate to a Artsy::Client::Instance
      #
      # @return [Artsy::Client::Instance]
      def instance
        @instance = Artsy::Client::Instance.new(options) unless defined?(@instance) && @instance.hash == options.hash
        @instance
      end

      def respond_to_missing?(method_name, include_private = false)
        instance.respond_to?(method_name, include_private)
      end if RUBY_VERSION >= "1.9"

      def respond_to?(method_name, include_private = false)
        instance.respond_to?(method_name, include_private) || super
      end if RUBY_VERSION < "1.9"

      private

        def method_missing(method_name, *args, &block)
          return super unless instance.respond_to?(method_name)
          instance.send(method_name, *args, &block)
        end

    end
  end
end

Artsy::Client.setup
