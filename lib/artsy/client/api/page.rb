module Artsy
  module Client
    module API
      module Page
        include Artsy::Client::API::Parse

        # Creates a page.
        #
        # @return [Artsy::Client::Domain::Page]
        def create_page(params = {})
          object_from_response(self, Artsy::Client::Domain::Page, :post, "/api/v1/page", params)
        end
      end
    end
  end
end
