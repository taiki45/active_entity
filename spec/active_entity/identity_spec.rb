require 'spec_helper'

RSpec.describe ActiveEntity::Identity do
  let(:test_class) do
    Class.new do
      include ActiveEntity::Identity

      attr_reader :name, :age
      identity_attribute :name, :age

      def initialize(name, age)
        @name = name
        @age = age
      end
    end
  end

  describe '.identity_attributes' do
    subject { test_class.identity_attributes }
    it { is_expected.to eq([:name, :age]) }
  end

  describe '#==' do
    subject { a == b }
    let(:a) { test_class.new('Alice', 1) }

    context 'with same entity' do
      let(:b) { test_class.new('Alice', 1) }
      it { is_expected.to be_truthy }
    end

    context 'with different entity' do
      context 'and it has all different attributes' do
        let(:b) { test_class.new('Bob', 2) }
        it { is_expected.to be_falsey }
      end

      context 'and it has some of different attributes' do
        let(:b) { test_class.new('Alice', 2) }
        it { is_expected.to be_falsey }
      end
    end
  end
end
