# heavily inspired from https://github.com/sferik/twitter

module Artsy
  module Client
    module Configurable
      extend Forwardable

      attr_writer :access_token
      attr_accessor :endpoint, :connection_options, :middleware
      def_delegator :options, :hash

      class << self

        def keys
          @keys ||= [
            :access_token,
            :endpoint,
            :connection_options,
            :middleware,
          ]
        end

      end

      def configure
        yield self
        validate_credentials!
        self
      end

      def reset!
        Artsy::Client::Configurable.keys.each do |key|
          instance_variable_set(:"@#{key}", Artsy::Client::Default.options[key])
        end
        self
      end

      alias setup reset!

    private

      def options
        Hash[Artsy::Client::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
      end

      def validate_credentials!
        raise Artsy::Client::Errors::ConfigurationError.new({ :key => 'access_token' }) unless @access_token && @access_token.to_s.length > 0
      end

    end
  end
end
