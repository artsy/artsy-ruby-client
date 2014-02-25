module Artsy
  module Client
    module Domain
      class OrderedSet < Artsy::Client::Base
        def key
          self[:key]
        end

        def name
          self[:name]
        end
      end
    end
  end
end
