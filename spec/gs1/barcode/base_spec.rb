RSpec.describe GS1::Barcode::Base do
  module GS1
    module Barcode
      class Dummy < Base
        define_records GTIN,
                       SSCC,
                       ExpirationDate,
                       SerialNumber,
                       Batch,
                       Content
      end
    end
  end

  describe '.from_scan' do
    subject { GS1::Barcode::Dummy.from_scan(data) }

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
      subject { GS1::Barcode::Dummy.from_scan(data, separator: separator) }

      let(:separator) { '~' }

      include_examples 'sets all attributes from barcode'
    end

    context 'with barcode containing unknown application identifier' do
      let(:data) do
        "#{GS1::AI::FISHING_GEAR_TYPE}00000000000000"
      end

      it 'does not raise anyting' do
        expect { subject }.not_to raise_error
      end

      it 'sets all attributes from barcode' do
        expect(subject.batch).to eq(GS1::Batch.new(nil))
        expect(subject.expiration_date).to eq(GS1::ExpirationDate.new(nil))
        expect(subject.gtin).to eq(GS1::GTIN.new(nil))
        expect(subject.serial_number).to eq(GS1::SerialNumber.new(nil))
        expect(subject.sscc).to eq(GS1::SSCC.new(nil))
      end
    end
  end

  describe '.from_scan!' do
    subject { GS1::Barcode::Dummy.from_scan!(data) }

    context 'with barcode containing unknown application identifier' do
      let(:data) do
        "#{GS1::AI::FISHING_GEAR_TYPE}00000000000000"
      end

      it 'raises invalid token error' do
        expect { subject }.to raise_error(GS1::Barcode::InvalidTokenError,
                                          'Unable to retrieve record from application identifier(s) 70, 700, 7009')
      end
    end
  end

  describe '.scan_to_params' do
    shared_examples 'returns all attributes from barcode' do
      it 'returns all attributes from barcode' do
        expect(subject).to eq(batch: 'THISISABATCH',
                              expiration_date: '181016',
                              gtin: '00000000000000',
                              serial_number: 'zzzzzzz',
                              sscc: '123123123123123123')
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
      subject { GS1::Barcode::Dummy.scan_to_params(data) }

      let(:separator) { "\u001E" }

      include_examples 'returns all attributes from barcode'
    end

    context 'another separator' do
      subject { GS1::Barcode::Dummy.scan_to_params(data, separator: separator) }

      let(:separator) { '~' }

      include_examples 'returns all attributes from barcode'
    end

    context 'with barcode containing unknown application identifier' do
      subject { GS1::Barcode::Dummy.scan_to_params(data) }
      let(:data) { '123456' }

      it 'returns an empty hash' do
        expect(subject).to eq({})
      end
    end
  end

  describe '.scan_to_params!' do
    context 'with barcode containing unknown application identifier' do
      subject { GS1::Barcode::Dummy.scan_to_params!(data) }
      let(:data) { '123456' }

      it 'raises invalid token error' do
        expect { subject }.to raise_error(GS1::Barcode::InvalidTokenError,
                                          'Unable to retrieve record from application identifier(s) 12, 123, 1234')
      end
    end

    context 'with barcode containing unknown application identifier' do
      subject { GS1::Barcode::Dummy.scan_to_params!(data) }
      let(:data) { '011231231231231210' }

      it 'raises invalid token error' do
        expect { subject }.to raise_error(GS1::Barcode::InvalidTokenError,
                                          'Unable to retrieve data to GS1::Batch')
      end
    end
  end
end
