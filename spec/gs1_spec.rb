RSpec.describe GS1 do
  it 'has a version number' do
    expect(GS1::VERSION).not_to be nil
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
        around do |spec|
          old_value = described_class.configuration.company_prefix
          described_class.configure { _1.company_prefix = 'test' }
          spec.run
        ensure
          described_class.configuration.company_prefix = old_value
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
        around do |spec|
          old_value = described_class.configuration.barcode_separator
          described_class.configure { _1.barcode_separator = '~' }
          spec.run
        ensure
          described_class.configuration.barcode_separator = old_value
        end

        it 'returns set separator' do
          is_expected.to eq('~')
        end
      end
    end
  end
end
