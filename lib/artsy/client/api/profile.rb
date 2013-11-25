module Artsy
  module Client
    module API
      module Profile
        include Artsy::Client::API::Parse

        # Retrieves a profile.
        #
        # @return [Artsy::Client::Domain::Profile]
        def profile(id)
          object_from_response(self, Artsy::Client::Domain::Profile, :get, "/api/v1/profile/#{id}", {})
        end
      end
    end
  end
end
