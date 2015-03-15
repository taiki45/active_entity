module ActiveEntity
  class Attribute
    attr_reader :name, :options

    # @param [Symbol] name
    # @param [Hash{Symbol => Object}] options
    def initialize(name, options = {})
      @name, @options = name, options
    end

    def type
      @options[:type]
    end

    def description
      @options[:description]
    end
  end
end
