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
          end if self[:partner]
        end

        def location
          @location ||= Artsy::Client::Domain::Location.new(self[:location]).tap do |location|
            location.instance = instance
          end if self[:location]
        end

        def name
          self[:name].gsub(/[\n]+/, "\n").strip
        end

        def to_s
          name
        end

        def when
          starts = DateTime.parse(self[:start_at])
          ends = DateTime.parse(self[:end_at])

          starts_month = starts.strftime("%b")
          starts_month += "." if starts.month != 5

          end_month = ends.strftime("%b")
          end_month += "." if ends.month != 5

          if starts.year == ends.year
            if starts.month == ends.month && starts.day == ends.day
              month_and_date = "#{starts_month} #{starts.day}"
            elsif starts.month == ends.month
              month_and_date = "#{starts_month} #{starts.day} - #{ends.day}"
            else
              month_and_date = "#{starts_month} #{starts.day} - #{end_month} #{ends.day}"
            end
            if starts.year != Time.now.year
              month_and_date += ", #{starts.year}"
            end
            month_and_date
          else
            "#{starts_month} #{starts.day}, #{starts.year} - #{ends_month} #{ends.day} #{ends.year}"
          end
        end

        def where
          location.to_s if location
        end

      end
    end
  end
end
