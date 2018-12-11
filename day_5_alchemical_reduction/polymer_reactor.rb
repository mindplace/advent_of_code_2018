class PolymerReactor
  attr_reader :polymer, :reacted_polymer

  def initialize(polymer:)
    @polymer = polymer
  end

  def self.select_best_removed_unit_type(polymer:)
    polymer_variations = polymer.downcase.chars.uniq.map do |char|
      polymer_missing_char = polymer.chars.select { |el| el.upcase != char.upcase }
      polymer_obj = self.new(polymer: polymer_missing_char)
      polymer_obj.react_polymer

      [
        char,
        {
          polymer: polymer_obj,
          reacted_polymer: polymer_obj.reacted_polymer,
          length: polymer_obj.length_counter
        }
      ]
    end.to_h

    polymer_variations.sort_by { |k, v| v[:length] }.first[1][:length]
  end

  def react_polymer
    @reacted_polymer = polymer.dup
    i = 0

    while true
      if should_react?(a: reacted_polymer[i], b: reacted_polymer[i + 1])
        @reacted_polymer = @reacted_polymer[0...i] + @reacted_polymer[(i + 2)..-1]
        i = (i - 1 < 0) ? 0 : i - 1
      elsif reacted_polymer[i + 1].nil?
        return reacted_polymer
      else
        i += 1
      end
    end

    reacted_polymer
  end

  def length_counter
    reacted_polymer.length
  end

  private

  def should_react?(a:, b:)
    (a != b) && (a&.upcase == b&.upcase)
  end
end
