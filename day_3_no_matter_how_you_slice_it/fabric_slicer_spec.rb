require 'rspec'
require 'pry'
require_relative 'fabric_slicer.rb'

RSpec.describe FabricSlicer do
  let(:cloth_size) { 1000 }
  subject { FabricSlicer.new(inputs: inputs, cloth_size: cloth_size) }

  describe '#translate_inputs_to_sub_rectangles' do
    context 'when given a single value' do
      let(:inputs) { ["#1 @ 3,2: 5x4"] }
      let(:expected_result) { [ { min_x: 3, min_y: 2, max_x: 7, max_y: 5, id: '1' } ] }
      let(:cloth_size) { 8 }

      it 'turns the value into rectangle description' do
        expect(subject.translate_inputs_to_sub_rectangles).to eq expected_result
      end
    end

    context 'when given multiple values' do
      let(:inputs) { ["#1 @ 1,3: 4x4", "#2 @ 3,1: 4x4", "#3 @ 5,5: 2x2"] }
      let(:expected_result) {
        [
          { min_x: 1, min_y: 3, max_x: 4, max_y: 6, id: '1' },
          { min_x: 3, min_y: 1, max_x: 6, max_y: 4, id: '2' },
          { min_x: 5, min_y: 5, max_x: 6, max_y: 6, id: '3' },
        ]
      }
      let(:cloth_size) { 8 }

      it 'turns them into rectangles' do
        expect(subject.translate_inputs_to_sub_rectangles).to eq expected_result
      end
    end
  end

  describe '#map_to_cloth' do
    context 'when given multiple inputs' do
      let(:inputs) { ["#1 @ 1,3: 4x4", "#2 @ 3,1: 4x4", "#3 @ 5,5: 2x2"] }
      let(:cloth_size) { 8 }
      let(:expected_result) {
        [
          "........",
          "...2222.",
          "...2222.",
          ".11oo22.",
          ".11oo22.",
          ".111133.",
          ".111133.",
          "........"
        ]
      }

      it 'returns the cloth marked up' do
        expect(subject.map_to_cloth).to eq expected_result
      end
    end
  end

  describe '#count_overlaps' do
    before { subject.map_to_cloth }

    context 'when given 2 squares' do
      let(:inputs) { ["#1 @ 3,2: 5x4", "#1 @ 4,3: 5x4"] }
      let(:cloth_size) { 10 }

      it 'returns 12' do
        expect(subject.count_overlaps).to eq 12
      end
    end

    context 'when given 3 squares' do
      let(:inputs) { ["#1 @ 1,3: 4x4", "#2 @ 3,1: 4x4", "#3 @ 5,5: 2x2"] }
      let(:cloth_size) { 8 }

      it 'returns 4' do
        expect(subject.count_overlaps).to eq 4
      end
    end

    context 'when given the file inputs' do
      let(:inputs) { File.readlines('fabric_inputs.txt').map { |line| line.chomp } }
      let(:cloth_size) { 1000 }

      it 'returns 111326' do
        expect(subject.count_overlaps).to eq 111326
      end
    end
  end

  describe '#find_non_overlap_id' do
    before { subject.map_to_cloth }

    context 'when given 2 squares which overlap' do
      let(:inputs) { ["#1 @ 3,2: 5x4", "#2 @ 4,3: 5x4"] }
      let(:cloth_size) { 10 }

      it 'returns false' do
        expect(subject.find_non_overlap_id).to eq false
      end
    end

    context 'when given 3 squares one of which does not overlap' do
      let(:inputs) { ["#1 @ 1,3: 4x4", "#2 @ 3,1: 4x4", "#3 @ 5,5: 2x2"] }
      let(:cloth_size) { 8 }

      it 'returns #3' do
        expect(subject.find_non_overlap_id).to eq '3'
      end
    end

    context 'when given the file inputs' do
      let(:inputs) { File.readlines('fabric_inputs.txt').map { |line| line.chomp } }
      let(:cloth_size) { 1000 }

      it 'returns #1019' do
        expect(subject.find_non_overlap_id).to eq '1019'
      end
    end
  end
end
