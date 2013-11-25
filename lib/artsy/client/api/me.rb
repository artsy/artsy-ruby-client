module Artsy
  module Client
    module API
      module Me
        include Artsy::Client::API::Parse

        # Retrieves the currently logged in user.
        #
        # @return [Artsy::Client::Domain::User]
        def me
          object_from_response(self, Artsy::Client::Domain::User, :get, "/api/v1/me", {})
        end
      end
    end
  end
end
