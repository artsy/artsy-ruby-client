module Artsy
  module Client
    module API
      module Show
        module Feed
          include Artsy::Client::API::Parse

          # Retrieves recent shows.
          #
          # @return [Array]
          def shows_feed(options = {})
            objects_from_response_feed(self, Artsy::Client::Domain::Show, :get, "/api/v1/shows/feed", options)
          end
        end
      end
    end
  end
end
