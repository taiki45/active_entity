module ActiveEntity
  module Typecasting
    # Try to cast attribute values. When fails to cast, raises the error and
    # rollbacks all values.
    #
    # @return [nil]
    # @raise [ActiveEntity::CastError]
    def cast!
      casted_values = defined_attributes.map do |name, attr|
        value = public_send(name)
        next [name, nil] if value.nil?
        [name, attr.cast!(value)]
      end

      casted_values.each {|name, casted| public_send("#{name}=", casted) }
      nil
    end

    # Try to cast attribute values. When fails to cast, ignores error and left
    # attribute value as original one.
    #
    # @return [nil]
    def cast
      defined_attributes.each do |name, attr|
        value = public_send(name)
        next if value.nil?

        begin
          casted = attr.cast!(value)
          public_send("#{name}=", casted)
        rescue ActiveEntity::CastError
        end
      end
      nil
    end
  end
end
