module ActiveEntity
  # Offers implicit type conversion on initializing.
  # This depends `ActiveEntity::Accessor#defined_attributes`.
  module Coercion
    include Typecasting

    def initialize(*)
      super
      cast
    end
  end
end
