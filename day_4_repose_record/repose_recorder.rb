class ReposeRecorder
  attr_reader :sleep_records
  attr_accessor :guards, :guard_times

  def initialize(sleep_records:)
    @sleep_records = sleep_records
    @guard_times = {}
    @guards = []
  end

  def instantiate_guards
    sort_sleep_records_into_guard_times if guard_times == {}
    guard_times.each { |guard, times_set| @guards << Guard.new(sleep_records: times_set) }
  end

  def find_overlapping_sleep_times
    instantiate_guards if guards == []
    longest_sleep_times = guards.map { |guard| [ guard.id,  guard.total_minutes_asleep ] }.to_h
    highest = longest_sleep_times.sort_by { |set| set[1] }.last
    guard_id = highest[0]
    guards.find { |guard| guard.id == guard_id }.highest_overlapping_sleep_minute * guard_id.to_i
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
end
