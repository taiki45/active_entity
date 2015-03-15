require 'spec_helper'

RSpec.describe ActiveEntity::Typecasting do
  let(:test_class) do
    Class.new do
      include ActiveModel::Model
      include ActiveEntity::Accessor
      include ActiveEntity::Typecasting

      attribute :name, type: String
      attribute :age, type: Integer
      attribute :item_count, type: Integer
    end
  end

  let(:person) { test_class.new(assigned_values) }
  let(:assigned_values) { { name: 'Alice', age: '1', item_count: '2' } }

  describe '#cast!' do
    context 'when assigned value is valid' do
      it 'conversions its attributes' do
        person.cast!
        expect(person.name).to eq('Alice')
        expect(person.age).to eq(1)
        expect(person.item_count).to eq(2)
      end
    end

    context 'when assigned value is invalid' do
      let(:assigned_values) { { name: 'Alice', age: '1', item_count: 'a' } }

      it 'raises ActiveEntity::CastError' do
        expect { person.cast! }.to raise_error(ActiveEntity::CastError)
      end

      it 'rollbacks all values' do
        expect { person.cast! }.to raise_error(ActiveEntity::CastError)
        expect(person.age).to eq('1')
      end
    end

    context 'when assigned value is nil' do
      let(:assigned_values) { { name: nil, age: '1', item_count: nil } }

      it 'skips nil values' do
        expect { person.cast! }.not_to raise_error
        expect(person.name).to be_nil
        expect(person.age).to eq(1)
        expect(person.item_count).to be_nil
      end
    end
  end

  describe '#cast' do
    context 'when assigned value is valid' do
      it 'conversions its attributes' do
        person.cast
        expect(person.name).to eq('Alice')
        expect(person.age).to eq(1)
        expect(person.item_count).to eq(2)
      end
    end

    context 'when assigned value is invalid' do
      let(:assigned_values) { { name: 'Alice', age: '1', item_count: 'a' } }

      it 'skips invalid value' do
        person.cast
        expect(person.name).to eq('Alice')
        expect(person.age).to eq(1)
        expect(person.item_count).to eq('a')
      end
    end
  end
end
