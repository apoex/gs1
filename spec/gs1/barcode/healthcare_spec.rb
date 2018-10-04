require 'spec_helper'

RSpec.describe GS1::Barcode::Healthcare do
  let(:barcode) { described_class.new(options) }
  let(:options) do
    { gtin: gtin_data,
      batch: batch_data,
      expiration_date: expiration_date_data,
      serial_number: serial_number_data }
  end

  let(:gtin_data) { double }
  let(:batch_data) { double }
  let(:expiration_date_data) { double }
  let(:serial_number_data) { double }

  describe '.from_scan' do
    let(:data) { '010000001231231317181003101231231231231231231221123123' }

    subject { described_class.from_scan(data) }

    it 'sets all attributes' do
      expect(subject.gtin).to eq(GS1::GTIN.new('00000012312313'))
      expect(subject.expiration_date).to eq(GS1::ExpirationDate.new('181003'))
      expect(subject.batch).to eq(GS1::Batch.new('12312312312312312312'))
      expect(subject.serial_number).to eq(GS1::SerialNumber.new('123123'))
    end
  end

  describe '#to_s' do
    subject { barcode.to_s }

    before do
      expect(barcode).to receive(:valid?).with(level: level).and_return(valid)
    end

    let(:level) { GS1::AIDCMarketingLevels::ENHANCED }

    context 'when valid' do
      let(:valid) { true }

      it 'returns all attributes concatinated' do
        gtin_part = "#{GS1::GTIN::AI}#{gtin_data}"
        expiration_date_part = "#{GS1::ExpirationDate::AI}#{expiration_date_data}"
        batch_part = "#{GS1::Batch::AI}#{batch_data}"
        serial_number_part = "#{GS1::SerialNumber::AI}#{serial_number_data}"

        is_expected.to eq(gtin_part + expiration_date_part + batch_part + serial_number_part)
      end
    end

    context 'when invalid' do
      let(:valid) { false }

      it 'returns nil' do
        is_expected.to be_nil
      end
    end
  end

  describe '#valid?' do
    subject { barcode.valid?(level: level) }

    let(:gtin) { barcode.gtin }
    let(:batch) { barcode.batch }
    let(:expiration_date) { barcode.expiration_date }
    let(:serial_number) { barcode.serial_number }

    let(:gtin_valid) { true }
    let(:batch_valid) { true }
    let(:expiration_date_valid) { true }
    let(:serial_number_valid) { true }

    before do
      allow(gtin).to receive(:valid?).and_return(gtin_valid)
      allow(batch).to receive(:valid?).and_return(batch_valid)
      allow(expiration_date).to receive(:valid?).and_return(expiration_date_valid)
      allow(serial_number).to receive(:valid?).and_return(serial_number_valid)

      subject
    end

    context 'with level minimum' do
      let(:level) { GS1::AIDCMarketingLevels::MINIMUM }

      it 'validates gtin' do
        expect(gtin).to have_received(:valid?)
      end

      it 'does not validate batch' do
        expect(batch).not_to have_received(:valid?)
      end

      it 'does not validate expiration date' do
        expect(expiration_date).not_to have_received(:valid?)
      end

      it 'does not validate serial number' do
        expect(serial_number).not_to have_received(:valid?)
      end

      context 'when invalid gtin' do
        let(:gtin_valid) { false }

        it 'has invalid GTIN error' do
          expect(barcode.errors).to eq(['Invalid gtin'])
        end
      end
    end

    context 'with level enhanced' do
      let(:level) { GS1::AIDCMarketingLevels::ENHANCED }

      it 'validates gtin' do
        expect(gtin).to have_received(:valid?)
      end

      it 'validates batch' do
        expect(batch).to have_received(:valid?)
      end

      it 'validates expiration date' do
        expect(expiration_date).to have_received(:valid?)
      end

      it 'does not validate serial number' do
        expect(serial_number).not_to have_received(:valid?)
      end

      context 'when invalid batch' do
        let(:batch_valid) { false }

        it 'has invalid GTIN error' do
          expect(barcode.errors).to eq(['Invalid batch'])
        end
      end

      context 'when invalid expiration date' do
        let(:expiration_date_valid) { false }

        it 'has invalid GTIN error' do
          expect(barcode.errors).to eq(['Invalid expiration date'])
        end
      end
    end

    context 'when level highest' do
      let(:level) { GS1::AIDCMarketingLevels::HIGHEST }

      it 'validates gtin' do
        expect(gtin).to have_received(:valid?)
      end

      it 'validates batch' do
        expect(batch).to have_received(:valid?)
      end

      it 'validates expiration date' do
        expect(expiration_date).to have_received(:valid?)
      end

      it 'does not validate serial number' do
        expect(serial_number).to have_received(:valid?)
      end

      context 'when invalid serial number' do
        let(:serial_number_valid) { false }

        it 'has invalid GTIN error' do
          expect(barcode.errors).to eq(['Invalid serial number'])
        end
      end
    end
  end
end
