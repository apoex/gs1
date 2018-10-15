RSpec.describe GS1::SerialNumber do
  describe 'application identifier' do
    subject { described_class::AI }

    it { is_expected.to eq(GS1::AI::SERIAL) }
  end

  describe 'definitions' do
    subject { described_class }

    it { is_expected.to define_allowed_length(1..20) }
  end
end
