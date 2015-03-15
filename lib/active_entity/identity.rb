module ActiveEntity
  module Identity
    extend ActiveSupport::Concern

    included do
      class_attribute :identity_attributes, instance_writer: false, instance_predicate: false
      self.identity_attributes = []
    end

    class_methods do
      def identity_attribute(*names)
        identity_attributes.concat(names.flatten)

        define_method(:==) do |other|
          return false unless self.class === other
          names.all? {|name| public_send(name) == other.public_send(name) }
        end
      end
    end

    # For ActiveModel::Conversion
    def to_key
      indentity_attributes.empty? ? nil : identity_attributes
    end
  end
end
