module Artsy
  module Client
    module API
      module Match
        include Artsy::Client::API::Parse

        # Retrieves matching terms.
        #
        # @return [Array]
        def match(term = '', options = {})
          objects_from_response(self, Artsy::Client::Domain::Match, :get, "/api/v1/match?term=#{term}", options)
        end
      end
    end
  end
end
