# frozen_string_literal: true

RSpec.describe SalesTax::ItemParser do
  describe '.parse' do
    it 'parses a single item line' do
      item = described_class.parse('1 book at 12.49')
      expect(item.quantity).to eq(1)
      expect(item.name).to eq('book')
      expect(item.unit_price).to eq(12.49)
    end

    it 'parses item with multiple words in name' do
      item = described_class.parse('1 imported bottle of perfume at 27.99')
      expect(item.quantity).to eq(1)
      expect(item.name).to eq('imported bottle of perfume')
      expect(item.unit_price).to eq(27.99)
    end

    it 'parses item with quantity greater than 1' do
      item = described_class.parse('3 imported boxes of chocolates at 11.25')
      expect(item.quantity).to eq(3)
      expect(item.name).to eq('imported boxes of chocolates')
      expect(item.unit_price).to eq(11.25)
    end

    it 'handles whitespace' do
      item = described_class.parse('  2 book at 12.49  ')
      expect(item.quantity).to eq(2)
      expect(item.name).to eq('book')
    end

    it 'raises error for invalid format' do
      expect { described_class.parse('invalid input') }
        .to raise_error(ArgumentError, /Invalid input format/)
    end

    it 'raises error for missing price' do
      expect { described_class.parse('1 book') }
        .to raise_error(ArgumentError, /Invalid input format/)
    end
  end

  describe '.parse_basket' do
    it 'parses multiple lines into a basket' do
      input = <<~INPUT
        2 book at 12.49
        1 music CD at 14.99
        1 chocolate bar at 0.85
      INPUT

      basket = described_class.parse_basket(input)
      expect(basket.size).to eq(3)
    end

    it 'skips empty lines' do
      input = <<~INPUT
        1 book at 12.49

        1 music CD at 14.99
      INPUT

      basket = described_class.parse_basket(input)
      expect(basket.size).to eq(2)
    end

    it 'returns empty basket for empty input' do
      basket = described_class.parse_basket('')
      expect(basket).to be_empty
    end
  end
end
