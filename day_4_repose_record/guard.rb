require 'rails'

class Guard
  attr_reader :sleep_records, :id
  attr_accessor :sleep_report, :minute_sleep_counts, :most_asleep_minute_count

  def initialize(sleep_records:)
    @sleep_records = sleep_records
    @sleep_report = {}
    @id = fetch_id
    build_sleep_report
  end

  def total_minutes_asleep
    @total_minutes_asleep ||= sleep_report.map { |date, data| data[:times_array].count('#') }.reduce(&:+)
  end

  def highest_overlapping_sleep_minute
    sleep_graph = Hash.new(0)
    data, *data_arrays = sleep_report.map { |date, data| data[:times_array] }
    @minute_sleep_counts = data.zip(*data_arrays).map.with_index { |el, i| [i, el.count('#')] }.to_h
    highest = minute_sleep_counts.sort_by { |key, value| value }.last
    @most_asleep_minute_count = highest[1]
    highest[0]
  end

  private

  def build_sleep_report
    parse_sleep_information
    fill_in_sleep_minutes
    sleep_report
  end

  def parse_sleep_information
    sleep_records.sort.each do |record|
      record_date_string = record.scan(/\[(.*)\s/).flatten.first
      date = adjusted_record_date(date_string: record_date_string)
      date_string = date.strftime('%Y-%m-%d')

      if record.include?('begins shift')
        @sleep_report[date_string] = { times_array: Array.new(60) }
      elsif record.include?('falls asleep')
        @sleep_report[date_string][:times_array][date.min] = '#'
      elsif record.include?('wakes up')
        @sleep_report[date_string][:times_array][date.min - 1] = '.'
      end
    end
  end

  def adjusted_record_date(date_string:)
    date = Time.strptime(date_string, '%Y-%m-%d %H:%M')
    date = date + 1.day if (date + 60.minutes).day != date.day
    date
  end

  def fill_in_sleep_minutes
    sleep_report.each do |date, data|
      sleep_array = data[:times_array]
      sleep_start_times = sleep_array.each_index.select { |i| sleep_array[i] == '#' }
      sleep_end_times = sleep_array.each_index.select { |i| sleep_array[i] == '.' }
      asleep_mins = sleep_start_times.zip(sleep_end_times).map { |a, b| (a .. b).to_a }.flatten
      asleep_mins.each { |min| sleep_array[min] = '#' }
      @sleep_report[date][:report] = sleep_array.map { |el| el.nil? ? '.' : el }.join('')
    end
  end

  def fetch_id
    guard_record = sleep_records.find { |record| record.include?('Guard') }
    guard_record.scan(/\sGuard\s\#(\d*)\s/).flatten.first
  end
end
