module ActiveEntity
  # @example Cast with given type option.
  #   attr = ActiveEntity::Attribute.new(:user_id, type: Integer)
  #   attr.cast!('12') #=> 12
  #   attr.cast!('a') #=> raises ActiveEntity::CastError
  #
  # @example Cast with given casting procedure.
  #   attr = ActiveEntity::Attribute.new(
  #     :created_at,
  #     cast_by: -> (value) do
  #       case value
  #       when Fixnum, Float
  #         Time.at(value)
  #       when String
  #         Time.parse(value)
  #       else
  #         raise ActiveEntity::CastError.build(:Time, value)
  #       end
  #     end
  #   )
  #   attr.cast!(1420081200) #=> a Time object
  #   attr.cast!('2015/01/01 12:00:00') #=> a Time object
  class Attribute
    attr_reader :name, :options

    # @param [Symbol] name
    # @param [Hash{Symbol => Object}] options
    def initialize(name, options = {})
      raise ArgumentError unless options.is_a?(Hash)
      @name, @options = name, options
    end

    # @return [Class, Symbol, String]
    def type
      @options[:type]
    end

    # @return [Proc]
    def cast_by
      @options[:cast_by]
    end

    # @param [Object] value
    # @return [Object] casted value
    # @raise [ActiveEntity::CastError]
    def cast!(value)
      case
      when type
        cast_by_defined_type(value)
      when cast_by
        cast_by.call(value)
      else
        value
      end
    end

    private

    def cast_by_defined_type(value)
      procedure = ActiveEntity::ConversionDefinitions.get(type)

      if procedure
        procedure.call(value)
      else
        raise ConfigurationError.new("Can't find casting procedure for `#{type}`")
      end
    end
  end
end
