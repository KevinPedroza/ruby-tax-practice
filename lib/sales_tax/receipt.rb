# frozen_string_literal: true

module SalesTax
  # Generates formatted receipt output from a Basket.

  class Receipt
    def initialize(basket)
      @basket = basket
    end

    # Generates the complete receipt as a string
    def generate
      lines = []
      @basket.items.each do |item|
        lines << item.to_receipt_line
      end
      lines << "Sales Taxes: #{format('%.2f', @basket.total_taxes)}"
      lines << "Total: #{format('%.2f', @basket.total)}"
      lines.join("\n")
    end

    # Prints the receipt to stdout
    def print
      puts generate
    end
  end
end
