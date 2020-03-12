RSpec.describe SpaceInvaders::Invader do
  subject { described_class.new(data: load_fixture('invader_1'), id: 1) }

  it 'has id' do
    expect(subject.id).to eq(1)
  end

  it 'has height and width' do
    expect(subject.height).to eq(8)
    expect(subject.width).to eq(11)
  end

  it 'has matrix representation' do
    matrix = subject.data_lines.map(&:chars)
    expect(subject.matrix).to eq(matrix)
  end

  it 'has row mask' do
    expect(subject.row_mask).to eq('11111111111')
  end
end