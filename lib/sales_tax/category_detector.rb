# frozen_string_literal: true

module SalesTax
  # Detects product categories to determine tax exemptions.
  # Books, food, and medical products are exempt from basic sales tax.
  # Imported goods are subject to import duty regardless of category.

  class CategoryDetector
    # Keywords that indicate exempt product categories
    FOOD_KEYWORDS = %w[chocolate chocolates candy].freeze
    BOOK_KEYWORDS = %w[book books].freeze
    MEDICAL_KEYWORDS = %w[pills pill headache medicine vitamin].freeze
    IMPORT_KEYWORD = 'imported'

    class << self
      # Determines if a product is exempt from basic sales tax
      #
      # @param name [String] The product name
      # @return [Boolean] true if exempt from basic sales tax or not
      def exempt?(name)
        normalized = name.downcase
        food?(normalized) || book?(normalized) || medical?(normalized)
      end

      # Determines if a product is imported
      #
      # @param name [String] The product name
      # @return [Boolean] true if the product is imported
      def imported?(name)
        name.downcase.include?(IMPORT_KEYWORD)
      end

      private

      def food?(name)
        FOOD_KEYWORDS.any? { |keyword| name.include?(keyword) }
      end

      def book?(name)
        BOOK_KEYWORDS.any? { |keyword| name.include?(keyword) }
      end

      def medical?(name)
        MEDICAL_KEYWORDS.any? { |keyword| name.include?(keyword) }
      end
    end
  end
end
