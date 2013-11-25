module Artsy
  module Client
    module Domain
      class User < Artsy::Client::Base
        def to_s
          self[:name]
        end
      end
    end
  end
end
