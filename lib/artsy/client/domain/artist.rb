module Artsy
  module Client
    module Domain
      class Artist < Artsy::Client::Base
        def artworks(options = {})
          instance.send(:objects_from_response, instance,
                        Artsy::Client::Domain::Artwork,
                        :get, "/api/v1/artist/#{id}/artworks",
                        options)
        end

        def to_s
          self[:name]
        end
      end
    end
  end
end
