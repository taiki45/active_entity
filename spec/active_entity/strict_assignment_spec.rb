require 'spec_helper'

RSpec.describe ActiveEntity::StrictAssignment do
  let(:test_class) do
    Class.new do
      include ActiveEntity::Attribute
      include ActiveEntity::StrictAssignment

      attribute :name
    end
  end

  describe '#initialize' do
    context 'with valid mass assignment' do
      it 'does not raise anything' do
        expect { test_class.new(name: 'Alice') }.not_to raise_error
      end
    end

    context 'with forbidden mass assignment' do
      it 'raises ArgumentError' do
        expect { test_class.new(x: 'x') }.to raise_error(ArgumentError)
      end
    end
  end
end
