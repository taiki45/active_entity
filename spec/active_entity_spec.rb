require 'spec_helper'

RSpec.describe ActiveEntity do
  let(:example_class) do
    Class.new(ActiveEntity) do
      attribute :name
      attribute :age
    end
  end

  let(:test_attributes) { { name: 'Alice', age: 1 } }

  describe '.defined_attributes' do
    subject { example_class.defined_attributes }

    it { is_expected.to be_kind_of(Hash) }

    it 'returns all defined attributes' do
      is_expected.to eq(name: {}, age: {})
    end
  end

  describe '#initialize' do
    it 'accepts attributes hash' do
      expect { example_class.new(test_attributes) }.not_to raise_error
    end

    it 'assigns attributes' do
      an_entity = example_class.new(test_attributes)
      expect(an_entity.name).to eq('Alice')
      expect(an_entity.age).to eq(1)
    end

    it 'raises on forbidden mass assignment' do
      expect { example_class.new(x: 'x') }.to raise_error(ArgumentError)
    end
  end

  describe '#attributes' do
    subject { example_class.new(test_attributes).attributes }

    it { is_expected.to be_kind_of(Hash) }

    it "returns all attribute's name-value pairs" do
      is_expected.to eq(name: 'Alice', age: 1)
    end
  end
end
