module Artsy
  module Client
    class Base < Hashie::Mash
      attr_accessor :instance
    end
  end
end
