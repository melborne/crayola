module Crayola
  class Scraper
    URL = "http://en.wikipedia.org/wiki/List_of_Crayola_crayon_colors"
    class << self
      def build
        @html ||= get(URL)
        parse @html
      end

      def get(url)
        @html = Nokogiri::HTML(open url)
      rescue OpenURI::HTTPError => e
        STDERR.puts "HTTP Access Error:#{e}"
        exit
      end

      def parse(html)
        crayons = parse_tables(html)
        crayons = delete_useless(crayons)
        normalize_data(crayons)
      end
      
      def parse_tables(html)
        q = Hash.new{ |h,k| h[k]=[] }
        tables = html.css('.wikitable')
        tables.each_with_index do |tb, i|
          tb.css('tr').each do |tr|
            q[series[i]] << tr.css('td').map do |td|
              hex = td.attr('style')[/#[A-Z0-9]{6}/] rescue nil
              hex ? [td.content, hex] : td.content
            end
          end
        end
        q
      end

      def series
        @series ||= get_series
      end

      def get_series
        @html ||= get(URL)
        @series = []
        @html.css('.mw-headline').each { |title| @series << title.content }
        @series -= ['Specialty Crayons','See also','References','External links']
      end

      def delete_useless(crayons)
        useless = ['Changeables','Color Mix-Up','Crayons with Glitter','True to Life']
        crayons.delete_if { |name, _| useless.include? name }
      end

      def normalize_data(crayons)
        have_attrs = ['Standard Colors', 'Metallic FX']
        have_no_attrs = crayons.keys - have_attrs
        have_attrs.each do |name|
          crayons[name] = crayons[name].map { |attr| attr.flatten.uniq[1..-1] }[1..-1]
        end
        have_no_attrs.each { |name| crayons[name] = crayons[name].flatten(1) }
        crayons
      end
    end
  end
end
