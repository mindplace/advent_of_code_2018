class InventoryManager
  attr_reader :words
  attr_accessor :lettercounted_words, :letter_counts, :words_difference_groupings

  def initialize(words:)
    @words = words
    @lettercounted_words = {}
  end

  def generate_checksum
    @lettercounted_words = generate_lettercounted_words(words: words)
    checksum_counts = aggregate_letter_counts(words: lettercounted_words)
    checksum(words: checksum_counts)
  end

  def find_similar_words
    @words_difference_groupings = generate_words_differences
    most_similar_set = words_difference_groupings.min_by { |set| set[:distance] }
    keep_same_letters(words: most_similar_set[:set])
  end

  def levenshtein_distance(first:, second:)
    difference_counter = 0

    first.chars.each_with_index do |letter, i|
      difference_counter += 1 if second[i] != letter
    end

    difference_counter
  end

  private

  def generate_lettercounted_words(words:)
    words.map do |word|
      counted = count_letters(word: word)
      [
        word,
        {
          letters: counted,
          sorted: word.split('').sort.join(''),
          2 => counted.values.include?(2),
          3 => counted.values.include?(3)
        }
      ]
    end.to_h
  end

  def count_letters(word:)
    counter = word.split('').group_by { |x| x }.values
    counter.map { |letter_group| [ letter_group.first, letter_group.length ] }.to_h
  end

  def aggregate_letter_counts(words:)
    two_counter = 0
    three_counter = 0

    words.each do |key, word|
      two_counter += 1 if word[2]
      three_counter += 1 if word[3]
    end

    [two_counter, three_counter]
  end

  def checksum(words:)
    words.reduce(&:*)
  end

  def generate_words_differences
    words.combination(2).to_a.map do |set|
      { set: set, distance: levenshtein_distance(first: set.first, second: set.last) }
    end
  end

  def keep_same_letters(words:)
    words.first.chars.select { |char| words.last[char] }.join('')
  end
end
