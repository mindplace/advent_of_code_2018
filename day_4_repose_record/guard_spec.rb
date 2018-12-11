require 'rspec'
require 'pry'
require_relative 'guard.rb'

RSpec.describe Guard do
  subject { Guard.new(sleep_records: sleep_records) }
  let(:sleep_records) {
    [
      "[1518-11-01 00:00] Guard #10 begins shift",
      "[1518-11-01 00:30] falls asleep",
      "[1518-11-03 00:24] falls asleep",
      "[1518-11-01 00:55] wakes up",
      "[1518-11-01 00:05] falls asleep",
      "[1518-11-03 00:29] wakes up",
      "[1518-11-01 00:25] wakes up",
      "[1518-11-03 00:05] Guard #10 begins shift"
    ]
  }

  describe '#build_sleep_reports' do
    it 'builds a sleep report' do
      expect(subject.build_sleep_reports['1518-11-01'][:report]).to eq '.....####################.....#########################.....'
    end
  end

  describe '#total_minutes_asleep' do
    it 'returns 50' do
      expect(subject.total_minutes_asleep).to eq 50
    end
  end

  describe '#highest_overlapping_sleep_minute' do
    it 'returns 24' do
      expect(subject.highest_overlapping_sleep_minute).to eq 24
    end
  end
end
