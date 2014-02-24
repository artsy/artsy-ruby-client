module Artsy
  module Client
    module API
      module Partner
        include Artsy::Client::API::Parse

        # Retrieves a partner.
        #
        # @return [Artsy::Client::Domain::Partner]
        def partner(id)
          object_from_response(self, Artsy::Client::Domain::Partner, :get, "/api/v1/partner/#{id}", {})
        end

        # Creates a partner.
        #
        # @return [Artsy::Client::Domain::Partner]
        def create_partner(params)
          object_from_response(self, Artsy::Client::Domain::Partner, :post, "/api/v1/partner", params)
        end
      end
    end
  end
end
