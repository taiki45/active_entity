module ActiveEntity
  module Coercion
    include Typecasting

    def initialize(*)
      super
      cast
    end
  end
end
