# frozen_string_literal: true

module SpaceInvaders
  module Matrix
    def data_lines
      @data_lines ||= @data.split("\n").reject(&:empty?)
    end

    def matrix
      @matrix ||= data_lines.map(&:chars)
    end

    def width
      matrix.first.size
    end

    def height
      matrix.size
    end
  end
end