module Artsy
  module Client
    module API
      module Sale
        include Artsy::Client::API::Parse

        # Retrieves a sale.
        #
        # @return [Artsy::Client::Domain::Sale]
        def sale(id)
          object_from_response(self, Artsy::Client::Domain::Sale, :get, "/api/v1/sale/#{id}", {})
        end

        # Creates a sale.
        #
        # @return [Artsy::Client::Domain::Sale]
        def create_sale(params = {})
          object_from_response(self, Artsy::Client::Domain::Sale, :post, "/api/v1/sale", params)
        end

        # Updates a sale.
        #
        # @return [Artsy::Client::Domain::Sale]
        def update_sale(id, params = {})
          object_from_response(self, Artsy::Client::Domain::Sale, :put, "/api/v1/sale/#{id}", params)
        end

        # Adds an artwork to a sale.
        #
        # @return [Artsy::Client::Domain::Sale]
        def add_artwork_to_sale(id, params = {})
          object_from_response(self, Artsy::Client::Domain::Sale, :post, "/api/v1/sale/#{id}/sale_artwork", params)
        end
      end
    end
  end
end
