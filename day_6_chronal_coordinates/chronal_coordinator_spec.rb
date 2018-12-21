require 'rspec'
require 'pry'
require_relative 'chronal_coordinator'


RSpec.describe ChronalCoordinator do
  subject { described_class.new(board_size: board_size, points_inputs: points_inputs) }
  let(:file_inputs) { File.readlines('inputs.txt').map { |line| eval("[" + line.chomp + "]").reverse } }

  describe '#initialize' do
    context 'when given sample input' do
      let(:board_size) { 10 }
      let(:points_inputs) { [[1, 1], [1, 6], [8, 3], [3, 4], [5, 5], [8, 9]].map(&:reverse) }

      it 'builds a board on initialize' do
        expect(subject.board).not_to be_nil
      end

      it 'builds an array of Point objects on initialize' do
        expect(subject.points).not_to be_nil
      end
    end

    context 'when given file input' do
      let(:board_size) { 360 }
      let(:points_inputs) { file_inputs }

      it 'builds a board on initialize' do
        expect(subject.board).not_to be_nil
      end

      it 'builds an array of Point objects on initialize' do
        expect(subject.points).not_to be_nil
      end
    end
  end

  describe 'calibrate_points' do
    context 'when given sample inputs' do
      let(:points_inputs) { [[1, 1], [1, 6], [8, 3], [3, 4], [5, 5], [8, 9]].map(&:reverse) }
      let(:expected_result) {
        [
          "0000.111",
          "00223111",
          "02223112",
          ".2323311",
          "4.234331",
          "14.3333.",
          "44.33355",
          "44.33555",
          "44.55555"
        ]
      }

      context 'when board is size 10' do
        let(:board_size) { 10 }

        it 'returns the board' do
          expect(subject.calibrate_points).to eq expected_result
        end
      end

      context 'when board is size 360' do
        let(:board_size) { 360 }

        it 'returns the board' do
          expect(subject.calibrate_points).to eq expected_result
        end
      end
    end

    context 'when given file input' do
      let(:board_size) { 360 }
      let(:points_inputs) { file_inputs }
      let(:expected_result) {
        [
          "0000.111",
          "00223111",
          "02223112",
          ".2323311",
          "4.234331",
          "14.3333.",
          "44.33355",
          "44.33555",
          "44.55555"
        ]
      }

      it 'returns the board' do
        expect(subject.calibrate_points).to eq expected_result
      end
    end
  end

  describe 'count_largest_area' do
    context 'when given the demo input' do
      let(:board_size) { 10 }
      let(:points_inputs) { [[1, 1], [1, 6], [8, 3], [3, 4], [5, 5], [8, 9]].map(&:reverse) }

      it 'returns the largest area count' do
        expect(subject.count_largest_area).to eq 17
      end
    end

    context 'when given the problem input' do
      let(:board_size) { 360 }
      let(:points_inputs) { file_inputs }

      it 'returns the largest area count' do
        expect(subject.count_largest_area).to eq 17
      end
    end
  end
end
