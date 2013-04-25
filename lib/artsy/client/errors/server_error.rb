module Artsy
  module Client
    module Errors
      class ServerError < Base
        def initialize(opts = {})
          super(compose_message("server_error", opts))
        end
      end
    end
  end
end
