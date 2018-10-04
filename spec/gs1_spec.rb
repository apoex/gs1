RSpec.describe GS1 do
  it 'has a version number' do
    expect(GS1::VERSION).not_to be nil
  end

  it 'maps AI to classes' do
    expect(GS1::AI_CLASSES).to match(GS1::AI::SSCC      => GS1::SSCC,
                                     GS1::AI::GTIN      => GS1::GTIN,
                                     GS1::AI::CONTENT   => GS1::Content,
                                     GS1::AI::BATCH_LOT => GS1::Batch,
                                     GS1::AI::USE_BY    => GS1::ExpirationDate,
                                     GS1::AI::SERIAL    => GS1::SerialNumber)
  end

  describe '.configure' do
    subject { described_class.configuration }

    it 'can set company prefix' do
      described_class.configure do |config|
        config.company_prefix = 'test'
      end

      expect(subject.company_prefix).to eq('test')
    end
  end
end
