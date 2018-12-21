require 'rspec'
require 'pry'
require_relative 'point'

RSpec.describe Point do
  let(:subject) { described_class.new(start_coord: start_coord, name: name, board_size: 20) }
  let(:name) { "A" }

  describe '#emit_new_coords' do
    context 'when current outwards steps is 1' do
      before { subject.outward_steps = 1 }

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
        let(:expected_result) { [[2, 0], [1, 1], [0, 2], [1, 3], [2, 4], [3, 3], [4, 2], [3, 1]] }

        it 'returns new coords' do
          expect(subject.emit_new_coords.sort).to eq expected_result.sort
        end
      end

      context 'and initial coords are [3, 4]' do
        let(:start_coord) { [3, 4] }
        let(:expected_result) { [[1, 4], [2, 3], [2, 5], [3, 2], [3, 6], [4, 3], [4, 5], [5, 4]] }

        it 'returns new coords' do
          expect(subject.emit_new_coords.sort).to eq expected_result.sort
        end
      end
    end

    context 'when outwards steps is 3' do
      before { subject.outward_steps = 3 }

      context 'and initial coords are [2, 2]' do
        let(:start_coord) { [2, 2] }
        let(:expected_result) { [[0, 1], [0, 3], [1, 0], [1, 4], [2, 5], [3, 0], [3, 4], [4, 1], [4, 3], [5, 2]] }

        it 'returns new coords' do
          expect(subject.emit_new_coords.sort).to eq expected_result.sort
        end
      end
    end
  end
end
