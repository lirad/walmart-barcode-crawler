require 'watir'

class Crawler
  attr_reader :browser

  def initialize
    @browser = Watir::Browser.new
  end
end
