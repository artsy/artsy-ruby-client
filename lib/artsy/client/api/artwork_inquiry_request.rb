module Artsy
  module Client
    module API
      module ArtworkInquiryRequest
        include Artsy::Client::API::Parse

        # Retrieves an artwork inquiry request.
        #
        # @return [Artsy::Client::Domain::ArtworkInquiryRequest]
        def artwork_inquiry_request(id)
          object_from_response(self, Artsy::Client::Domain::ArtworkInquiryRequest, :get, "/api/v1/artwork_inquiry_request/#{id}", {})
        end
      end
    end
  end
end
