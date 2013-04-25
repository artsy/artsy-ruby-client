# heavily inspired from https://github.com/sferik/twitter

require 'faraday'
require 'multi_json'
require 'base64'
require 'uri'

module Artsy
  module Client
    class Instance
      include Artsy::Client::Configurable

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
      def delete(path, params={})
        request(:delete, path, params)
      end

      # Perform an HTTP GET request
      def get(path, params={})
        request(:get, path, params)
      end

      # Perform an HTTP POST request
      def post(path, params={})
        signature_params = params.values.any?{|value| value.respond_to?(:to_io)} ? {} : params
        request(:post, path, params, signature_params)
      end

      # Perform an HTTP PUT request
      def put(path, params={})
        request(:put, path, params)
      end

    private
      # Returns a proc that can be used to setup the Faraday::Request headers
      #
      # @param method [Symbol]
      # @param path [String]
      # @param params [Hash]
      # @return [Proc]
      def request_setup(method, path, params)
        # TODO
      end

      def request(method, path, params={}, signature_params=params)
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
