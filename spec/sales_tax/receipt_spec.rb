# frozen_string_literal: true

RSpec.describe SalesTax::Receipt do
  describe '#generate' do
    it 'generates formatted receipt for basket 1' do
      basket = SalesTax::Basket.new
      basket.add(SalesTax::Item.new(quantity: 2, name: 'book', unit_price: 12.49))
      basket.add(SalesTax::Item.new(quantity: 1, name: 'music CD', unit_price: 14.99))
      basket.add(SalesTax::Item.new(quantity: 1, name: 'chocolate bar', unit_price: 0.85))

      receipt = described_class.new(basket)
      output = receipt.generate

      expect(output).to include('2 book: 24.98')
      expect(output).to include('1 music CD: 16.49')
      expect(output).to include('1 chocolate bar: 0.85')
      expect(output).to include('Sales Taxes: 1.50')
      expect(output).to include('Total: 42.32')
    end

    it 'generates formatted receipt for basket 2' do
      basket = SalesTax::Basket.new
      basket.add(SalesTax::Item.new(quantity: 1, name: 'imported box of chocolates', unit_price: 10.00))
      basket.add(SalesTax::Item.new(quantity: 1, name: 'imported bottle of perfume', unit_price: 47.50))

      receipt = described_class.new(basket)
      output = receipt.generate

      expect(output).to include('1 imported box of chocolates: 10.50')
      expect(output).to include('1 imported bottle of perfume: 54.65')
      expect(output).to include('Sales Taxes: 7.65')
      expect(output).to include('Total: 65.15')
    end

    it 'generates formatted receipt for basket 3' do
      basket = SalesTax::Basket.new
      basket.add(SalesTax::Item.new(quantity: 1, name: 'imported bottle of perfume', unit_price: 27.99))
      basket.add(SalesTax::Item.new(quantity: 1, name: 'bottle of perfume', unit_price: 18.99))
      basket.add(SalesTax::Item.new(quantity: 1, name: 'packet of headache pills', unit_price: 9.75))
      basket.add(SalesTax::Item.new(quantity: 3, name: 'imported boxes of chocolates', unit_price: 11.25))

      receipt = described_class.new(basket)
      output = receipt.generate

      expect(output).to include('1 imported bottle of perfume: 32.19')
      expect(output).to include('1 bottle of perfume: 20.89')
      expect(output).to include('1 packet of headache pills: 9.75')
      expect(output).to include('3 imported boxes of chocolates: 35.55')
      expect(output).to include('Sales Taxes: 7.90')
      expect(output).to include('Total: 98.38')
    end
  end

  describe '#print' do
    it 'outputs receipt to stdout' do
      basket = SalesTax::Basket.new
      basket.add(SalesTax::Item.new(quantity: 1, name: 'book', unit_price: 12.49))

      receipt = described_class.new(basket)

      expect { receipt.print }.to output(/1 book: 12.49/).to_stdout
    end
  end
end
