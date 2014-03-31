module Artsy
  module Client
    module Domain
      class SaleArtwork < Artsy::Client::Base
        def id
          self[:_id]
        end
      end
    end
  end
end
