module Artsy
  module Client
    module Domain
      class System < Artsy::Client::Base

        def up?
          size > 0 && all? do |k, v|
            !! v
          end
        end

        def respond_to?(method_name)
          if method_name.to_s[-1..-1] == '?'
            has_key?(method_name.to_s[0..-2])
          else
            super
          end
        end

        private

          def method_missing(method_name, *args, &block)
            if method_name.to_s[-1..-1] == '?'
              !! self[method_name.to_s[0..-2]]
            else
              super
            end
          end

      end
    end
  end
end
