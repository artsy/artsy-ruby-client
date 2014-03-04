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

        # Retrieves the current incomplete order (at most one).
        #
        # @return [Artsy::Client::Domain::Order]
        def me_order_pending
          object_from_response(self, Artsy::Client::Domain::Order, :get, "/api/v1/me/order/pending", {})
        end
      end
    end
  end
end
