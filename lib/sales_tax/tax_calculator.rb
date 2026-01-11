# frozen_string_literal: true

module SalesTax
  # Calculates sales tax for items based on their category and import status.
  #
  # Tax rates:
  # - Basic sales tax: 10% (exempt for books, food, medical products)
  # - Import duty: 5% (applies to all imported goods)

  class TaxCalculator
    BASIC_TAX_RATE = 0.10
    IMPORT_DUTY_RATE = 0.05

    class << self
      # Calculates the total tax for an item
      #
      # @param name [String] The product name (used to determine category)
      # @param price [Float] The shelf price of a single item
      # @return [Float] The tax amount (rounded up to nearest 0.05)
      def calculate(name:, price:)
        tax_rate = determine_tax_rate(name)
        raw_tax = price * tax_rate
        Rounding.round_up(raw_tax)
      end

      private

      def determine_tax_rate(name)
        rate = 0.0
        rate += BASIC_TAX_RATE unless CategoryDetector.exempt?(name)
        rate += IMPORT_DUTY_RATE if CategoryDetector.imported?(name)
        rate
      end
    end
  end
end
