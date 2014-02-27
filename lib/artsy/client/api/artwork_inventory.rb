module Artsy
  module Client
    module API
      module ArtworkInventory
        include Artsy::Client::API::Parse

        # Creates an artwork inventory object.
        #
        # @return [Artsy::Client::Domain::Inventory]
        def create_artwork_inventory(params = {})
          object_from_response(self, Artsy::Client::Domain::ArtworkInventory, :put, "/api/v1/artwork/#{params[:artwork_id]}/inventory", params)
        end
      end
    end
  end
end
