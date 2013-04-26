module Artsy
  module Client
    module Domain
      class Artwork < Artsy::Client::Base

        def artist
          @artist ||= Artsy::Client::Domain::Artist.new(self[:artist]).tap do |artist|
            artist.instance = instance
          end
        end

        def title
          self[:title].gsub(/[\n]+/, "\n").strip
        end

      end
    end
  end
end
