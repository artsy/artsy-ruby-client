module Artsy
  module Client
    module Domain
      class Show < Artsy::Client::Base
        include Artsy::Client::API::Parse

        def artworks
          @artworks ||= objects_from_array(instance,
            Artsy::Client::Domain::Artwork, self[:artworks])
        end

        def partner
          @partner ||= Artsy::Client::Domain::Partner.new(self[:partner]).tap do |partner|
            partner.instance = instance
          end
        end

        def name
          self[:name].gsub(/[\n]+/, "\n").strip
        end

        def to_s
          name
        end

      end
    end
  end
end
