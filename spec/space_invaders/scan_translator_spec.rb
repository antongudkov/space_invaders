# frozen_string_literal: true

RSpec.describe SpaceInvaders::ScanTranslator do
  let(:invader) { SpaceInvaders::Invader.new(data: load_fixture('invader_1'), id: 1) }

  describe '.call' do
    let(:scan_result) { Array.new(invader.height) { Array.new(invader.width, invader.id.to_s) } }

    it 'translates mask to invader image' do
      result = described_class.call(scan_result: scan_result, invaders: [invader])
      
      result.each_with_index do |r, i|
        expect(r).to eq(invader.data_lines[i])
      end
    end
  end

  describe '#translate' do
    let(:row) {}
    let(:last_translated_row) {}

    subject do
      described_class.new(row: row, last_translated_row: last_translated_row, invader: invader)
    end

    context 'when row contains invader row mask' do
      let(:row) { "-------------#{invader.row_mask}--------" }
      let(:expected_translation) { "-------------#{invader.data_lines[0]}--------" }

      it 'translates row mask to invader row' do
        expect(subject.translate).to eq(expected_translation)
      end

      context 'with last translated row' do
        let(:last_translated_row) { "-------------#{invader.data_lines[2]}--------" }
        let(:expected_translation) { "-------------#{invader.data_lines[3]}--------" }

        it 'translates row mask to next invader row' do
          expect(subject.translate).to eq(expected_translation)
        end
      end
    end

    context 'when row does not contain invader row mask' do
      let(:row) { "----------------------------------" }

      it 'returns original row' do
        expect(subject.translate).to eq(row)
      end
    end
  end
end