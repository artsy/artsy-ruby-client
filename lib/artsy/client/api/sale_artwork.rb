module Artsy
  module Client
    module API
      module SaleArtwork
        include Artsy::Client::API::Parse

        # Updates a sale artwork.
        #
        # @return [Artsy::Client::Domain::SaleArtwork]
        def update_sale_artwork(sale_id, artwork_id, params = {})
          object_from_response(self, Artsy::Client::Domain::SaleArtwork, :put, "/api/v1/sale/#{sale_id}/sale_artwork/#{artwork_id}", params)
        end

        # Adds an artwork to a sale artwork.
        #
        # @return [Artsy::Client::Domain::SaleArtwork]
        def add_artwork_to_sale(sale_id, params = {})
          object_from_response(self, Artsy::Client::Domain::SaleArtwork, :post, "/api/v1/sale/#{sale_id}/sale_artwork", params)
        end
      end
    end
  end
end
