module ActiveEntity
  module Attribute
    extend ActiveSupport::Concern

    included do
      class_attribute :defined_attributes,
        instance_writer: false, instance_predicate: false
      self.defined_attributes = {}
    end

    class_methods do
      def attribute(name, options = {})
        defined_attributes[name] = options
        attr_reader(name)
      end
    end

    def initialize(attrs = {})
      attrs.each do |attr, value|
        instance_variable_set(:"@#{attr}", value)
      end if attrs.respond_to?(:each)

      super()
    end

    def attributes
      @_attributes ||= begin
        Hash[defined_attributes.keys.map {|name| [name.to_s, public_send(name)] }]
      end
    end
  end
end
