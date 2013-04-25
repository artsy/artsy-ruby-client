module Artsy
  module Client
    module Errors
      class ConfigurationError < Base
        def initialize(opts = {})
          super(compose_message("configuration_error", opts))
        end
      end
    end
  end
end
