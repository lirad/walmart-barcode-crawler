require 'csv'

class FilesGenerator
  def initialize
  end

  def read_input_csv
    bar_codes = CSV.read("./input/bar_codes.csv")
    bar_codes = bar_codes.map do |n| 
      if n.length == 1
        n.join(', ')
      end
    end
    return bar_codes
  end

  def generate_output_csv(crawled_products)
    data = CSV.generate do |csv|
      csv << %w[Product Name Price Size Weight Retail]
      crawled_products.each do |_k, v|
        csv << [v[:ProductName], v[:Price], v[:Size], v[:Weight], v[:Retail]]
      end
    end
    File.write('./output/products.csv', data)
  end
end
