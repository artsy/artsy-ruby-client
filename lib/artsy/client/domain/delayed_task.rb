module Artsy
  module Client
    module Domain
      class DelayedTask < Artsy::Client::Base
        def id
          self[:_id]
        end
      end
    end
  end
end
