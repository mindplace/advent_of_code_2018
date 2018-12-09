require 'rspec'
require 'pry'
require_relative 'inventory_manager.rb'

RSpec.describe InventoryManager do
  subject { InventoryManager.new(words: words) }

  describe '#generate_checksum' do
    context "when words are ['abcdef', 'bababc', 'abbcde', 'abcccd', 'aabcdd', 'abcdee', 'ababab']" do
      let(:words) { ['abcdef', 'bababc', 'abbcde', 'abcccd', 'aabcdd', 'abcdee', 'ababab'] }

      it 'returns 12' do
        expect(subject.generate_checksum).to eq 12
      end
    end

    context 'when words are inputs from file' do
      let(:words) { File.readlines('ids_inputs.txt').map { |line| line.chomp } }

      it 'returns 7872' do
        expect(subject.generate_checksum).to eq 7872
      end
    end
  end

  describe '#find_similar_words' do
    before { subject.generate_checksum }

    context "when words are ['abcde', 'fghij', 'klmno', 'pqrst', 'fguij', 'axcye', 'wvxyz']" do
      let(:words) { ['abcde', 'fghij', 'klmno', 'pqrst', 'fguij', 'axcye', 'wvxyz'] }

      it "returns 'fgij'" do
        expect(subject.find_similar_words).to eq 'fgij'
      end
    end
  end

  describe '#levenshtein_distance' do
    context 'when given bad inputs' do
      let(:words) { [ 0, 0] }

      it 'raises an ArgumentError' do
        expect { subject.levenshtein_distance(first: 0, second: 0) }.to raise_error(ArgumentError)
      end
    end

    context "when words are 'abcde' and 'fghij'" do
      let(:words) { [ 'abcde', 'fghij' ] }
      let(:first) { words.first }
      let(:second) { words.last }

      it 'returns 5' do
        expect(subject.levenshtein_distance(first: first, second: second)).to eq 5
      end
    end
  end
end
