module Artsy
  module Client
    module API
      module Artwork
        include Artsy::Client::API::Parse

        # Retrieves an artist.
        #
        # @return [Artsy::Client::Domain::Artwork]
        def artwork(id)
          object_from_response(self, Artsy::Client::Domain::Artwork, :get, artwork_path(id), {})
        end

        # Retrieves recently published artworks.
        #
        # @return [Array]
        def recently_published_artworks(options = {})
          objects_from_response(self, Artsy::Client::Domain::Artwork, :get, "/api/v1/artworks/new", options)
        end

        # Create an artwork.
        #
        # @return [Artsy::Client::Domain::Artwork]
        def create_artwork(params = {})
          object_from_response(self, Artsy::Client::Domain::Artwork, :post, "/api/v1/artwork", params)
        end

        # Update an artwork.
        #
        # @return [Artsy::Client::Domain::Artwork]
        def update_artwork(id, params = {})
          object_from_response(self, Artsy::Client::Domain::Artwork, :put, artwork_path(id), params)
        end

        private

        def artwork_path(id)
          "/api/v1/artwork/#{id}"
        end
      end
    end
  end
end
