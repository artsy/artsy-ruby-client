module Artsy
  module Client
    module API
      module Show
        include Artsy::Client::API::Parse

        # Retrieves a show.
        #
        # @return [Artsy::Client::Domain::Show]
        def show(id)
          object_from_response(self, Artsy::Client::Domain::Show, :get, "/api/v1/show/#{id}", {})
        end

        # Retrieves shows.
        #
        # @return [Array]
        def shows(options = {})
          objects_from_response(self, Artsy::Client::Domain::Show, :get, "/api/v1/shows", options)
        end
      end
    end
  end
end
