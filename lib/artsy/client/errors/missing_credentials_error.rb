module Artsy
  module Client
    module Errors
      class MissingCredentialsError < Base
        def initialize
          super(compose_message("missing_credentials_error"))
        end
      end
    end
  end
end
