require "nokogiri"
require "open-uri"

module Crayola
  require_relative 'crayola/scraper'
  require_relative 'crayola/color'
  class Crayola
    class << self
      def init
        @crayola = build || Scraper.build
        @colors = []
      end

      def all_colors
        return @colors unless @colors.empty?
        @colors = crayolas_to_array { |series, attrs| Color.new(series, *attrs) }
      end

      def color(name)
        all_colors.detect { |c| c.name == name }
      end

      def series
        Scraper.series
      end

      def color_names
        crayolas_to_array { |series, attrs| attrs[0] }
      end

      def crayolas_to_array
        arr = []
        @crayola.each { |series, v| v.each { |attrs| arr << yield(series, attrs) } }
        arr
      end

      def build
        eval open(File.expand_path(File.dirname(__FILE__)+'/crayola/data')).read
      end
    end
    init
  end
end
