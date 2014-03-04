module Artsy
  module Client
    module API
      module Order
        include Artsy::Client::API::Parse

        # Retrieves orders.
        #
        # @return [Array]
        def orders(params = {})
          objects_from_response(self, Artsy::Client::Domain::Order, :get, "/api/v1/orders", params)
        end
      end
    end
  end
end
