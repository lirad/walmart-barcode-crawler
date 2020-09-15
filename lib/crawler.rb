require 'watir'
require 'headless'

class Crawler
  attr_reader :browser

  def initialize
    @browser = Watir::Browser.new :chrome, headless: true
  end
end
