# frozen_string_literal: true

module SpaceInvaders
  class ScanTranslator
    attr_reader :last_translated_row, :row, :previous_row, :invader

    class << self
      def call(scan_result:, invaders:)
        translated_results  = []

        scan_result.each_with_index do |result_row, row_index|
          row = result_row.join('')
          
          invaders.each do |invader|
            row = new(row: row, last_translated_row: translated_results.last, invader: invader).translate
          end

          translated_results << row
        end

        translated_results
      end
    end

    def initialize(row:, last_translated_row:, invader:)
      @row = row.dup
      @last_translated_row = last_translated_row
      @invader = invader
    end

    def translate
      matches.each { |match_index| translate_match(match_index) }
      row
    end

    private

    def matches
      row.gsub(invader.row_mask).map { Regexp.last_match.begin(0) }
    end

    def translate_match(match_index)
      line_index = invader_row_index_for(match_index)
      line_index = line_index ? line_index + 1 : 0
      row[match_index, invader.width] = invader.data_lines[line_index] if invader.data_lines[line_index]
    end

    def invader_row_index_for(match_index)
      return unless last_translated_row
      invader.data_lines.find_index { |data_line| last_translated_row[match_index, invader.width] == data_line }
    end
  end
end