require 'spec_helper'

RSpec.describe ActiveEntity::ConversionDefinitions do
  around do |example|
    described_class.run_with_new_then_restore { example.run }
  end

  describe '.set and .get' do
    type_as_class = ActiveSupport::TimeWithZone
    type_as_symbol = :'ActiveSupport::TimeWithZone'
    type_as_string = 'ActiveSupport::TimeWithZone'

    [type_as_class, type_as_symbol, type_as_string].permutation(2).each do |a, b|
      context "when set with #{a.class} and get with #{b.class}" do
        it 'returns valid procedure' do
          described_class.set(a) {}
          expect(described_class.get(b)).not_to be_nil
        end
      end
    end
  end

  context 'when given invalid type' do
    it 'raises ArgumentError' do
      expect { described_class.set(1) }.to raise_error(ArgumentError)
    end
  end
end
