module Artsy
  module Client
    module API
      module Artwork
        include Artsy::Client::API::Parse

        # Retrieves an artist.
        #
        # @return [Artsy::Client::Domain::Artwork]        
        def artwork(id)
          object_from_response(Artsy::Client::Domain::Artwork, :get, "/api/v1/artwork/#{id}", {})
        end

        # Retrieves recently published artworks.
        #
        # @return [Array]
        def recently_published_artworks(options = {})
          objects_from_response(Artsy::Client::Domain::Artwork, :get, "/api/v1/artworks/new", options)
        end

      end
    end
  end
end
