module Artsy
  module Client
    module Domain
      class Location < Artsy::Client::Base
        def to_s
          self[:city] || self[:display]
        end
      end
    end
  end
end
