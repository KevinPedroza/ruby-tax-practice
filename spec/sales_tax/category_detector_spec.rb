# frozen_string_literal: true

RSpec.describe SalesTax::CategoryDetector do
  describe '.exempt?' do
    context 'with food products' do
      it 'returns true for chocolate items' do
        expect(described_class.exempt?('chocolate bar')).to be true
        expect(described_class.exempt?('box of chocolates')).to be true
        expect(described_class.exempt?('imported box of chocolates')).to be true
      end
    end

    context 'with book products' do
      it 'returns true for books' do
        expect(described_class.exempt?('book')).to be true
        expect(described_class.exempt?('programming book')).to be true
      end
    end

    context 'with medical products' do
      it 'returns true for medical items' do
        expect(described_class.exempt?('packet of headache pills')).to be true
        expect(described_class.exempt?('vitamin supplement')).to be true
      end
    end

    context 'with non-exempt products' do
      it 'returns false for music CDs' do
        expect(described_class.exempt?('music CD')).to be false
      end

      it 'returns false for perfume' do
        expect(described_class.exempt?('bottle of perfume')).to be false
        expect(described_class.exempt?('imported bottle of perfume')).to be false
      end
    end

    it 'is case insensitive' do
      expect(described_class.exempt?('CHOCOLATE BAR')).to be true
      expect(described_class.exempt?('Book')).to be true
    end
  end

  describe '.imported?' do
    it 'returns true for imported items' do
      expect(described_class.imported?('imported box of chocolates')).to be true
      expect(described_class.imported?('imported bottle of perfume')).to be true
    end

    it 'returns false for non-imported items' do
      expect(described_class.imported?('book')).to be false
      expect(described_class.imported?('music CD')).to be false
      expect(described_class.imported?('bottle of perfume')).to be false
    end

    it 'is case insensitive' do
      expect(described_class.imported?('IMPORTED chocolate')).to be true
    end
  end
end
