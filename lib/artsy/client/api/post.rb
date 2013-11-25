module Artsy
  module Client
    module API
      module Post
        include Artsy::Client::API::Parse

        # Retrieves featured posts.
        #
        # @return [Hash]
        def featured_posts(options = {})
          objects_from_response_feed(self, Artsy::Client::Domain::Post, :get, "/api/v1/posts/featured/feed", options)
        end
      end
    end
  end
end
