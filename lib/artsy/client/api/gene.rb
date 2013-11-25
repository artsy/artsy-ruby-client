module Artsy
  module Client
    module API
      module Gene
        include Artsy::Client::API::Parse

        # Retrieves a gene.
        #
        # @return [Artsy::Client::Domain::Gene]
        def gene(id)
          object_from_response(self, Artsy::Client::Domain::Gene, :get, "/api/v1/gene/#{id}", {})
        end
      end
    end
  end
end
