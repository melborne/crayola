require "test/unit"
require "open-uri"
require "nokogiri"
require_relative "../lib/crayola/scraper"

class TestScraper < Test::Unit::TestCase
  def test_build
    p Crayola::Scraper.build
  end

  def test_series
    p Crayola::Scraper.series
  end
end