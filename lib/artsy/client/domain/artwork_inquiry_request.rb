module Artsy
  module Client
    module Domain
      class ArtworkInquiryRequest < Artsy::Client::Base
        def message
          self[:message].gsub(/[\n]+/, "\n").strip
        end
      end
    end
  end
end
