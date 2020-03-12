RSpec.describe SpaceInvaders::Radar do
  subject { described_class.new(load_fixture('radar_sample')) }

  it 'has height and width' do
    expect(subject.height).to eq(50)
    expect(subject.width).to eq(100)
  end

  it 'has matrix representation' do
    matrix = subject.data_lines.map(&:chars)
    expect(subject.matrix).to eq(matrix)
  end

  describe '#data_range' do
    it 'returns given number of rows and cols' do
      data_range = subject.data_range((0..2), (0..3))
      expect(data_range.size).to eq(3)
      expect(data_range.first.size).to eq(4)
    end
  end
end