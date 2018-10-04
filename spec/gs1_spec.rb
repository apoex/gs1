RSpec.describe GS1 do
  it 'has a version number' do
    expect(GS1::VERSION).not_to be nil
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
