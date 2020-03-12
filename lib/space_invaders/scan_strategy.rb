# frozen_string_literal: true

module SpaceInvaders
  class ScanStrategy
    RADAR_BACKGROUND_CHAR = '-'
    ACCURACY = 0.85

    attr_reader :radar, :invader

    class << self
      def call(radar:, invaders:)
        results = invaders.map { |invader| new(radar: radar, invader: invader).calculate }
        merge_results(results: results, radar: radar, invaders: invaders)
      end

      private

      def merge_results(results:, radar:, invaders:)
        output = Array.new(radar.height) { Array.new(radar.width, RADAR_BACKGROUND_CHAR) }

        results.each_with_index do |result, index|
          result.each_with_index do |row, index_x|
            row.each_with_index do |element, index_y|
              output[index_x][index_y] = invaders[index].id if element >= ACCURACY
            end
          end
        end

        output
      end
    end

    def initialize(radar:, invader:)
      @radar, @invader = radar, invader
      @similarity_matrix = Array.new(radar.height) { Array.new(radar.width, 0) }
    end

    def calculate
      radar.matrix[0..max_row_index].each_with_index do |row, row_index|
        row[0..max_col_index].each_index do |col_index|
          row_range, col_range = calculate_window_range(row_index, col_index, invader)
          radar_window = radar.data_range(row_range, col_range)
          similarity = window_similarity(radar_window, invader)
          update_similarity(similarity, row_range, col_range) if similarity
        end
      end

      @similarity_matrix
    end

    private

    def max_row_index
      radar.height - invader.height
    end

    def max_col_index
      radar.width - invader.width
    end

    def calculate_window_range(row_index, index, invader)
      row_range = (row_index..(invader.height + row_index - 1))
      column_range = (index..(invader.width + index - 1))

      return row_range, column_range
    end

    def window_similarity(radar_window, invader)
      points = radar_window.zip(invader.matrix).flat_map do |a, b|
        a.zip(b).map { |c, d| c == d }
      end

      points.count(true) / points.size.to_f
    end

    def update_similarity(similarity, row_range, column_range)
      row_range.to_a.each do |i|
        column_range.to_a.each do |j|
          @similarity_matrix[i][j] = similarity if @similarity_matrix[i][j] < similarity
        end
      end
    end
  end
end