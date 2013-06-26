module Artsy
  module Client
    module Domain
      class Profile < Artsy::Client::Base

        def owner
          @owner ||= begin
            case owner_type
            when "User"
              Artsy::Client::Domain::User.new(self[:owner])
            else
              raise "Unsupported owner type: #{owner_type}."
            end
          end
        end

        def to_s
          self[:name]
        end

      end
    end
  end
end
