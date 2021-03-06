require 'csv'
require 'terminal-table'

module FilesGenerator
  def read_input_csv
    # rubocop:disable Style/GuardClause
    if File.exist?('./input/bar_codes.csv')
      bar_codes = CSV.read('./input/bar_codes.csv')
    else
      raise 'Bar codes files missing, add a bar_codes.csv file to the input folder.'
    end
    # rubocop:enable Style/GuardClause
    bar_codes = bar_codes.map do |n|
      n.join(', ') if n.length == 1
    end
    bar_codes
  end

  def generate_output_csv(crawled_products)
    @data = CSV.generate do |csv|
      csv << %w[Product Name Price Size Weight Retail]
      crawled_products.each do |_k, v|
        csv << [v[:ProductName], v[:Price], v[:Size], v[:Weight], v[:Retail]]
      end
    end

    File.write('./output/products.csv', @data)
  end

  def table_generator(crawled_products)
    rows = []
    crawled_products.each do |_k, v|
      rows << [v[:ProductName], v[:Price], v[:Size], v[:Weight], v[:Retail]]
    end
    table = Terminal::Table.new headings: %w[Product Price Size Weight Retail], rows: rows
    table
  end

  def table_errors(crawled_products_error)
    rows = []
    crawled_products_error.each do |n|
      rows << [n]
    end
    table = Terminal::Table.new headings: %w[Barcode], rows: rows
    table
  end
end
