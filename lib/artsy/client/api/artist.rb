module Artsy
  module Client
    module API
      module Artist
        include Artsy::Client::API::Parse

        # Retrieves an artist.
        #
        # @return [Artsy::Client::Domain::Artist]
        def artist(id)
          object_from_response(self, Artsy::Client::Domain::Artist, :get, "/api/v1/artist/#{id}", {})
        end

        # Retrieves a sampler of artists.
        #
        # @return [Array]
        def artists(options = {})
          objects_from_response(self, Artsy::Client::Domain::Artist, :get, "/api/v1/artists/sample", options)
        end

        # Create an artist.
        #
        # @return [Artsy::Client::Domain::Artist]
        def create_artist(params = {})
          object_from_response(self, Artsy::Client::Domain::Artist, :post, "/api/v1/artist", params)
        end
      end
    end
  end
end
