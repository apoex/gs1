RSpec.describe GS1 do
  it 'has a version number' do
    expect(GS1::VERSION).not_to be nil
  end

  it 'maps AI to classes' do
    expect(GS1::AI_CLASSES).to match(GS1::AI::SSCC => GS1::SSCC,
                                     GS1::AI::GTIN => GS1::GTIN,
                                     GS1::AI::CONTENT => GS1::Content,
                                     GS1::AI::BATCH_LOT => GS1::Batch,
                                     GS1::AI::USE_BY => GS1::ExpirationDate,
                                     GS1::AI::SERIAL => GS1::SerialNumber)
  end

  describe '.configure' do
    let(:configuration) { described_class.configuration }

    describe 'company prefix' do
      subject { configuration.company_prefix }

      context 'when not specified' do
        before { described_class.configure }

        it 'returns default separator' do
          is_expected.to be_nil
        end
      end

      context 'when specified' do
        before do
          described_class.configure do |config|
            config.company_prefix = 'test'
          end
        end

        it 'returns company prefix' do
          is_expected.to eq('test')
        end
      end
    end

    describe 'barcode separator' do
      subject { configuration.barcode_separator }

      context 'when not specified' do
        before { described_class.configure }

        it 'returns default separator' do
          is_expected.to eq("\u001E")
        end
      end

      context 'when specified' do
        before do
          described_class.configure do |config|
            config.barcode_separator = '~'
          end
        end

        it 'returns set separator' do
          is_expected.to eq('~')
        end
      end
    end
  end
end
