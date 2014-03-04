module Artsy
  module Client
    module Domain
      class Sale < Artsy::Client::Base
        def to_s
          self[:name]
        end

        def id
          self[:_id]
        end
      end
    end
  end
end
