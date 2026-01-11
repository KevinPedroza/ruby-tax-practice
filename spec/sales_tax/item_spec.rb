# frozen_string_literal: true

RSpec.describe SalesTax::Item do
  describe 'initialization' do
    subject(:item) { described_class.new(quantity: 2, name: 'book', unit_price: 12.49) }

    it 'sets the quantity' do
      expect(item.quantity).to eq(2)
    end

    it 'sets the name' do
      expect(item.name).to eq('book')
    end

    it 'sets the unit price' do
      expect(item.unit_price).to eq(12.49)
    end

    it 'is frozen (immutable)' do
      expect(item).to be_frozen
    end
  end

  describe '#unit_tax' do
    it 'returns 0 for exempt items' do
      item = described_class.new(quantity: 1, name: 'book', unit_price: 12.49)
      expect(item.unit_tax).to eq(0.00)
    end

    it 'calculates tax for non-exempt items' do
      item = described_class.new(quantity: 1, name: 'music CD', unit_price: 14.99)
      expect(item.unit_tax).to eq(1.50)
    end
  end

  describe '#total_tax' do
    it 'multiplies unit tax by quantity' do
      item = described_class.new(quantity: 3, name: 'imported boxes of chocolates', unit_price: 11.25)
      # 11.25 * 0.05 = 0.5625 -> 0.60 per unit, 0.60 * 3 = 1.80
      expect(item.total_tax).to eq(1.80)
    end

    it 'returns 0 for exempt items regardless of quantity' do
      item = described_class.new(quantity: 5, name: 'book', unit_price: 12.49)
      expect(item.total_tax).to eq(0.00)
    end
  end

  describe '#unit_price_with_tax' do
    it 'adds tax to unit price' do
      item = described_class.new(quantity: 1, name: 'music CD', unit_price: 14.99)
      expect(item.unit_price_with_tax).to eq(16.49)
    end

    it 'returns unit price for exempt items' do
      item = described_class.new(quantity: 1, name: 'chocolate bar', unit_price: 0.85)
      expect(item.unit_price_with_tax).to eq(0.85)
    end
  end

  describe '#total_price_with_tax' do
    it 'calculates total for multiple items' do
      item = described_class.new(quantity: 2, name: 'book', unit_price: 12.49)
      expect(item.total_price_with_tax).to eq(24.98)
    end

    it 'includes tax in total' do
      item = described_class.new(quantity: 3, name: 'imported boxes of chocolates', unit_price: 11.25)
      # (11.25 + 0.60) * 3 = 35.55
      expect(item.total_price_with_tax).to eq(35.55)
    end
  end

  describe '#to_receipt_line' do
    it 'formats item for receipt' do
      item = described_class.new(quantity: 2, name: 'book', unit_price: 12.49)
      expect(item.to_receipt_line).to eq('2 book: 24.98')
    end

    it 'includes tax in displayed price' do
      item = described_class.new(quantity: 1, name: 'music CD', unit_price: 14.99)
      expect(item.to_receipt_line).to eq('1 music CD: 16.49')
    end
  end
end
