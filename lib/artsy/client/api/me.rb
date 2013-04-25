module Artsy
  module Client
    module API
      module Me
        include Artsy::Client::API::Parse

        def me
          object_from_response(Artsy::Client::Domain::User, :get, "/api/v1/me", {})
        end

      end
    end
  end
end
