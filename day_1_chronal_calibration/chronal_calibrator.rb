class ChronalCalibrator
  attr_reader :values, :frequency_changes

  def initialize(values:)
    @values = values
    @frequency_changes = []
  end

  def calculate_resulting_frequency
    values.reduce(&:+)
  end

  def calculate_frequency_changes
    until frequency_changes.uniq.length != frequency_changes.length
      current_total = 0
      values.each_with_index do |value, i|
        @frequency_changes.push(current_total += 1)
      end
    end
    frequency_changes
  end

  def nth_recurring_frequency(n)
    frequency_occurance_graph = Hash.new(0)
    nth_recurring = nil

    frequency_changes.each do |value|
      frequency_occurance_graph[value] += 1
      if frequency_occurance_graph[value] == n
        nth_recurring = value
        break
      end
    end

    nth_recurring
  end
end
