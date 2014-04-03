# heavily inspired from https://github.com/sferik/twitter
module Artsy
  module Client
    class Instance
      include Artsy::Client::Configurable
      include Artsy::Client::API::Artist
      include Artsy::Client::API::Artwork
      include Artsy::Client::API::ArtworkInquiryRequest
      include Artsy::Client::API::DelayedTask
      include Artsy::Client::API::Feature
      include Artsy::Client::API::Gene
      include Artsy::Client::API::Invoice
      include Artsy::Client::API::Match
      include Artsy::Client::API::Me
      include Artsy::Client::API::Order
      include Artsy::Client::API::OrderedSet
      include Artsy::Client::API::Page
      include Artsy::Client::API::Partner
      include Artsy::Client::API::Post
      include Artsy::Client::API::Profile
      include Artsy::Client::API::Sale
      include Artsy::Client::API::SaleArtwork
      include Artsy::Client::API::SearchQuery
      include Artsy::Client::API::Show
      include Artsy::Client::API::Show::Feed
      include Artsy::Client::API::System
      include Artsy::Client::API::Tag
      include Artsy::Client::API::User

      # Initializes a new client instance
      #
      # @param options [Hash]
      # @return [Artsy::Client::Instance]
      def initialize(options = {})
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
        signature_params = params.values.any? { |value| value.respond_to?(:to_io) } ? {} : params
        request(:post, path, params, signature_params)
      end

      # Perform an HTTP PUT request
      def put(path, params = {})
        request(:put, path, params)
      end

      def authenticate!
        configure!
        validate_credentials!
        if @user_email && @user_password && @client_id && @client_secret
          @logger.debug "GET /oauth2/access_token?client_id=#{CGI.escape(@client_id)}&client_secret=#{CGI.escape(@client_secret)}&email=#{CGI.escape(@user_email)}&password=********&grant_type=credentials" if @logger
          @access_token = connection.send(:get, "/oauth2/access_token",
                                          client_id: @client_id,
                                          client_secret: @client_secret,
                                          email: @user_email,
                                          password: @user_password,
                                          grant_type: :credentials
          ).env[:body]["access_token"]
        elsif @client_id && @client_secret
          @logger.debug "GET /api/v1/xapp_token?client_id=#{CGI.escape(@client_id)}&client_secret=#{CGI.escape(@client_secret)}" if @logger
          @xapp_token = connection.send(:get, "/api/v1/xapp_token",
                                        client_id: @client_id,
                                        client_secret: @client_secret
          ).env[:body]["xapp_token"]
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
        proc do |request|
          if @access_token
            request.headers["X-ACCESS-TOKEN"] = @access_token
          elsif @xapp_token
            request.headers["X-XAPP-TOKEN"] = @xapp_token
          end
          if @logger
            params_s = ("?" + params.select { |k, v| k }.map { |k, v|
              "#{k}=#{CGI.escape(v.to_s)}"
            }.join("&")) if params.any?
            @logger.info "#{method.upcase} #{path}#{params_s}"
            request.headers.each_pair do |k, v|
              @logger.debug " #{k}: #{v}"
            end
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
          connection_options = { builder: @middleware }
          connection_options[:ssl] = { verify: true } if @endpoint[0..4] == 'https'
          Faraday.new(@endpoint, @connection_options.merge(connection_options))
        end
      end
    end
  end
end
