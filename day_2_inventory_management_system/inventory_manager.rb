class InventoryManager
  attr_reader :ids
  attr_accessor :lettercounted_values

  def initialize(ids:)
    @ids = ids
    @lettercounted_values = []
  end

  def generate_checksum
    lettercounted_values = generate_lettercounted_values(values: ids)
    letter_counts = aggregate_letter_counts(values: lettercounted_values)
    checksum(values: letter_counts)
  end

  private

  def generate_lettercounted_values(values:)
    values.map do |value|
      count_letters(value: value).merge({ id: value })
    end
  end

  def count_letters(value:)
    counter = value.split('').group_by { |x| x }.values.map(&:length)
    { 2 => counter.include?(2), 3 => counter.include?(3) }
  end

  def aggregate_letter_counts(values:)
    two_counter = 0
    three_counter = 0

    values.each do |value|
      two_counter += 1 if value[2]
      three_counter += 1 if value[3]
    end

    [two_counter, three_counter]
  end

  def checksum(values:)
    values.reduce(&:*)
  end
end
