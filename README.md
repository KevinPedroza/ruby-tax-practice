# Sales Tax Calculator

A Ruby application that calculates sales taxes for shopping baskets and generates itemized receipts.

## Problem Description

This application implements a sales tax calculator with the following rules:

- **Basic sales tax**: 10% applicable on all goods, **except** books, food, and medical products (exempt)
- **Import duty**: 5% additional tax on all imported goods (no exemptions)
- **Rounding**: Tax amounts are rounded up to the nearest 0.05

## Architecture & Design

The application follows Object-Oriented Programming principles with a focus on:

### Single Responsibility Principle
Each class has one clear responsibility:

| Class | Responsibility |
|-------|---------------|
| `Rounding` | Handles the special rounding rule (round up to nearest 0.05) |
| `CategoryDetector` | Determines product categories for tax exemptions |
| `TaxCalculator` | Calculates taxes using Rounding and CategoryDetector |
| `Item` | Represents a purchased item with price and tax calculations |
| `Basket` | Manages a collection of items with aggregate calculations |
| `Receipt` | Generates formatted receipt output |
| `ItemParser` | Parses input strings into Item objects |

## Requirements

- Ruby 3.2 or later
- Docker (optional, for containerized execution)

## Installation

### Using Docker (Recommended)

```bash
docker build -t sales-tax .
docker run sales-tax
```

### Local Installation

```bash
bundle install
```

## Usage

### Running the Application

```bash
# With Docker
docker run sales-tax

# Without Docker
ruby main.rb
```

### Running Tests

```bash
# With Docker
docker run sales-tax bundle exec rspec

# Without Docker
bundle exec rspec
```

## Input Format

Items should be provided in the following format:
```
<quantity> <product name> at <price>
```

Example:
```
2 book at 12.49
1 imported bottle of perfume at 47.50
```

## Sample Inputs and Expected Outputs

### Input 1
```
2 book at 12.49
1 music CD at 14.99
1 chocolate bar at 0.85
```

**Output 1:**
```
2 book: 24.98
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 42.32
```

### Input 2
```
1 imported box of chocolates at 10.00
1 imported bottle of perfume at 47.50
```

**Output 2:**
```
1 imported box of chocolates: 10.50
1 imported bottle of perfume: 54.65
Sales Taxes: 7.65
Total: 65.15
```

### Input 3
```
1 imported bottle of perfume at 27.99
1 bottle of perfume at 18.99
1 packet of headache pills at 9.75
3 imported boxes of chocolates at 11.25
```

**Output 3:**
```
1 imported bottle of perfume: 32.19
1 bottle of perfume: 20.89
1 packet of headache pills: 9.75
3 imported boxes of chocolates: 35.55
Sales Taxes: 7.90
Total: 98.38
```

## Project Structure

```
.
├── Dockerfile              # Docker configuration
├── Gemfile                 # Ruby dependencies
├── README.md               # This file
├── main.rb                 # Application entry point
├── lib/
│   ├── sales_tax.rb        # Main module loader
│   └── sales_tax/
│       ├── basket.rb       # Shopping basket class
│       ├── category_detector.rb  # Product category detection
│       ├── item.rb         # Item representation
│       ├── item_parser.rb  # Input parsing
│       ├── receipt.rb      # Receipt generation
│       ├── rounding.rb     # Tax rounding logic
│       └── tax_calculator.rb  # Tax calculation
└── spec/
    ├── spec_helper.rb      # RSpec configuration
    ├── integration_spec.rb # End-to-end tests
    └── sales_tax/
        ├── basket_spec.rb
        ├── category_detector_spec.rb
        ├── item_parser_spec.rb
        ├── item_spec.rb
        ├── receipt_spec.rb
        ├── rounding_spec.rb
        └── tax_calculator_spec.rb
```

## Testing

The application includes comprehensive RSpec tests covering:

- **Unit tests** for each class
- **Integration tests** verifying all three sample inputs produce expected outputs
- **Thread safety tests** for concurrent basket modifications

Run the full test suite:
```bash
bundle exec rspec
```
