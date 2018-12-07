require 'rspec'
require_relative 'chronal_calibrator.rb'

RSpec.describe ChronalCalibrator do
  let(:chronal_calibrator) { ChronalCalibrator.new(values: values) }

  describe '#calculate_resulting_frequency' do
    context 'part 1: basic calculation' do
      context 'when given [1, 1, 1]' do
        let(:values) { [1, 1, 1] }

        it 'produces 3' do
          expect(chronal_calibrator.calculate_resulting_frequency).to eq 3
        end
      end

      context 'when given [1, 1, -2]' do
        let(:values) { [1, 1, -2] }

        it 'produces 0' do
          expect(chronal_calibrator.calculate_resulting_frequency).to eq 0
        end
      end

      context 'when given [-1, -2, -3]' do
        let(:values) { [-1, -2, -3] }

        it 'produces -6' do
          expect(chronal_calibrator.calculate_resulting_frequency).to eq -6
        end
      end

      context 'when given the values in the text file' do
        let(:values) { File.readlines('input_values.txt').map { |line| line.chomp.to_i } }

        it 'produces 472' do
          expect(chronal_calibrator.calculate_resulting_frequency).to eq 472
        end
      end
    end

    context 'part 2: frequency change counter' do
      context 'when given [1, -2, 3, 1, ]'
    end
  end
end
