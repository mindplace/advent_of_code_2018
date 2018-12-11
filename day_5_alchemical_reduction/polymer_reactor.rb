class PolymerReactor
  attr_reader :polymer, :reacted_polymer

  def initialize(polymer:)
    @polymer = polymer
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
