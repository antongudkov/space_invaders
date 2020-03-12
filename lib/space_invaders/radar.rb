# frozen_string_literal: true

module SpaceInvaders
  class Radar
    include Matrix

    def initialize(data)
      @data = data
    end

    def data_range(row_range, column_range)
      matrix[row_range].map { |row| row[column_range] }
    end
  end
end