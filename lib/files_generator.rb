require 'csv'

class FilesGenerator
  def initialize
  end

  def read_input_csv
    bar_codes = CSV.read("./input/bar_codes.csv")
    bar_codes = bar_codes.map {|n| n.join(', ')}
    return bar_codes
  end

  def generate_output_csv(crawled_products)
    data = CSV.generate do |csv|
      csv << %w[Product Name Price Size Weight Retail]
      crawled_products.each do |_k, v|
        csv << [v[:ProductName], v[:Price], v[:Size], v[:Weight], v[:Retail]]
      end
    end
    File.write('products.csv', data)
  end
end
