require 'rspec'
require 'pry'
require_relative 'chronal_calibrator.rb'

RSpec.describe ChronalCalibrator do
  let(:subject) { ChronalCalibrator.new(values: values) }
  let(:file_values) { File.readlines('input_values.txt').map { |line| line.chomp.to_i } }

  describe '#calculate_resulting_frequency' do
    context 'when given [1, 1, 1]' do
      let(:values) { [1, 1, 1] }

      it 'produces 3' do
        expect(subject.calculate_resulting_frequency).to eq 3
      end
    end

    context 'when given [1, 1, -2]' do
      let(:values) { [1, 1, -2] }

      it 'produces 0' do
        expect(subject.calculate_resulting_frequency).to eq 0
      end
    end

    context 'when given [-1, -2, -3]' do
      let(:values) { [-1, -2, -3] }

      it 'produces -6' do
        expect(subject.calculate_resulting_frequency).to eq -6
      end
    end

    context 'when given the values in the text file' do
      let(:values) { file_values }

      it 'produces 472' do
        expect(subject.calculate_resulting_frequency).to eq 472
      end
    end
  end

  describe '#nth_recurring_frequency' do
    context 'when given [1, -1]' do
      let(:values) { [1, -1] }

      it 'returns 1 as the first frequency reached twice' do
        expect(subject.nth_recurring_frequency(n: 2)).to eq 0
      end
    end

    context 'when given [3, 3, 4, -2, -4]' do
      let(:values) { [3, 3, 4, -2, -4] }

      it 'returns 10 as the first frequency reached twice' do
        expect(subject.nth_recurring_frequency(n: 2)).to eq 10
      end
    end

    context 'when given [1, -2, 3, 1]' do
      let(:values) { [1, -2, 3, 1] }

      it 'returns 2 as the first frequency reached twice' do
        expect(subject.nth_recurring_frequency(n: 2)).to eq 2
      end
    end

    context 'when given [-6, 3, 8, 5, -6]' do
      let(:values) { [-6, 3, 8, 5, -6] }

      it 'returns 5 as the first frequency reached twice' do
        expect(subject.nth_recurring_frequency(n: 2)).to eq 5
      end
    end

    context 'when given [7, 7, -2, -7, -4]' do
      let(:values) { [7, 7, -2, -7, -4] }

      it 'returns 14 as the first frequency reached twice' do
        expect(subject.nth_recurring_frequency(n: 2)).to eq 14
      end
    end

    context 'when given the file values' do
      let(:values) { file_values }

      it 'returns 66932 as the first frequency reached twice' do
        expect(subject.nth_recurring_frequency(n: 2)).to eq 66932
      end
    end
  end
end
