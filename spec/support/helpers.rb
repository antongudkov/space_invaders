# frozen_string_literal: true

module Helpers
  def load_fixture(file_name)
    File.read("spec/fixtures/#{file_name}.txt")
  end
end