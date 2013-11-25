module Artsy
  module Client
    module API
      module SearchQuery
        include Artsy::Client::API::Parse

        # Retrieves top search queries.
        #
        # @return [Array]
        def autocomplete(term = '', options = {})
          objects_from_response(self, Artsy::Client::Domain::SearchQuery, :get, "/api/v1/autocomplete?term=#{term}", options)
        end
      end
    end
  end
end
