require("./lib/files_generator.rb")

describe FilesGenerator do
  let(:file_generator) { FilesGenerator.new }
  let(:crawled_products) {
    { 0 => { "ProductName": "Product A",
           "Price": "$33.00", "Size": "120",
           "Weight": "ml", "Retail": "Walmart" } }
  }

  describe "#generate_output_csv" do
    it "Check if files with products are being generated" do
      file_generator.generate_output_csv(crawled_products)
      expect(File.exist?("./output/products.csv")).to eq(true)
    end
  end
end
