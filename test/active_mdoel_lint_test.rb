lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_entity'

require 'minitest'
require 'minitest/autorun'

class TestForActiveModelLint < Minitest::Test
  include ActiveModel::Lint::Tests

  class Person
    include ActiveModel::Model
    include ActiveEntity::Accessor
    include ActiveEntity::Coercion
    include ActiveEntity::Identity

    attribute :name, type: String
    attribute :email, type: String

    identity_attribute :email
  end

  def setup
    @model = Person.new(name: 'Alice', email: 'alice@example.com')
  end
end
