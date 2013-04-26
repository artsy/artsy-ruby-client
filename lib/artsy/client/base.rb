module Artsy
  module Client
    class Base < Hashie::Mash
      # Returns a new object based on the response hash
      #
      # @param response [Hash]
      # @return [Artsy::Client::Base]
      def self.from_response(response={})
        new(response[:body]) if response[:body]
      end
    end
  end
end
