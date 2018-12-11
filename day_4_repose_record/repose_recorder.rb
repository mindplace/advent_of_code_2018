class ReposeRecorder
  attr_reader :sleep_records
  attr_accessor :guards, :guard_times, :total_sleep_report

  def initialize(sleep_records:)
    @sleep_records = sleep_records
    @guard_times = {}
    @guards = []
    @total_sleep_report = {}
    sort_sleep_records_into_guard_times
    instantiate_guards
  end

  def longest_sleep_time_x_guard_id
    longest_sleep_times = guards.map { |guard| [ guard.id,  guard.total_minutes_asleep ] }.to_h
    highest = longest_sleep_times.sort_by { |set| set[1] }.last
    guard_id = highest[0]
    guards.find { |guard| guard.id == guard_id }.highest_overlapping_sleep_minute * guard_id.to_i
  end

  def highest_sleep_frequency_count_x_guard_id
    frequency_counts = guards.map do |guard|
      [
        guard.id,
        {
          highest_overlapping_minute: guard.highest_overlapping_sleep_minute,
          most_asleep_minute_count: guard.most_asleep_minute_count
        }
      ]
    end.to_h
    sleeper = frequency_counts.sort_by { |id, count| count[:most_asleep_minute_count] }.last
    sleeper[1][:highest_overlapping_minute] * sleeper[0].to_i
  end

  private

  def sort_sleep_records_into_guard_times
    @guard_times = {}
    guard_id = ''

    sleep_records.sort.each do |record|
      if record.include?('Guard #')
        guard_id = record.scan(/\sGuard\s\#(\d*)\s/).flatten.first
        @guard_times[guard_id] = [] if @guard_times[guard_id].nil?
      end
      @guard_times[guard_id] << record
    end
  end

  def instantiate_guards
    guard_times.each { |guard, times_set| @guards << Guard.new(sleep_records: times_set) }
  end
end
