require "test/unit"
require "open-uri"
require "nokogiri"
autoload :YAML, 'yaml'
require_relative "../lib/crayola/scraper"

class TestScraper < Test::Unit::TestCase
  def setup
    @scraper = Crayola::Scraper
  end

  def test_build
    p @scraper.build
  end
  
  def test_series
    p @scraper.series
  end

  def test_to_file
    @scraper.to_file
  end
end