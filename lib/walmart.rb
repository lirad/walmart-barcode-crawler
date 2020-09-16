require_relative('crawler.rb')
require 'watir'
require 'nokogiri'

class WalmartMx < Crawler
  attr_reader :crawled_products, :crawled_counter, :crawler_errors, :valid_product, :current_crawling

  @crawled_html = nil

  def initialize(bar_codes = [])
    @crawled_counter = 0
    @crawler_errors = []
    @bar_codes = bar_codes
    @crawled_products = {}
    @crawler = Crawler.new
    @crawler.browser.goto 'https://super.walmart.com.mx/'
    @crawler.browser.element(class: 'button_icon__1dMbF').click
  end

  def crawl_products(bar_code)
    @crawler.browser.goto "https://super.walmart.com.mx/productos?Ntt=#{bar_code}"
    sleep(3)
    @crawler.browser.html
  end

  def get_size_and_weight(product_name)
    name = product_name.split
    size = 0
    weight = nil
    name.each_with_index do |n, index|
      if Integer(n, exception: false)
        size = n.to_i
        weight = name[index + 1]
      end
    end
    [size, weight]
  end

  def product_validation
    @valid_product = @page.css('#scrollToTopComponent > section > div > h2')
    @valid_product = valid_product.text.empty? ? true : false
    @valid_product
  end

  def create_record(index)
    product_name = @page.css("div.product_container__1Z_GP.grid_productBox__2MtRC
      .product_name__1669g a .text_text__1DYNl")
    product_price = @page.css("div.product_container__1Z_GP.grid_productBox__2MtRC
      .price-and-promotions_currentPrice__XT_Iz")
    size_and_weight = get_size_and_weight(product_name.text)
    product_size = size_and_weight[0]
    product_weight = size_and_weight[1]
    @crawled_products[index] = {
      "ProductName": product_name.text,
      "Price": product_price.text, "Size": product_size,
      "Weight": product_weight, "Retail": 'Walmart'
    }
    @current_crawling = @crawled_products[index]
    @crawled_counter += 1
  end

  def bar_code_loop
    @bar_codes.each_with_index do |n, index|
      @crawled_html = crawl_products(n)
      @page = Nokogiri::HTML.parse(@crawled_html)
      product_validation ? create_record(index) : @crawler_errors << n
    end
  end
end
