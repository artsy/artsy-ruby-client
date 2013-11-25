module Artsy
  module Client
    module API
      module Feature
        include Artsy::Client::API::Parse

        # Retrieves a feature.
        #
        # @return [Artsy::Client::Domain::Feature]
        def feature(id)
          object_from_response(self, Artsy::Client::Domain::Feature, :get, "/api/v1/feature/#{id}", {})
        end
      end
    end
  end
end
