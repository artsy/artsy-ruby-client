module Artsy
  module Client
    module Domain
      class ArtworkInquiryRequest < Artsy::Client::Base
        def name
          self[:name]
        end

        def email
          self[:email]
        end

        def message
          self[:message].gsub(/[\n]+/, "\n").strip
        end
      end
    end
  end
end
