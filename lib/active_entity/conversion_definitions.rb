module ActiveEntity
  class ConversionDefinitions
    class << self
      # @param [Class, Symbol, String] type
      # @return [Proc]
      def get(type)
        type_casting_procs.get(type)
      end

      # @param [Class, Symbol, String] type
      # @return [Proc]
      def set(type, &block)
        type_casting_procs.set(type, &block)
      end

      # Run block with new type_casting_procs. For test purpose.
      # @return [nil]
      def run_with_new_then_restore
        old, @type_casting_procs = type_casting_procs, MapWithNormalizing.new
        yield
        @type_casting_procs = old
        nil
      end

      private

      def type_casting_procs
        @type_casting_procs ||= MapWithNormalizing.new
      end
    end

    private

    class MapWithNormalizing
      def initialize
        @map = {}
      end

      def get(type)
        @map[normalize_type(type)]
      end

      def set(type, &block)
        # TODO: block arity check
        @map[normalize_type(type)] = block
      end

      def normalize_type(type)
        case type
        when Class
          type.to_s
        when String
          type
        when Symbol
          type.to_s
        else
          raise ArgumentError.new("`type` must be a Class or String or Symbol, but #{type.class}")
        end
      end
    end
  end
end
