RSpec.describe GS1::Batch do
  describe 'application identifier' do
    subject { described_class::AI }

    it { is_expected.to eq(GS1::AI::BATCH_LOT) }
  end

  describe 'definitions' do
    subject { described_class }

    it { is_expected.to define_allowed_length(1..20) }
    it { is_expected.not_to define_barcode_length }
    it { is_expected.to define_max_barcode_length(20) }
  end
end
