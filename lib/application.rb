require_relative('walmart.rb')
require_relative('files_generator.rb')


class Application < WalmartMx
  attr_reader :walmart, :crawled_products, :crawler_errors
  
  include FilesGenerator
  
  def initialize
    @walmart = WalmartMx.new
  end

  def crawler_start(bar_codes)
    @walmart = WalmartMx.new(bar_codes)
    @walmart.bar_code_loop
    @crawled_products = @walmart.crawled_products
    @crawler_errors = @walmart.crawler_errors
    @crawled_counter = @walmart.crawled_counter
  end

end
