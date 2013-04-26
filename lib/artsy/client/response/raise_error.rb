module Artsy
  module Client
    module Response
      class RaiseError < Faraday::Response::Middleware

        def on_complete(env)
          status_code = env[:status].to_i
          body = env[:body]
          error = MultiJson.decode(body)["error"] if body rescue nil
          raise Artsy::Client::Errors::ServerError.new({ 
            :status_code => status_code,
            :body => body,
            :error => error
          }) if status_code >= 400
        end

      end
    end
  end
end
