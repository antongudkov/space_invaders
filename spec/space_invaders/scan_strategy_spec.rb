# frozen_string_literal: true

RSpec.describe SpaceInvaders::ScanStrategy do
  let(:radar_sample) {}
  let(:radar) { SpaceInvaders::Radar.new(load_fixture(radar_sample)) }
  let(:invader) { SpaceInvaders::Invader.new(data: load_fixture('invader_1'), id: 1) }

  describe '.call' do
    context 'with full match' do
      let(:radar_sample) { 'invader_1' }

      it 'reveals invader' do
        result = described_class.call(radar: radar, invaders: [invader])
        expect(result.first.first).to eq(invader.id)
        expect(result.last.last).to eq(invader.id)
      end
    end

    context 'with partial match high similarity' do
      let(:radar_sample) { 'radar_sample_partial_match_high_similarity' }
      
      it 'reveals invader with accuracy' do
        result = described_class.call(radar: radar, invaders: [invader])
        expect(result.first.first).to eq(invader.id)
        expect(result.last.last).to eq(invader.id)
      end
    end

    context 'with partial match low similarity' do
      let(:radar_sample) { 'radar_sample_partial_match_low_similarity' }
      
      it 'does not reveal invader' do
        result = described_class.call(radar: radar, invaders: [invader])
        expect(result.first.first).to eq('-')
        expect(result.last.last).to eq('-')
      end
    end
  end

  describe '#calculate' do
    subject do
      described_class.new(radar: radar, invader: invader)
    end

    context 'with full match' do
      let(:radar_sample) { 'invader_1' }

      it 'calculates full match' do
        result = subject.calculate
        expect(result[0][0]).to eql(1.0)
      end
    end

    context 'with partial match' do
      let(:radar_sample) { 'radar_sample_partial_match_high_similarity' }

      it 'calculates similarity match' do
        result = subject.calculate
        expect(result[0][0]).to eql(0.875)
      end
    end
  end
end