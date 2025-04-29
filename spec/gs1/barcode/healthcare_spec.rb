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

  describe 'example scans' do
    subject { described_class.from_scan(data) }

    context 'when nil' do
      let(:data) { nil }

      it 'nils all attributes' do
        expect(subject).not_to be_valid
        expect(subject.gtin).to be_nil
        expect(subject.expiration_date).to be_nil
        expect(subject.batch).to be_nil
        expect(subject.serial_number).to be_nil
      end
    end

    context "01000000123123131718100310123123123\u001E21123123" do
      let(:data) { "01000000123123131718100310123123123\u001E21123123" }

      it 'sets all attributes' do
        expect(subject.gtin).to eq(GS1::GTIN.new('00000012312313'))
        expect(subject.expiration_date).to eq(GS1::ExpirationDate.new('181003'))
        expect(subject.batch).to eq(GS1::Batch.new('123123123'))
        expect(subject.serial_number).to eq(GS1::SerialNumber.new('123123'))
      end
    end

    context 'maximum length of serial number + separator' do
      let(:data) { "01070462606504112101582353425597816838\u001E1721093010184238131" }

      it 'sets all attributes' do
        expect(subject.gtin).to eq(GS1::GTIN.new('07046260650411'))
        expect(subject.expiration_date).to eq(GS1::ExpirationDate.new('210930'))
        expect(subject.batch).to eq(GS1::Batch.new('184238131'))
        expect(subject.serial_number).to eq(GS1::SerialNumber.new('01582353425597816838'))
      end
    end

    context 'double scan with SSCC' do
      let(:data) { "00373322680596223355010880959317002021122286213337\u001E1722013110F1903227" }

      context 'when configured to not ignore extra barcode elements' do
        around do |spec|
          old_value = GS1.configuration.ignore_extra_barcode_elements
          GS1.configuration.ignore_extra_barcode_elements = false
          spec.run
        ensure
          GS1.configuration.ignore_extra_barcode_elements = old_value
        end

        it 'is not valid' do
          expect(subject).not_to be_valid
          expect(subject.errors.full_messages).to eq(['Unknown attribute sscc'])
          expect(subject.gtin).to eq(GS1::GTIN.new('08809593170020'))
          expect(subject.expiration_date).to eq(GS1::ExpirationDate.new('220131'))
          expect(subject.batch).to eq(GS1::Batch.new('F1903227'))
          expect(subject.serial_number).to eq(GS1::SerialNumber.new('122286213337'))
        end
      end
    end

    context 'double scan with expiration date' do
      let(:data) { "010880959317002021122286213337\u001E1722013110F1903227\u001E17220131" }

      it 'is not valid' do
        expect(subject).not_to be_valid
        expect(subject.errors.full_messages).to eq(['Already defined expiration date'])
        expect(subject.gtin).to eq(GS1::GTIN.new('08809593170020'))
        expect(subject.expiration_date).to eq(GS1::ExpirationDate.new('220131'))
        expect(subject.batch).to eq(GS1::Batch.new('F1903227'))
        expect(subject.serial_number).to eq(GS1::SerialNumber.new('122286213337'))
      end
    end

    context 'double scan with self' do
      let(:data) do
        "010880959317102021122286213337\u001E1722013110F1903227" \
          "010880959317102021122286213337\u001E1722013110F1903227"
      end

      context 'when configured to not ignore extra barcode elements' do
        around do |spec|
          old_value = GS1.configuration.ignore_extra_barcode_elements
          GS1.configuration.ignore_extra_barcode_elements = false
          spec.run
        ensure
          GS1.configuration.ignore_extra_barcode_elements = old_value
        end

        it 'is not valid' do
          expect(subject).not_to be_valid
          expect(subject.errors.messages).to eq(batch: ['Already defined'],
                                                expiration_date: ['Already defined'],
                                                gtin: ['Invalid'])
          expect(subject.errors.full_messages).to eq(['Already defined batch',
                                                      'Already defined expiration date',
                                                      'Invalid gtin'])
          expect(subject.gtin).to eq(GS1::GTIN.new('08809593171020'))
          expect(subject.expiration_date).to eq(GS1::ExpirationDate.new('220131'))
          expect(subject.batch).to eq(GS1::Batch.new('F1903227'))
          expect(subject.serial_number).to eq(GS1::SerialNumber.new('122286213337'))
        end
      end
    end
  end

  describe '#to_s' do
    let(:separator) { "\u001E" }

    let(:level) { GS1::AIDCMarketingLevels::ENHANCED }

    context 'with stubbed values' do
      subject { barcode.to_s(separator: separator) }

      before do
        expect(barcode).to receive(:valid?).with(level: level).and_return(valid)
      end

      context 'when valid' do
        let(:valid) { true }

        let(:expected_gtin_part) { "#{GS1::GTIN::AI}#{gtin_data}" }
        let(:expected_expiration_date_part) { "#{GS1::ExpirationDate::AI}#{expiration_date_data}" }
        let(:expected_batch_part) { "#{GS1::Batch::AI}#{batch_data}" }
        let(:expected_serial_number_part) { "#{GS1::SerialNumber::AI}#{serial_number_data}" }

        it 'returns all attributes concatenated in same order as params' do
          is_expected.to eq(expected_gtin_part +
                            expected_batch_part + separator +
                            expected_expiration_date_part +
                            expected_serial_number_part)
        end

        context 'when two variable length records in a row' do
          let(:options) do
            { gtin: gtin_data,
              batch: batch_data,
              serial_number: serial_number_data,
              expiration_date: expiration_date_data }
          end

          it 'returns all attributes concatenated in same order as params' do
            is_expected.to eq(expected_gtin_part +
                              expected_batch_part + separator +
                              expected_serial_number_part + separator +
                              expected_expiration_date_part)
          end

          context 'and serial number is nil' do
            let(:serial_number_data) { nil }

            it 'does not add an extra separator' do
              is_expected.to eq(expected_gtin_part +
                                expected_batch_part + separator +
                                expected_expiration_date_part)
            end
          end
        end
      end

      context 'when invalid' do
        let(:valid) { false }

        it 'returns nil' do
          is_expected.to be_nil
        end
      end
    end

    context "when 01000000123123131718100310123123123\u001E21123123" do
      let(:example_scan) { "01000000123123131718100310123123123\u001E21123123" }
      let(:rescan) { described_class.from_scan(subject.to_s) }

      subject { described_class.from_scan(example_scan) }

      it 'reproduces the input' do
        expect(subject.to_s).to eq example_scan
      end

      it 'is reparseable', :aggregate_failures do
        expect { rescan }.not_to raise_error

        expect(rescan.gtin).to eq subject.gtin
        expect(rescan.batch).to eq subject.batch
        expect(rescan.expiration_date).to eq subject.expiration_date
        expect(rescan.serial_number).to eq subject.serial_number
      end
    end

    context 'when 01000000123123131718100310123123123' do
      let(:example_scan) { '01000000123123131718100310123123123' }
      let(:rescan) { described_class.from_scan(subject.to_s) }

      subject { described_class.from_scan(example_scan) }

      it 'reproduces the input' do
        expect(subject.to_s).to eq example_scan
      end
    end

    context "when 010000001231231310123123123\u001E17181003" do
      let(:example_scan) { "010000001231231310123123123\u001E17181003" }
      let(:rescan) { described_class.from_scan(subject.to_s) }

      subject { described_class.from_scan(example_scan) }

      it 'reproduces the input' do
        expect(subject.to_s).to eq example_scan
      end
    end

    context 'when 0100000012312313' do
      let(:example_scan) { '0100000012312313' }
      let(:rescan) { described_class.from_scan(subject.to_s) }

      subject { described_class.from_scan(example_scan) }

      it 'reproduces the input' do
        expect(subject.to_s(level: GS1::AIDCMarketingLevels::MINIMUM)).to eq example_scan
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
          expect(barcode.errors.messages).to eq(gtin: ['Invalid'])
          expect(barcode.errors.full_messages).to eq(['Invalid gtin'])
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
          expect(barcode.errors.messages).to eq(batch: ['Invalid'])
          expect(barcode.errors.full_messages).to eq(['Invalid batch'])
        end
      end

      context 'when invalid expiration date' do
        let(:expiration_date_valid) { false }

        it 'has invalid GTIN error' do
          expect(barcode.errors.messages).to eq(expiration_date: ['Invalid'])
          expect(barcode.errors.full_messages).to eq(['Invalid expiration date'])
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
          expect(barcode.errors.messages).to eq(serial_number: ['Invalid'])
          expect(barcode.errors.full_messages).to eq(['Invalid serial number'])
        end
      end
    end
  end
end
