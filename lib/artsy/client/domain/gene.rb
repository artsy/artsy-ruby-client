module Artsy
  module Client
    module Domain
      class Gene < Artsy::Client::Base
        def to_s
          self[:name]
        end
      end
    end
  end
end
