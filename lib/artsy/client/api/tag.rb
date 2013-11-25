module Artsy
  module Client
    module API
      module Tag
        include Artsy::Client::API::Parse

        # Retrieves a tag.
        #
        # @return [Artsy::Client::Domain::Tag]
        def tag(id)
          object_from_response(self, Artsy::Client::Domain::Tag, :get, "/api/v1/tag/#{id}", {})
        end
      end
    end
  end
end
