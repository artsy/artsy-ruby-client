module Artsy
  module Client
    module API
      module Show
        include Artsy::Client::API::Parse

        # Retrieves recent shows.
        #
        # @return [Hash]
        def shows(options = {})
          objects_from_response_feed(self, Artsy::Client::Domain::Show, :get, "/api/v1/shows/feed", options)
        end

      end
    end
  end
end
