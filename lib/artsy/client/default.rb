# heavily inspired from https://github.com/sferik/twitter

module Artsy
  module Client
    module Default
      ENDPOINT = 'https://artsyapi.com' unless defined? Artsy::Client::Default::ENDPOINT

      CONNECTION_OPTIONS = {
        headers: {
          accept: 'application/json',
          user_agent: "Artsy Client Ruby Gem #{Artsy::Client::VERSION}"
        },
        request: {
          open_timeout: 5,
          timeout: 10
        },
        ssl: {
          verify: false
        }
      } unless defined? Artsy::Client::Default::CONNECTION_OPTIONS

      MIDDLEWARE = Faraday::RackBuilder.new do |builder|
        # Checks for files in the payload
        builder.use Faraday::Request::Multipart
        # Convert request params to "www-form-urlencoded"
        builder.use Faraday::Request::UrlEncoded
        # Handle 4xx server responses
        builder.use Artsy::Client::Response::RaiseError
        # Parse JSON response bodies using MultiJson
        builder.use Artsy::Client::Response::ParseJson
        # Handle 5xx server responses
        builder.use Artsy::Client::Response::RaiseError
        # Set Faraday's HTTP adapter
        builder.adapter Faraday.default_adapter
      end unless defined? Artsy::Client::Default::MIDDLEWARE

      class << self
        # @return [Hash]
        def options
          Hash[Artsy::Client::Configurable.keys.map { |key| [key, send(key)] }]
        end

        # @return [String]
        def access_token
          ENV['ARTSY_API_ACCESS_TOKEN']
        end

        # @return [String]
        def xapp_token
          ENV['ARTSY_API_XAPP_TOKEN']
        end

        # @return [String]
        def client_id
          ENV['ARTSY_API_CLIENT_ID']
        end

        # @return [String]
        def client_secret
          ENV['ARTSY_API_CLIENT_SECRET']
        end

        # @return [String]
        def user_email
          ENV['ARTSY_USER_EMAIL']
        end

        # @return [String]
        def user_password
          ENV['ARTSY_USER_PASSWORD']
        end

        # @return [String]
        def endpoint
          ENDPOINT
        end

        def connection_options
          CONNECTION_OPTIONS
        end

        # @note Faraday's middleware stack implementation is comparable to that of Rack middleware.  The order of middleware is important: the first middleware on the list wraps all others, while the last middleware is the innermost one.
        # @see https://github.com/technoweenie/faraday#advanced-middleware-usage
        # @see http://mislav.uniqpath.com/2011/07/faraday-advanced-http/
        # @return [Faraday::RackBuilder]
        def middleware
          MIDDLEWARE
        end

        # @return [Logger]
        def logger
          nil
        end
      end
    end
  end
end
