# frozen_string_literal: true

RSpec.describe SpaceInvaders::Scanner do
  let(:radar_sample) { load_fixture('radar_sample') }
  let(:invader_1) { load_fixture('invader_1') }
  let(:invader_2) { load_fixture('invader_2') }

  describe '.call' do
    it '' do
      result = described_class.call(radar_sample: radar_sample, invaders: [invader_1, invader_2])
    end
  end
end