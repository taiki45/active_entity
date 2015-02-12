module ActiveEntity
  module StrictAssignment
    extend ActiveSupport::Concern

    def initialize(attrs = {})
      keys = attrs.keys.map(&:to_sym) - defined_attributes.keys

      unless keys.empty?
        raise ArgumentError.new("Invalid assignments on: #{keys}")
      end

      super
    end
  end
end
