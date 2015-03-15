module ActiveEntity
  class Error < StandardError
  end

  class CastError < Error
    def self.build(type, value)
      new("Can't type cast #{value.inspect} as #{type}")
    end
  end

  class ConfigurationError < Error
  end
end
