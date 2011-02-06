autoload :YAML, 'yaml'

module Crayola
  require_relative 'crayola/scraper'
  require_relative 'crayola/color'
  class Crayola
    class << self
      def init
        @crayola = load_file || Scraper.build
        @colors = []
      end

      def all_colors
        return @colors unless @colors.empty?
        @colors = crayolas_to_array { |series, attrs| Color.new(series, *attrs) }
      end

      def color(name)
        all_colors.detect { |c| c.name == name }
      end

      def colors_in_series(series)
        all_colors.select { |c| c.series == series }
      end

      def series
        @crayola.keys
      end

      def color_names
        crayolas_to_array { |series, attrs| attrs[0] }
      end

      def crayolas_to_array
        arr = []
        @crayola.each { |series, v| v.each { |attrs| arr << yield(series, attrs) } }
        arr
      end

      def load_file(io=CURRENT_DIR+'/crayola.yml')
        YAML.load open(io, 'r')
      rescue
        nil
      end
    end

    init
  end
end
