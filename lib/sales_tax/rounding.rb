# frozen_string_literal: true

module SalesTax
  # Handles the special rounding rule for sales tax calculations.
  # Tax amounts are rounded up to the nearest 0.05.

  class Rounding
    ROUNDING_FACTOR = 0.05

    class << self
      # Rounds up the given amount to the nearest 0.05
      #
      # @param amount [Float] The amount to round
      # @return [Float] The rounded amount
      def round_up(amount)
        ((amount / ROUNDING_FACTOR).ceil * ROUNDING_FACTOR).round(2)
      end
    end
  end
end
