module Artsy
  module Client
    module Response
      class RaiseError < Faraday::Response::Middleware

        def on_complete(env)
          status_code = env[:status].to_i
          raise Artsy::Client::Errors::ServerError.new({ :status_code => status_code }) if status_code >= 400
        end

      end
    end
  end
end
