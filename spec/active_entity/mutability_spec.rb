require 'spec_helper'

RSpec.describe ActiveEntity::Mutability do
  subject { test_class.new(x: 1) }

  context 'when included after attribute definitions' do
    before { test_class.send(:include, ActiveEntity::Mutability) }

    let(:test_class) do
      Class.new do
        include ActiveEntity::Attribute
        attribute :x
      end
    end

    it 'accepts attribute assign' do
      expect { subject.x = 0 }.not_to raise_error
      expect(subject.x).to eq(0)
    end
  end

  context 'when included before attribute definitions' do
    let(:test_class) do
      Class.new do
        include ActiveEntity::Attribute
        include ActiveEntity::Mutability
        attribute :x
      end
    end

    it 'accepts attribute assign' do
      expect { subject.x = 0 }.not_to raise_error
      expect(subject.x).to eq(0)
    end
  end
end
