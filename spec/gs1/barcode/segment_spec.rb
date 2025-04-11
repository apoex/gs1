require 'spec_helper'

RSpec.describe GS1::Barcode::Segment do
  subject(:segment) { described_class.new(data, ai_classes: ai_classes) }

  let(:data) { nil }
  let(:ai_classes) { nil }

  let(:ai_class) do
    Class.new(GS1::Record) do
      self::AI = SecureRandom.uuid

      define :length, allowed: 14
      def self.name = '01'
    end
  end

  describe 'to_params' do
    context 'when the AI code is recognized' do
      let(:data) { '0100000000000000' }
      let(:ai_classes) { { '01' => ai_class } }

      it 'returns a tuple of the AI name and the data' do
        expect(segment.to_params).to eq([:'01', '00000000000000'])
      end
    end

    context 'when the AI code is not recognized' do
      let(:data) { '0300000000000000' }
      let(:ai_classes) { { '01' => ai_class } }

      it 'returns an empty tuple' do
        expect(segment.to_params).to be_empty
      end
    end
  end

  describe 'valid?' do
    context 'when the AI code is recognized' do
      let(:data) { '0100000000000000' }
      let(:ai_classes) { { '01' => ai_class } }

      it 'is is a valid segment' do
        expect(segment).to be_valid
      end
    end

    context 'when the AI code is not recognized' do
      let(:data) { '0300000000000000' }
      let(:ai_classes) { { '01' => ai_class } }

      it 'is is not a valid segment' do
        expect(segment).not_to be_valid
      end
    end
  end
end
