# heavily inspired from https://github.com/sferik/twitter

module Artsy
  module Client
    module Configurable
      extend Forwardable

      attr_writer :access_token, :xapp_token, :client_id, :client_secret
      attr_accessor :endpoint, :connection_options, :middleware, :logger
      def_delegator :options, :hash

      class << self
        def keys
          @keys ||= [
            :access_token,
            :xapp_token,
            :client_id,
            :client_secret,
            :endpoint,
            :connection_options,
            :middleware,
            :logger
          ]
        end
      end

      def configure
        yield self if block_given?
        validate_credentials!
        self
      end

      alias_method :configure!, :configure

      def reset!
        Artsy::Client::Configurable.keys.each do |key|
          instance_variable_set(:"@#{key}", Artsy::Client::Default.options[key])
        end
        self
      end

      alias_method :setup, :reset!

      private

      def options
        Hash[Artsy::Client::Configurable.keys.map { |key| [key, instance_variable_get(:"@#{key}")] }]
      end

      def validate_credentials!
        if @access_token
          # access token gives a user login
        elsif @client_id && @client_secret
          # client id and secret give access to an xapp token
        else
          raise Artsy::Client::Errors::MissingCredentialsError.new
        end
      end
    end
  end
end
