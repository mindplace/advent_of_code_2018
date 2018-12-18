require 'rspec'
require_relative 'point.rb'

RSpec.describe Point do
  let(:subject) { described_class.new(start_coord: start_coord) }

  describe '#emit_new_coords' do
    context 'when outwards steps is 0' do
      context 'and initial coords are [2, 2]' do
        let(:start_coord) { [2, 2] }
        let(:expected_result) { [[1, 2], [2, 1], [3, 2], [2, 3]] }

        it 'returns new coords' do
          expect(subject.emit_new_coords.sort).to eq expected_result.sort
        end
      end

      context 'and initial coords are [4, 4]' do
        let(:start_coord) { [4, 4] }
        let(:expected_result) { [[3, 4], [5, 4], [4, 3], [4, 5]] }

        it 'returns new coords' do
          expect(subject.emit_new_coords.sort).to eq expected_result.sort
        end
      end
    end

    context 'when outwards steps is 2' do
      before { subject.outward_steps = 2 }

      context 'and initial coords are [2, 2]' do
        let(:start_coord) { [2, 2] }
        let(:expected_result) { [[5, 2], [2, 5], [0, 0], [4, 4], [0, 4], [4, 0]] }

        it 'returns new coords' do
          expect(subject.emit_new_coords.sort).to eq expected_result.sort
        end
      end

      context 'and initial coords are [4, 4]' do
        let(:start_coord) { [4, 4] }
        let(:expected_result) { [[1, 4], [7, 4], [4, 7], [4, 1], [2, 2], [6, 6], [2, 6], [6, 2]] }

        it 'returns new coords' do
          expect(subject.emit_new_coords.sort).to eq expected_result.sort
        end
      end
    end
  end
end
