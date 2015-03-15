require 'spec_helper'

RSpec.describe ActiveEntity::Attribute do
  let(:test_class) do
    Class.new do
      include ActiveModel::Model
      include ActiveEntity::Attribute

      attribute :name
      attribute :age
    end
  end

  let(:test_attributes) { { name: 'Alice', age: 1 } }

  describe '.defined_attributes' do
    subject { test_class.defined_attributes }
    it { is_expected.to be_kind_of(Hash) }

    it 'returns all defined attributes' do
      is_expected.to eq(name: {}, age: {})
    end
  end

  describe '#initialize' do
    subject { test_class.new(test_attributes) }

    it 'assigns attributes' do
      expect(subject.name).to eq('Alice')
      expect(subject.age).to eq(1)
    end
  end

  describe '#attributes' do
    subject { test_class.new(test_attributes).attributes }

    it { is_expected.to be_kind_of(Hash) }

    it "returns all attribute's name-value pairs" do
      is_expected.to eq('name' => 'Alice', 'age' => 1)
    end
  end
end
