require 'rspec'
require 'pry'
require_relative 'inventory_manager.rb'

RSpec.describe InventoryManager do
  subject { InventoryManager.new(ids: ids) }

  describe '#generate_checksum' do
    context "when ids are ['abcdef', 'bababc', 'abbcde', 'abcccd', 'aabcdd', 'abcdee', 'ababab']" do
      let(:ids) { ['abcdef', 'bababc', 'abbcde', 'abcccd', 'aabcdd', 'abcdee', 'ababab'] }

      it 'returns 12' do
        expect(subject.generate_checksum).to eq 12
      end
    end

    context 'when ids are inputs from file' do
      let(:ids) { File.readlines('ids_inputs.txt').map { |line| line.chomp } }

      it 'returns 7872' do
        expect(subject.generate_checksum).to eq 7872
      end
    end
  end
end
