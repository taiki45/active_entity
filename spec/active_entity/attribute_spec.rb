require 'spec_helper'

RSpec.describe ActiveEntity::Attribute do
  describe 'typecasting' do
    context 'with type option' do
      let(:casting_proc) do
        -> (value) {
          begin
            Integer(value)
          rescue
            raise ActiveEntity::CastError.build(Integer, value)
          end
        }
      end

      before do
        allow(ActiveEntity::ConversionDefinitions).to receive(:get).
          with(Integer).and_return(casting_proc)
      end

      let(:attr) { ActiveEntity::Attribute.new(:user_id, type: Integer) }

      context 'with valid value' do
        it 'converts given value' do
          expect(attr.cast!('12')).to be_a(Integer)
          expect(attr.cast!('12')).to eq(12)
        end
      end

      context 'with invalid value' do
        it 'raises ActiveEntity::CastError' do
          expect { attr.cast!('a') }.to raise_error(ActiveEntity::CastError)
        end
      end

      context 'with procedure of type is not defined' do
        before do
          allow(ActiveEntity::ConversionDefinitions).to receive(:get).
            with(:UnknownType).and_return(nil)
        end

        let(:attr) { ActiveEntity::Attribute.new(:user_id, type: :UnknownType) }

        it 'raises ConfigurationError' do
          expect {
            attr.cast!('12')
          }.to raise_error(ActiveEntity::ConfigurationError, /UnknownType/)
        end
      end
    end

    context 'with cast_by option' do
     let(:attr) do
       ActiveEntity::Attribute.new(
        :created_at,
        cast_by: -> (value) do
          case value
          when Fixnum, Float
            Time.at(value)
          when String
            Time.parse(value)
          else
            raise ActiveEntity::CastError.build(:Time, value)
          end
        end
       )
     end

     it 'converts given value' do
       expect(attr.cast!(1420081200)).to be_a(Time)
       expect(attr.cast!('2015/01/01 12:00:00')).to be_a(Time)
     end
    end

    context 'without typecasting options' do
      let(:attr) { ActiveEntity::Attribute.new(:user_id) }

      it 'does nothing and returns original' do
        expect(attr.cast!('12')).to eq('12')
      end
    end
  end
end
