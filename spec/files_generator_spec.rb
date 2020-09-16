require('./lib/files_generator.rb')

describe FilesGenerator do
  let(:file_generator) { FilesGenerator.new }
  let(:crawled_products) do
    { 0 => { "ProductName": 'Antitranspirante Rexona men motion sense v8 en aerosol para caballero 90 g',
             "Price": '$47.00', "Size": '90',
             "Weight": 'g', "Retail": 'Walmart' } }
  end

  describe '#table_generator' do
    it 'Check if tables are being correctly generated' do
      generated_table = file_generator.table_generator(crawled_products)
      expected_table = "+----------------------------------------------------------------------------+--------+------+--------+---------+\n| Product                                                                    | Price  | Size | Weight | Retail  |\n+----------------------------------------------------------------------------+--------+------+--------+---------+\n| Antitranspirante Rexona men motion sense v8 en aerosol para caballero 90 g | $47.00 | 90   | g      | Walmart |\n+----------------------------------------------------------------------------+--------+------+--------+---------+"
      expect(expected_table).to eq(generated_table.to_s)
    end
  end

  describe '#generate_output_csv' do
    it 'Check if files with products are being generated' do
      file_generator.generate_output_csv(crawled_products)
      expect(File.exist?('./output/products.csv')).to eq(true)
    end
  end
end
