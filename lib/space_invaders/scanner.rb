# frozen_string_literal: true

module SpaceInvaders
  class Scanner
    def self.call(radar_sample:, invaders:)
      radar = Radar.new(radar_sample)
      invaders = invaders.map.with_index { |invader, index| Invader.new(data: invader, id: index + 1) }

      scan_result = ScanStrategy.call(radar: radar, invaders: invaders)
      ScanTranslator.call(scan_result: scan_result, invaders: invaders)
    end
  end
end