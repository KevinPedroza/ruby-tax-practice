# frozen_string_literal: true

RSpec.describe SalesTax::Basket do
  subject(:basket) { described_class.new }

  describe '#add' do
    it 'adds items to the basket' do
      item = SalesTax::Item.new(quantity: 1, name: 'book', unit_price: 12.49)
      basket.add(item)
      expect(basket.items).to include(item)
    end

    it 'returns self for method chaining' do
      item = SalesTax::Item.new(quantity: 1, name: 'book', unit_price: 12.49)
      expect(basket.add(item)).to eq(basket)
    end
  end

  describe '#items' do
    it 'returns a copy of items array' do
      item = SalesTax::Item.new(quantity: 1, name: 'book', unit_price: 12.49)
      basket.add(item)
      items = basket.items
      items.clear
      expect(basket.items).to include(item)
    end
  end

  describe '#total_taxes' do
    it 'returns 0 for empty basket' do
      expect(basket.total_taxes).to eq(0.00)
    end

    it 'sums taxes from all items' do
      basket.add(SalesTax::Item.new(quantity: 1, name: 'music CD', unit_price: 14.99))
      basket.add(SalesTax::Item.new(quantity: 1, name: 'book', unit_price: 12.49))
      # 1.50 + 0.00 = 1.50
      expect(basket.total_taxes).to eq(1.50)
    end
  end

  describe '#total' do
    it 'returns 0 for empty basket' do
      expect(basket.total).to eq(0.00)
    end

    it 'calculates total including taxes' do
      basket.add(SalesTax::Item.new(quantity: 2, name: 'book', unit_price: 12.49))
      basket.add(SalesTax::Item.new(quantity: 1, name: 'music CD', unit_price: 14.99))
      basket.add(SalesTax::Item.new(quantity: 1, name: 'chocolate bar', unit_price: 0.85))
      expect(basket.total).to eq(42.32)
    end
  end

  describe '#empty?' do
    it 'returns true for new basket' do
      expect(basket).to be_empty
    end

    it 'returns false when items are added' do
      basket.add(SalesTax::Item.new(quantity: 1, name: 'book', unit_price: 12.49))
      expect(basket).not_to be_empty
    end
  end

  describe '#size' do
    it 'returns 0 for empty basket' do
      expect(basket.size).to eq(0)
    end

    it 'returns count of line items' do
      basket.add(SalesTax::Item.new(quantity: 5, name: 'book', unit_price: 12.49))
      basket.add(SalesTax::Item.new(quantity: 1, name: 'music CD', unit_price: 14.99))
      expect(basket.size).to eq(2)
    end
  end

  describe 'thread safety' do
    it 'safely handles concurrent additions' do
      threads = 10.times.map do |i|
        Thread.new do
          item = SalesTax::Item.new(quantity: 1, name: "item #{i}", unit_price: 1.00)
          basket.add(item)
        end
      end
      threads.each(&:join)
      expect(basket.size).to eq(10)
    end
  end
end
