module Artsy
  module Client
    module Domain
      class SearchQuery < Artsy::Client::Base
        def to_s
          query
        end

        def query
          self[:query] || self[:value]
        end
      end
    end
  end
end
