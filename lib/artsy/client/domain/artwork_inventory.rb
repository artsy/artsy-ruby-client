module Artsy
  module Client
    module Domain
      class ArtworkInventory < Artsy::Client::Base
        def count
          self[:count]
        end
      end
    end
  end
end
