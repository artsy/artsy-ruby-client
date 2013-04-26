module Artsy
  module Client
    module Domain
      class Artist < Artsy::Client::Base

        def artworks(options = {})
          instance.send(:objects_from_response, instance, 
            Artsy::Client::Domain::Artwork, 
            :get, "/api/v1/artist/#{self.id}/artworks", 
            options)
        end

      end
    end
  end
end
