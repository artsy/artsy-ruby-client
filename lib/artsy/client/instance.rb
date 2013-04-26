# heavily inspired from https://github.com/sferik/twitter
module Artsy
  module Client
    class Instance
      include Artsy::Client::Configurable
      include Artsy::Client::API::System
      include Artsy::Client::API::Me
      include Artsy::Client::API::Artist

      # Initializes a new client instance
      #
      # @param options [Hash]
      # @return [Artsy::Client::Instance]
      def initialize(options={})
        Artsy::Client::Configurable.keys.each do |key|
          instance_variable_set(:"@#{key}", options[key] || Artsy::Client.instance_variable_get(:"@#{key}"))
        end
      end

      # Perform an HTTP DELETE request
      def delete(path, params = {})
        request(:delete, path, params)
      end

      # Perform an HTTP GET request
      def get(path, params = {})
        request(:get, path, params)
      end

      # Perform an HTTP POST request
      def post(path, params = {})
        signature_params = params.values.any?{|value| value.respond_to?(:to_io)} ? {} : params
        request(:post, path, params, signature_params)
      end

      # Perform an HTTP PUT request
      def put(path, params = {})
        request(:put, path, params)
      end

      def authenticate!
        configure!
        validate_credentials!
        if @client_id && @client_secret
          instance_variable_set :"@xapp_token", connection.send(:get, "/api/v1/xapp_token", { 
            client_id: @client_id,
            client_secret: @client_secret
          }).env[:body]["xapp_token"]
        end
      end

    private
    
      # Returns a proc that can be used to setup the Faraday::Request headers
      #
      # @param method [Symbol]
      # @param path [String]
      # @param params [Hash]
      # @return [Proc]
      def request_setup(method, path, params)
        Proc.new do |request|
          if @access_token
            request.headers["X_ACCESS_TOKEN"] = @access_token
          elsif @xapp_token
            request.headers["X_XAPP_TOKEN"] = @xapp_token
          end
        end
      end

      def request(method, path, params = {}, signature_params = params)
        request_setup = request_setup(method, path, params)
        connection.send(method.to_sym, path, params, &request_setup).env
      end

      # Returns a Faraday::Connection object
      #
      # @return [Faraday::Connection]
      def connection
        @connection ||= begin
          connection_options = { :builder => @middleware }
          connection_options[:ssl] = { :verify => true } if @endpoint[0..4] == 'https'
          Faraday.new(@endpoint, @connection_options.merge(connection_options))
        end
      end
    end
  end
end
