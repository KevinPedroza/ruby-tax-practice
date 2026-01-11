# frozen_string_literal: true

RSpec.describe SalesTax::Rounding do
  describe '.round_up' do
    it 'rounds 0.00 to 0.00' do
      expect(described_class.round_up(0.00)).to eq(0.00)
    end

    it 'rounds exact multiples of 0.05 unchanged' do
      expect(described_class.round_up(0.05)).to eq(0.05)
      expect(described_class.round_up(0.10)).to eq(0.10)
      expect(described_class.round_up(1.50)).to eq(1.50)
    end

    it 'rounds up values just above a multiple of 0.05' do
      expect(described_class.round_up(0.051)).to eq(0.10)
      expect(described_class.round_up(1.501)).to eq(1.55)
    end

    it 'rounds up values just below a multiple of 0.05' do
      expect(described_class.round_up(0.049)).to eq(0.05)
      expect(described_class.round_up(1.499)).to eq(1.50)
    end

    it 'handles typical tax calculations' do
      # 14.99 * 0.10 = 1.499 -> 1.50
      expect(described_class.round_up(1.499)).to eq(1.50)
      # 47.50 * 0.15 = 7.125 -> 7.15
      expect(described_class.round_up(7.125)).to eq(7.15)
      # 27.99 * 0.15 = 4.1985 -> 4.20
      expect(described_class.round_up(4.1985)).to eq(4.20)
    end
  end
end
