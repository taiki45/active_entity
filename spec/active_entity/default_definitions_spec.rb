require 'spec_helper'

RSpec.describe 'default type conversion definitions' do
  shared_examples 'raising error' do
    it 'raises ActiveEntity::CastError' do
      expect { subject }.to raise_error(ActiveEntity::CastError, /#{type}/)
    end
  end

  let(:procedure) { ActiveEntity::ConversionDefinitions.get(type) }
  subject { procedure.call(value) }

  describe 'Boolean conversion' do
    let(:type) { :Boolean }

    context 'with `true` string' do
      let(:value) { 'true' }
      it { is_expected.to eq(true) }
    end

    context 'with `false` string' do
      let(:value) { 'false' }
      it { is_expected.to eq(false) }
    end

    context 'with invalid value' do
      let(:value) { 'True' }
      include_examples 'raising error'
    end
  end

  describe 'Integer conversion' do
    let(:type) { :Integer }

    context 'with valid value' do
      let(:value) { '12' }
      it { is_expected.to eq(12) }
    end

    context 'with invalid value' do
      let(:value) { 'abc' }
      include_examples 'raising error'
    end
  end

  describe 'Float conversion' do
    let(:type) { :Float }

    context 'with valid value' do
      let(:value) { '12.1' }
      it { is_expected.to eq(12.1) }
    end

    context 'with invalid value' do
      let(:value) { 'abc' }
      include_examples 'raising error'
    end
  end

  describe 'ActiveSupport::TimeWithZone conversion' do
    around do |example|
      back, Time.zone = Time.zone, 'UTC'
      example.run
      Time.zone = back
    end

    let(:type) { :'ActiveSupport::TimeWithZone' }

    context 'with string expression' do
      let(:value) { '2015/01/05 02:12:12' }
      it { is_expected.to be_a(ActiveSupport::TimeWithZone) }
    end

    context 'with float expression' do
      let(:value) { 1420081200.089 }
      it { is_expected.to be_a(ActiveSupport::TimeWithZone) }
    end

    context 'with invalid string value' do
      let(:value) { '1420081200.089' }
      include_examples 'raising error'
    end

    context 'with invalid value' do
      let(:value) { Time.now }
      include_examples 'raising error'
    end
  end

  describe 'String conversion' do
    let(:type) { :String }

    context 'with valid value' do
      let(:value) { 12 }
      it { is_expected.to eq('12') }
    end

    context 'with invalid value' do
      let(:value) { Object.new.tap {|o| o.instance_eval { undef :to_s } } }
      include_examples 'raising error'
    end
  end

  describe 'Symbol conversion' do
    let(:type) { :Symbol }

    context 'with valid value' do
      let(:value) { 'abc' }
      it { is_expected.to eq(:abc) }
    end

    context 'with invalid value' do
      let(:value) { 12 }
      include_examples 'raising error'
    end
  end
end
