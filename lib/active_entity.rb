require 'active_model'
require 'active_support/concern'

require 'active_entity/version'
require 'active_entity/mutability'

class ActiveEntity
  include ActiveModel::Validations
  include ActiveModel::Serialization

  class << self
    def defined_attributes
      @defined_attributes ||= {}
    end

    private

    def attribute(name, option = {})
      defined_attributes[name] = option
      attr_reader(name)
    end
  end

  def initialize(attrs = {})
    super()
    _validate_attrs_(attrs)
    attrs.each do |key, val|
      instance_variable_set(:"@#{key}", val)
    end
  end

  def attributes
    Hash[_attribute_names_.map {|name| [name, instance_variable_get(:"@#{name}")] }]
  end

  private

  def _validate_attrs_(attrs)
    undefineded = attrs.keys.map(&:to_sym) - _attribute_names_

    unless undefineded.empty?
      raise ArgumentError.new("Undefineded attributes are given: #{undefineded.join(', ')}")
    end
  end

  def _attribute_names_
    self.class.defined_attributes.keys
  end
end
