# frozen_string_literal: true

require_relative 'lib/sales_tax'

# Test inputs as specified in the requirements
INPUT_1 = <<~INPUT
  2 book at 12.49
  1 music CD at 14.99
  1 chocolate bar at 0.85
INPUT

INPUT_2 = <<~INPUT
  1 imported box of chocolates at 10.00
  1 imported bottle of perfume at 47.50
INPUT

INPUT_3 = <<~INPUT
  1 imported bottle of perfume at 27.99
  1 bottle of perfume at 18.99
  1 packet of headache pills at 9.75
  3 imported boxes of chocolates at 11.25
INPUT

# Process and print receipts for all test inputs
def process_input(input, label)
  puts "#{label}:"
  basket = SalesTax::ItemParser.parse_basket(input)
  receipt = SalesTax::Receipt.new(basket)
  receipt.print
  puts
end

puts '=' * 40
puts 'Sales Tax Calculator - Test Results'
puts '=' * 40
puts

process_input(INPUT_1, 'Output 1')
process_input(INPUT_2, 'Output 2')
process_input(INPUT_3, 'Output 3')
