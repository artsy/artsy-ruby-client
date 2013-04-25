# heavily inspired from https://github.com/sferik/twitter

module Artsy
  module Client
    class Base
      # Define methods that retrieve the value from an initialized instance variable Hash, using the attribute as a key
      #
      # @param attrs [Array, Set, Symbol]
      def self.attr_reader(*attrs)
        mod = Module.new do
          attrs.each do |attribute|
            define_method attribute do
              @attrs[attribute.to_s]
            end
            define_method "#{attribute}?" do
              !!@attrs[attribute.to_s]
            end
          end
        end
        const_set(:Attributes, mod)
        include mod
      end

      # Returns a new object based on the response hash
      #
      # @param response [Hash]
      # @return [Artsy::Client::Base]
      def self.from_response(response={})
        new(response[:body]) if response[:body]
      end

      # Initializes a new object
      #
      # @param attrs [Hash]
      # @return [Artsy::Client::Base]
      def initialize(attrs={})
        @attrs = {}
        attrs.each_pair do |k, v|
          @attrs[k.to_s] = v
        end
      end

      # Fetches an attribute of an object using hash notation
      #
      # @param method [String, Symbol] Message to send to the object
      def [](method)
        send(method.to_s)
      rescue NoMethodError
        nil
      end

      # Retrieve the attributes of an object
      #
      # @return [Hash]
      def attrs
        @attrs
      end
      alias to_hash attrs

      # Update the attributes of an object
      #
      # @param attrs [Hash]
      # @return [Artsy::Client::Base]
      def update(attrs)
        @attrs.update(attrs)
        self
      end

      def respond_to?(method)
        super || attrs.has_key(method.to_s)
      end

    private

      def method_missing(method_name, *args, &block)
        method_name_s = method_name.to_s
        if attrs.has_key?(method_name_s)
          attrs[method_name_s]
        else
          super
        end
      end

    protected

      # @param attr [Symbol]
      # @param other [Artsy::Client::Base]
      # @return [Boolean]
      def attr_equal(attr, other)
        self.class == other.class && !other.send(attr).nil? && send(attr) == other.send(attr)
      end

      # @param other [Artsy::Client::Base]
      # @return [Boolean]
      def attrs_equal(other)
        self.class == other.class && !other.attrs.empty? && attrs == other.attrs
      end
    end
  end
end
