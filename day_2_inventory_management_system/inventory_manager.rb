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
  end

  def levenshtein_distance(first:, second:)
    unless [first, second].all? { |word| word.is_a?(String) || word.is_a?(Hash) }
      raise ArgumentError.new('Must be a string or a hash of letters to letter counts')
    end
    
    first = count_letters(word: first) if first.is_a?(String)
    second = count_letters(word: second) if second.is_a?(String)

    # function levenshtein(a, b) {
    #   var t = [], u, i, j, m = a.length, n = b.length;
    #   if (!m) { return n; }
    #   if (!n) { return m; }
    #   for (j = 0; j <= n; j++) { t[j] = j; }
    #   for (i = 1; i <= m; i++) {
    #     for (u = [i], j = 1; j <= n; j++) {
    #       u[j] = a[i - 1] === b[j - 1] ? t[j - 1] : Math.min(t[j - 1], t[j], u[j - 1]) + 1;
    #     } t = u;
    #   } return u[n];
    # }

    binding.pry
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
      letters_groups = set.map { |word| lettercounted_words[word][:letters] }
      differences = []
      { set: set, distance: levenshtein_distance(first: letters_groups.first, second: letters_groups.last) }
    end
  end
end
