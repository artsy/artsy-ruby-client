module Artsy
  module Client
    module API
      module OrderedSet
        include Artsy::Client::API::Parse

        # Retrieves an ordered_set.
        #
        # @return [Artsy::Client::Domain::OrderedSet]
        def ordered_set(id)
          object_from_response(self, Artsy::Client::Domain::OrderedSet, :get, "/api/v1/set/#{id}", {})
        end

        # Creates an ordered_set.
        #
        # @return [Artsy::Client::Domain::OrderedSet]
        def create_ordered_set(params = {})
          object_from_response(self, Artsy::Client::Domain::OrderedSet, :post, "/api/v1/set", params)
        end

        # Adds an item to an ordered_set.
        #
        # @return [Artsy::Client::Domain::OrderedSet]
        def add_to_ordered_set(id, params = {})
          set = ordered_set(id)
          # Ruby 1.9.3 cannot handle const_get for nested Classes (Ruby 2.0 can).
          type_class = "Artsy::Client::Domain::#{set[:item_type]}".split("::").reduce(Object) { |a, e| a.const_get e }
          object_from_response(self, type_class, :post, "/api/v1/set/#{id}/item", params)
        end
      end
    end
  end
end
