RSpec.describe GS1::Barcode::Base do
  let(:dummy) do
    Class.new(GS1::Barcode::Base) do
      define_records GS1::GTIN,
                     GS1::SSCC,
                     GS1::ExpirationDate,
                     GS1::SerialNumber,
                     GS1::Batch,
                     GS1::Content
    end
  end

  describe '.from_scan' do
    subject { dummy.from_scan(data) }

    shared_examples 'sets all attributes from barcode' do
      it 'sets all attributes from barcode' do
        expect(subject.batch).to eq(GS1::Batch.new('THISISABATCH'))
        expect(subject.expiration_date).to eq(GS1::ExpirationDate.new('181016'))
        expect(subject.gtin).to eq(GS1::GTIN.new('00000000000000'))
        expect(subject.serial_number).to eq(GS1::SerialNumber.new('zzzzzzz'))
        expect(subject.sscc).to eq(GS1::SSCC.new('123123123123123123'))
      end
    end

    let(:data) do
      "#{GS1::GTIN::AI}00000000000000" \
        "#{GS1::ExpirationDate::AI}181016" \
        "#{GS1::SerialNumber::AI}zzzzzzz#{separator}" \
        "#{GS1::Batch::AI}THISISABATCH#{separator}" \
        "#{GS1::SSCC::AI}123123123123123123"
    end

    context 'default separator' do
      let(:separator) { GS1.configuration.barcode_separator }

      include_examples 'sets all attributes from barcode'
    end

    context 'another separator' do
      subject { dummy.from_scan(data, separator: separator) }

      let(:separator) { '~' }

      include_examples 'sets all attributes from barcode'
    end

    context 'with barcode containing unknown application identifier' do
      subject { dummy.from_scan(data, ai_classes: {}) }

      let(:data) do
        "#{GS1::AI::FISHING_GEAR_TYPE}00000000000000"
      end

      it 'does not raise anything' do
        expect { subject }.not_to raise_error
      end

      it 'sets mismatched attributes to nil' do
        expect(subject.batch).to be_nil
        expect(subject.expiration_date).to be_nil
        expect(subject.gtin).to be_nil
        expect(subject.serial_number).to be_nil
        expect(subject.sscc).to be_nil
      end
    end

    context 'when the barcode contains extra elements' do
      subject { dummy.from_scan(data, separator: separator) }
      let(:separator) { "\u001E" }

      let(:data) do
        '70040000' \
          "#{GS1::ExpirationDate::AI}181016" \
          "#{GS1::SerialNumber::AI}zzzzzzz#{separator}" \
          "#{GS1::Batch::AI}THISISABATCH#{separator}" \
          "#{GS1::SSCC::AI}123123123123123123"
      end

      it 'sets the known attributes' do
        expect(subject).to have_attributes(
          batch: GS1::Batch.new('THISISABATCH'),
          expiration_date: GS1::ExpirationDate.new('181016'),
          serial_number: GS1::SerialNumber.new('zzzzzzz'),
          sscc: GS1::SSCC.new('123123123123123123'),
          gtin: be_nil
        )
      end
    end
  end

  describe '.from_scan!' do
    context 'when configured to not ignore extra barcode elements' do
      around do |spec|
        old_value = GS1.configuration.ignore_extra_barcode_elements
        GS1.configuration.ignore_extra_barcode_elements = false
        spec.run
      ensure
        GS1.configuration.ignore_extra_barcode_elements = old_value
      end

      context 'with barcode containing unknown application identifier' do
        subject { dummy.from_scan!(data, ai_classes: {}) }

        let(:data) do
          "#{GS1::AI::FISHING_GEAR_TYPE}00000000000000"
        end

        it 'raises invalid token error' do
          expect { subject }.to raise_error(GS1::Barcode::InvalidTokenError,
                                            'Unable to retrieve record from application identifier(s) 70, 700, 7009')
        end
      end
    end
  end

  describe '.scan_to_params' do
    shared_examples 'returns all attributes from barcode' do
      it 'returns all attributes from barcode' do
        expect(subject).to eq([
                                [:gtin, '00000000000000'],
                                [:expiration_date, '181016'],
                                [:serial_number, 'zzzzzzz'],
                                [:batch, 'THISISABATCH'],
                                [:sscc, '123123123123123123']
                              ])
      end
    end

    let(:data) do
      "#{GS1::GTIN::AI}00000000000000" \
        "#{GS1::ExpirationDate::AI}181016" \
        "#{GS1::SerialNumber::AI}zzzzzzz#{separator}" \
        "#{GS1::Batch::AI}THISISABATCH#{separator}" \
        "#{GS1::SSCC::AI}123123123123123123"
    end

    context 'default separator' do
      subject { dummy.scan_to_params(data) }

      let(:separator) { "\u001E" }

      include_examples 'returns all attributes from barcode'
    end

    context 'another separator' do
      subject { dummy.scan_to_params(data, separator: separator) }

      let(:separator) { '~' }

      include_examples 'returns all attributes from barcode'
    end

    context 'with barcode containing unknown application identifier' do
      subject { dummy.scan_to_params(data, ai_classes: {}) }
      let(:data) { '123456' }

      it 'returns an empty array' do
        expect(subject).to eq([])
      end
    end
  end

  describe '.scan_to_params!' do
    context 'with barcode containing unknown application identifier' do
      subject { dummy.scan_to_params!(data, ai_classes: {}) }
      let(:data) { '123456' }

      it 'raises invalid token error' do
        expect { subject }.to raise_error(GS1::Barcode::InvalidTokenError,
                                          'Unable to retrieve record from application identifier(s) 12, 123, 1234')
      end
    end

    context 'with barcode containing unknown application identifier' do
      subject { dummy.scan_to_params!(data) }
      let(:data) { '011231231231231210' }

      it 'raises invalid token error' do
        expect { subject }.to raise_error(GS1::Barcode::InvalidTokenError,
                                          'Unable to retrieve data to GS1::Batch')
      end
    end
  end

  describe 'errors' do
    subject(:base) { dummy.from_scan(data) }

    context 'when the data is valid' do
      let(:data) { "#{GS1::GTIN::AI}00000000000000" }
      let(:dummy) { Class.new(GS1::Barcode::Base) { define_records GS1::GTIN } }

      it 'returns no errors' do
        expect(base.errors).to be_empty
      end
    end

    context 'when the data is not valid' do
      let(:data) { "#{GS1::GTIN::AI}00000000000000" }
      let(:dummy) { Class.new(GS1::Barcode::Base) { define_records GS1::SSCC } }
      let(:ignore_extra_barcode_elements) { nil }

      around do |spec|
        old_value = GS1.configuration.ignore_extra_barcode_elements
        GS1.configuration.ignore_extra_barcode_elements = ignore_extra_barcode_elements
        spec.run
      ensure
        GS1.configuration.ignore_extra_barcode_elements = old_value
      end

      context 'when configured to not ignore extra barcode elements' do
        let(:ignore_extra_barcode_elements) { false }

        it 'returns a list of errors' do
          expect(base.errors).not_to be_empty
        end
      end

      context 'when configured to not ignore extra barcode elements' do
        let(:ignore_extra_barcode_elements) { true }

        it 'returns a list of errors' do
          expect(base.errors).to be_empty
        end
      end
    end
  end
end
