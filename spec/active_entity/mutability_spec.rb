require 'spec_helper'

RSpec.describe ActiveEntity::Mutability do
  subject { entity_class.new(x: 1) }

  context 'when included after attribute definitions' do
    before { entity_class.include ActiveEntity::Mutability }
    let(:entity_class) do
      Class.new(ActiveEntity) do
        attribute :x
      end
    end

    it 'accepts attribute assign' do
      expect { subject.x = 0 }.not_to raise_error
      expect(subject.x).to eq(0)
    end
  end

  context 'when included before attribute definitions' do
    let(:entity_class) do
      Class.new(ActiveEntity) do
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
