module Artsy
  module Client
    module API
      module System
        include Artsy::Client::API::Parse

        def up
          object_from_response(Artsy::Client::Domain::System, :get, "/api/v1/system/up", {})
        end

        def up?
          up.up?
        rescue
          false
        end

      end
    end
  end
end
