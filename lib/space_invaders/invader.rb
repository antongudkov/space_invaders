# frozen_string_literal: true

module SpaceInvaders
  class Invader
    include Matrix

    attr_reader :id

    def initialize(data:, id:)
      @data = data
      @id = id
    end

    def row_mask
      id.to_s * width
    end
  end
end