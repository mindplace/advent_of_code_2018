require 'rspec'
require 'pry'
require_relative 'inventory_manager.rb'

RSpec.describe InventoryManager do
  subject { InventoryManager.new(words: words) }
  let(:file_words) { File.readlines('ids_inputs.txt').map { |line| line.chomp } }

  describe '#generate_checksum' do
    context "when words are ['abcdef', 'bababc', 'abbcde', 'abcccd', 'aabcdd', 'abcdee', 'ababab']" do
      let(:words) { ['abcdef', 'bababc', 'abbcde', 'abcccd', 'aabcdd', 'abcdee', 'ababab'] }

      it 'returns 12' do
        expect(subject.generate_checksum).to eq 12
      end
    end

    context 'when words are inputs from file' do
      let(:words) { file_words }

      it 'returns 7872' do
        expect(subject.generate_checksum).to eq 7872
      end
    end
  end

  describe '#levenshtein_distance' do
    let(:first) { words.first }
    let(:second) { words.last }

    context "when words are 'abcde' and 'fghij'" do
      let(:words) { [ 'abcde', 'fghij' ] }

      it 'returns 5' do
        expect(subject.levenshtein_distance(first: first, second: second)).to eq 5
      end
    end

    context "when words are 'mjxmoewpwkyaihvrndgfkubszc' and 'djxmoewpkkyaihvrnmgflubszc'" do
      let(:words) { ["mjxmoewpwkyaihvrndgfkubszc", "djxmoewpkkyaihvrnmgflubszc"] }

      it 'returns 4' do
        expect(subject.levenshtein_distance(first: first, second: second)).to eq 4
      end
    end
  end

  describe '#find_similar_words' do
    context "when words are ['abcde', 'fghij', 'klmno', 'pqrst', 'fguij', 'axcye', 'wvxyz']" do
      let(:words) { ['abcde', 'fghij', 'klmno', 'pqrst', 'fguij', 'axcye', 'wvxyz'] }

      it "returns 'fgij'" do
        expect(subject.find_similar_words).to eq 'fgij'
      end
    end

    context "when words are from the text file" do
      let(:words) { file_words }

      it 'returns something' do
        expect(subject.find_similar_words).to eq 'tjxmoewpdkyaihvrndfluwbzc'
      end
    end
  end
end
