# frozen_string_literal: true

module SalesTax
  # Represents a shopping basket containing multiple items.
  # Provides aggregate calculations for total taxes and prices.
  #
  # Thread-safety: Uses a Mutex for concurrent access.

  class Basket
    def initialize
      @items = []
      @mutex = Mutex.new
    end

    # Adds an item to the basket (thread-safe)
    def add(item)
      @mutex.synchronize { @items << item }
      self
    end

    # Returns all items in the basket (thread-safe copy)
    def items
      @mutex.synchronize { @items.dup }
    end

    # Calculates total sales taxes for all items
    def total_taxes
      items.sum(&:total_tax).round(2)
    end

    # Calculates grand total including taxes
    def total
      items.sum(&:total_price_with_tax).round(2)
    end

    def empty?
      items.empty?
    end

    def size
      items.size
    end
  end
end
