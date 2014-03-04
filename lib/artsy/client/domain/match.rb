module Artsy
  module Client
    module Domain
      class Match < Artsy::Client::Base
        def to_s
          self[:display]
        end

        def object
          @object ||= begin
            object = instance.send(model, id)
            object.instance = instance
            object
          end
        end
      end
    end
  end
end
