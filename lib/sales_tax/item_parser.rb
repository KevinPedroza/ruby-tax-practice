# frozen_string_literal: true

module SalesTax
  # Parses input strings into Item objects.
  # Expected format: "<quantity> <name> at <price>"

  class ItemParser
    INPUT_PATTERN = /^(\d+)\s+(.+)\s+at\s+(\d+\.\d{2})$/

    class << self
      # Parses a single input line into an Item
      def parse(line)
        match = INPUT_PATTERN.match(line.strip)
        raise ArgumentError, "Invalid input format: #{line}" unless match

        Item.new(
          quantity: match[1].to_i,
          name: match[2].strip,
          unit_price: match[3].to_f
        )
      end

      # Parses multiple input lines into a Basket
      def parse_basket(input)
        basket = Basket.new
        input.each_line do |line|
          next if line.strip.empty?
          basket.add(parse(line))
        end
        basket
      end
    end
  end
end
