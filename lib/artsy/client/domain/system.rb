module Artsy
  module Client
    module Domain
      class System < Artsy::Client::Base
        def up?
          attrs.all? do |k, v|
            !! v
          end
        end

        def respond_to?(method)
          if method_name[-1] == '?'
            attrs.has_key(method_name[0..-2].to_s)
          else
            super
          end
        end

        private

          def method_missing(method_name, *args, &block)
            return super unless method_name[-1] == '?'
            attrs[method_name[0..-2].to_s]
          end

      end
    end
  end
end
