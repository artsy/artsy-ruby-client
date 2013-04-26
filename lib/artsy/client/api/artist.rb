module Artsy
  module Client
    module API
      module Artist
        include Artsy::Client::API::Parse

        def artist(id)
          object_from_response(Artsy::Client::Domain::Artist, :get, "/api/v1/artist/#{id}", {})
        end

      end
    end
  end
end
