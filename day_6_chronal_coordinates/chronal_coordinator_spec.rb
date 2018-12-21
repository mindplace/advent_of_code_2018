require 'rspec'
require 'pry'
require_relative 'chronal_coordinator'


RSpec.describe ChronalCoordinator do
  subject { described_class.new(board_size: board_size, points_inputs: points_inputs) }

  describe '#initialize' do
    let(:board_size) { 10 }
    let(:points_inputs) { [[1, 1], [4, 6], [8, 9], [3, 4]] }

    it 'builds a board on initialize' do
      expect(subject.board).not_to be_nil
    end

    it 'builds an array of Point objects on initialize' do
      expect(subject.points).not_to be_nil
    end
  end

  describe 'calibrate_points' do
    let(:board_size) { 10 }
    let(:points_inputs) { [[1, 1], [4, 6], [8, 9], [3, 4]] }

    it 'does somethimng' do
      expect(subject.calibrate_points).to be_nil
    end
  end
end
