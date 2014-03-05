module Artsy
  module Client
    module Domain
      class Inventory < Artsy::Client::Base
        def count
          self[:count]
        end
      end
    end
  end
end
