module ActiveEntity
  module Mutability
    extend ActiveSupport::Concern

    included do
      attr_writer(*defined_attributes.keys)
    end

    class_methods do
      def attribute(name, option = {})
        super
        attr_writer(name)
      end
    end
  end
end
