# frozen_string_literal: true

RSpec.describe SalesTax::TaxCalculator do
  describe '.calculate' do
    context 'with exempt non-imported items' do
      it 'returns 0 tax for books' do
        expect(described_class.calculate(name: 'book', price: 12.49)).to eq(0.00)
      end

      it 'returns 0 tax for food' do
        expect(described_class.calculate(name: 'chocolate bar', price: 0.85)).to eq(0.00)
      end

      it 'returns 0 tax for medical products' do
        expect(described_class.calculate(name: 'packet of headache pills', price: 9.75)).to eq(0.00)
      end
    end

    context 'with non-exempt non-imported items' do
      it 'applies 10% basic sales tax' do
        # 14.99 * 0.10 = 1.499 -> rounded to 1.50
        expect(described_class.calculate(name: 'music CD', price: 14.99)).to eq(1.50)
      end

      it 'applies 10% to perfume' do
        # 18.99 * 0.10 = 1.899 -> rounded to 1.90
        expect(described_class.calculate(name: 'bottle of perfume', price: 18.99)).to eq(1.90)
      end
    end

    context 'with exempt imported items' do
      it 'applies only 5% import duty' do
        # 10.00 * 0.05 = 0.50
        expect(described_class.calculate(name: 'imported box of chocolates', price: 10.00)).to eq(0.50)
      end

      it 'applies 5% to imported chocolates at different price' do
        # 11.25 * 0.05 = 0.5625 -> rounded to 0.60
        expect(described_class.calculate(name: 'imported boxes of chocolates', price: 11.25)).to eq(0.60)
      end
    end

    context 'with non-exempt imported items' do
      it 'applies both 10% basic tax and 5% import duty' do
        # 47.50 * 0.15 = 7.125 -> rounded to 7.15
        expect(described_class.calculate(name: 'imported bottle of perfume', price: 47.50)).to eq(7.15)
      end

      it 'handles another imported perfume price' do
        # 27.99 * 0.15 = 4.1985 -> rounded to 4.20
        expect(described_class.calculate(name: 'imported bottle of perfume', price: 27.99)).to eq(4.20)
      end
    end
  end
end
