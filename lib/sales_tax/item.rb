# frozen_string_literal: true

module SalesTax
  # Represents a purchased item with quantity, name, and pricing.

  class Item
    attr_reader :quantity, :name, :unit_price

    # Creates a new Item
    #
    # @param quantity [Integer] Number of items purchased
    # @param name [String] Product name
    # @param unit_price [Float] Price per single item (before tax)
    def initialize(quantity:, name:, unit_price:)
      @quantity = quantity
      @name = name.freeze
      @unit_price = unit_price
      freeze
    end

    # Calculates tax for a single unit of this item
    def unit_tax
      TaxCalculator.calculate(name: name, price: unit_price)
    end

    # Calculates total tax for all units of this item
    def total_tax
      (unit_tax * quantity).round(2)
    end

    # Calculates the price including tax for a single unit
    def unit_price_with_tax
      (unit_price + unit_tax).round(2)
    end

    # Calculates the total price including tax for all units
    def total_price_with_tax
      (unit_price_with_tax * quantity).round(2)
    end

    # Formats the item for receipt output
    def to_receipt_line
      "#{quantity} #{name}: #{format('%.2f', total_price_with_tax)}"
    end
  end
end
