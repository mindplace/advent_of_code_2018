class ChronalCalibrator
  attr_reader :values, :frequency_changes, :total_resulting_frequency, :nth_recurring, :frequency_occurance_graph

  def initialize(values:)
    @values = values
    @frequency_changes = [0]
    @total_resulting_frequency = 0
    @nth_recurring = nil
  end

  def calculate_resulting_frequency
    values.reduce(&:+)
  end

  def nth_recurring_frequency(n:)
    while nth_recurring.nil?
      generate_frequency_changes
      generate_frequencies_hash(n)
    end
    nth_recurring
  end

  private

  def generate_frequency_changes
    current_total = total_resulting_frequency
    values.each { |value| @frequency_changes.push(current_total += value) }
    @total_resulting_frequency = current_total
  end

  def generate_frequencies_hash(n)
    frequency_graph = Hash.new(0)
    frequency_changes.each do |value|
      frequency_graph[value] += 1
      if frequency_graph[value] == n
        @nth_recurring = value
        @frequency_occurance_graph = frequency_graph
        return value
      end
    end
  end
end
