require 'spec_helper'

RSpec.describe GS1::Barcode::Errors do
  let(:errors) { described_class.new }

  let(:unpersistent_error) { GS1::Barcode::Error.new(:wow) }
  let(:persistent_error) { GS1::Barcode::Error.new(:invalid, persistent: true) }

  describe '#clear' do
    subject(:clear) { errors.clear }

    before do
      errors[:test] << persistent_error
      errors[:test] << unpersistent_error
    end

    it 'clears unpersistent errors' do
      expect(errors[:test]).to match_array([persistent_error, unpersistent_error])

      expect { subject }.to change { errors[:test].size }.from(2).to(1)

      expect(errors[:test]).to eq([persistent_error])
    end
  end

  describe '#empty?' do
    subject(:empty?) { errors.empty? }

    context 'when no errors' do
      it { is_expected.to be_truthy }
    end

    context 'when errors' do
      before do
        errors[:test] << persistent_error
      end

      it { is_expected.to be_falsy }
    end
  end

  describe '#messages' do
    subject(:messages) { errors.messages }

    before do
      errors[:test] << persistent_error
    end

    it 'return hashes with errors' do
      expect(subject).to eq(test: ['Invalid'])
    end
  end

  describe '#full_messages' do
    subject(:full_messages) { errors.full_messages }

    before do
      errors[:test] << persistent_error
    end

    it 'return arrays with errors' do
      expect(subject).to eq(['Invalid test'])
    end
  end
end
