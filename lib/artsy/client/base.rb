module Artsy
  module Client
    class Base < Hash
      include Hashie::Extensions::MergeInitializer
      include Hashie::Extensions::MethodAccess
      include Hashie::Extensions::IndifferentAccess

      attr_accessor :instance

      def id
        self[:id]
      end if RUBY_VERSION < "1.9"
    end
  end
end
