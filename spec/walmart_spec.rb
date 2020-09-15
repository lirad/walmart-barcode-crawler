require("./lib/walmart.rb")

describe WalmartMx do
  let(:walmart) { WalmartMx.new }
  let(:bar_code_true) { ["00779129302256"] }
  let(:bar_code_false) { ["00779129"] }
  let(:product_name) { "Antitranspirante Rexona men motion sense v8 en aerosol para caballero 90 g" }

  describe "#crawl_products" do
    it "Check if product is beign crawled with name and price" do
      html = walmart.crawl_products(bar_code_true)
      page = Nokogiri::HTML(html)
      product_name_crawled = page.css("div.product_container__1Z_GP.grid_productBox__2MtRC
        .product_name__1669g a .text_text__1DYNl").text
      expect(product_name_crawled).to eq(product_name)
    end
  end

  describe "#get_size_and_weight" do
    it "Verify if weight and type of measurement is beign extracted from title" do
      size_and_weigth = walmart.get_size_and_weight(product_name)
      expect(size_and_weigth).to eq([90, "g"])
    end
  end

  describe "#product_validation" do
    it "Checks if barcode is invalid" do
      walmart = WalmartMx.new(bar_code_false)
      walmart.bar_code_loop
      expect(walmart.crawler_errors).to eq(bar_code_false)
    end
  end

  describe "#create_record" do
    it "Checks if a barcode is valid" do
      walmart = WalmartMx.new(bar_code_true)
      walmart.bar_code_loop
      expect(walmart.crawled_counter).to eq(1)
    end
  end
end
