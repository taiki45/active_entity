module ActiveEntity
  module Entity
    extend ActiveSupport::Concern

    included do
      include Attribute
      include StrictAssignment
      include Identity
      include ActiveModel::Validations
      include ActiveModel::Serialization
    end
  end
end
