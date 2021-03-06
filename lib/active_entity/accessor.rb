module ActiveEntity
  module Accessor
    extend ActiveSupport::Concern

    included do
      class_attribute :defined_attributes, instance_writer: false, instance_predicate: false
      self.defined_attributes = {}
    end

    module ClassMethods
      def attribute(name, options = {})
        defined_attributes[name] = Attribute.new(name, options)
        attr_accessor(name)
      end
    end

    def attributes
      Hash[defined_attributes.keys.map {|name| [name.to_s, public_send(name)] }]
    end
  end
end
