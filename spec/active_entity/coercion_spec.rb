require 'spec_helper'

RSpec.describe ActiveEntity::Coercion do
  let(:test_class) do
    Class.new do
      include ActiveModel::Model
      include ActiveEntity::Accessor
      include ActiveEntity::Coercion

      attribute :name, type: String
      attribute :age, type: Integer
    end
  end

  it 'automatically typecasts attribute values' do
    person = test_class.new(name: 'Alice', age: '1')
    expect(person.name).to eq('Alice')
    expect(person.age).to eq(1)
  end
end
