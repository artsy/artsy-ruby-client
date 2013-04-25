module Artsy
  module Client
    module API
      module Parse

        private

          # @param klass [Class]
          # @param request_method [Symbol]
          # @param path [String]
          # @param options [Hash]
          # @return [Array]
          def objects_from_response(klass, request_method, path, options={})
            response = send(request_method.to_sym, path, options)[:body]
            objects_from_array(klass, response)
          end

          # @param klass [Class]
          # @param array [Array]
          # @return [Array]
          def objects_from_array(klass, array)
            array.map do |element|
              klass.new(element)
            end
          end

          # @param klass [Class]
          # @param request_method [Symbol]
          # @param path [String]
          # @param options [Hash]
          # @return [Object]
          def object_from_response(klass, request_method, path, options={})
            response = send(request_method.to_sym, path, options)
            klass.from_response(response)
          end

      end
    end
  end
end
