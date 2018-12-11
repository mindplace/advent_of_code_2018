require 'rspec'
require 'pry'
require_relative 'repose_recorder.rb'
require_relative 'guard.rb'

RSpec.describe ReposeRecorder do
  subject { ReposeRecorder.new(sleep_records: sleep_records) }
  let(:sample_records) {
    [
      '[1518-11-01 00:00] Guard #10 begins shift',
      '[1518-11-01 00:05] falls asleep',
      '[1518-11-01 00:25] wakes up',
      '[1518-11-01 00:30] falls asleep',
      '[1518-11-01 00:55] wakes up',
      '[1518-11-01 23:58] Guard #99 begins shift',
      '[1518-11-02 00:40] falls asleep',
      '[1518-11-02 00:50] wakes up',
      '[1518-11-03 00:05] Guard #10 begins shift',
      '[1518-11-03 00:24] falls asleep',
      '[1518-11-03 00:29] wakes up',
      '[1518-11-04 00:02] Guard #99 begins shift',
      '[1518-11-04 00:36] falls asleep',
      '[1518-11-04 00:46] wakes up',
      '[1518-11-05 00:03] Guard #99 begins shift',
      '[1518-11-05 00:45] falls asleep',
      '[1518-11-05 00:55] wakes up'
    ]
  }

  describe '#instantiate' do
    context 'when given records for two guards' do
      let(:sleep_records) { sample_records }

      it 'instantiates guards with times' do
        expect(subject.guards.length).to eq 2
      end

      it 'preserves all the records' do
        expect(subject.guards.map(&:sleep_records).flatten.sort).to eq sleep_records.sort
      end
    end
  end

  describe '#longest_sleep_time_x_guard_id' do
    context 'when given sample records' do
      let(:sleep_records) { sample_records }

      it 'returns the guard ID times highest overlapping sleep minute' do
        expect(subject.longest_sleep_time_x_guard_id).to eq 240
      end
    end

    context 'when given full text input' do
      let(:sleep_records) { File.readlines('repose_inputs.txt').map(&:chomp) }

      it 'returns the guard ID times highest overlapping sleep minute' do
        expect(subject.longest_sleep_time_x_guard_id).to eq 99911
      end
    end
  end

  describe '#highest_sleep_frequency_count_x_guard_id' do
    context 'when given sample records' do
      let(:sleep_records) { sample_records }

      it 'returns the guard ID times highest sleep frequency count' do
        expect(subject.highest_sleep_frequency_count_x_guard_id).to eq 4455
      end
    end

    context 'when given full text input' do
      let(:sleep_records) { File.readlines('repose_inputs.txt').map(&:chomp) }

      it 'returns the guard ID times highest sleep frequency count' do
        expect(subject.highest_sleep_frequency_count_x_guard_id).to eq 65854
      end
    end
  end
end
