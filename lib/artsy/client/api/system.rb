module Artsy
  module Client
    module API
      module System
        include Artsy::Client::API::Parse

        # Retrieves system up information.
        #
        # @return [Artsy::Client::Domain::System]
        def up
          object_from_response(self, Artsy::Client::Domain::System, :get, "/api/v1/system/up", {})
        end

        # Returns whether artsy.net is up.
        #
        # @return [Boolean]
        def up?
          up.up?
        rescue
          false
        end

        # Clear api cache
        #
        # @return [Artsy::Client::Domain::System]
        def clear_cache
          object_from_response(self, Artsy::Client::Domain::System, :delete, "/api/v1/system/cache", {})
        end
      end
    end
  end
end
