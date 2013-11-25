module Artsy
  module Client
    module API
      module Parse
        private

        # @param instance [Artsy::Client::Instance]
        # @param klass [Class]
        # @param request_method [Symbol]
        # @param path [String]
        # @param options [Hash]
        # @return [Array]
        def objects_from_response(instance, klass, request_method, path, options = {})
          response = send(request_method.to_sym, path, options)[:body]
          objects_from_array(instance, klass, response)
        end

        # @param instance [Artsy::Client::Instance]
        # @param klass [Class]
        # @param request_method [Symbol]
        # @param path [String]
        # @param options [Hash]
        # @return [Hash]
        def objects_from_response_feed(instance, klass, request_method, path, options = {})
          response = send(request_method.to_sym, path, options)[:body]
          {
            next: response["next"],
            results: objects_from_array(instance, klass, response["results"])
          }
        end

        # @param instance [Artsy::Client::Instance]
        # @param klass [Class]
        # @param array [Array]
        # @return [Array]
        def objects_from_array(instance, klass, array)
          array.map do |element|
            b = klass.new(element)
            b.instance = instance
            b
          end
        end

        # @param instance [Artsy::Client::Instance]
        # @param klass [Class]
        # @param request_method [Symbol]
        # @param path [String]
        # @param options [Hash]
        # @return [Object]
        def object_from_response(instance, klass, request_method, path, options = {})
          response = send(request_method.to_sym, path, options)
          b = klass.new(response[:body]) if response[:body]
          b.instance = instance if b
          b
        end
      end
    end
  end
end
