module Artsy
  module Client
    module API
      module User
        include Artsy::Client::API::Parse

        # Creates a user.
        #
        # @return [Artsy::Client::Domain::User]
        def create_user(params = {})
          object_from_response(self, Artsy::Client::Domain::User, :post, "/api/v1/user", params)
        end
      end
    end
  end
end
