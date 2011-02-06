require "test/unit"

require_relative "../lib/crayola"

class TestCrayola < Test::Unit::TestCase
  def setup
    @crayola = Crayola::Crayola
    @series = ['Standard Colors', 'Silver Swirls', 'Magic Scent', 'Gem Tones', 'Pearl Brite', 'Metallic FX', 'Silly Scents', "Heads 'n Tails", 'Extreme Twistables Colors']
    @names = %w(Almond Blizzard\ Blue Canary Fern Fuzzy\ Wuzzy Manatee Orange Robin's\ Egg\ Blue Timberwolf Wisteria Pewter\ Blue Quick\ Silver Lime Daffodil Amethyst Sapphire Ruby Orchid\ Pearl Cyber\ Grape Sheen\ Green Alien\ Armpit Winter\ Wizard Sizzling\ Red Eerie\ Black Absolute\ Zero Winter\ Sky)
    @hexes = %w(EFDECD ACE5EE FFFF99 71BC78 CC6666 979AAA FF7538 1FCECB DBD7D2 CDA4DE 8BA8B7 A6A6A6 B2F302 FFFF31 892EB0 557DDB DC0646 7B4259 58427C 8FD400 84DE02 A0E6FF FF3855 1B1B1B 0048BA FF007C)
  end

  def test_crayola_series
    result = @series - @crayola.series
    assert(result.empty?, "Series are not match:#{result}")
  end

  def test_color_names
    cnames = @crayola.color_names
    @names.each { |name| assert(cnames.include?(name), "Name are not match:#{name}") }
  end
  
  def test_all_colors
    size = @crayola.all_colors.size
    assert_equal(275, size)
  end
  
  def test_color_hex
    @names.each_with_index do |name, i|
      assert_equal("##{@hexes[i]}", @crayola.color(name).hex)
    end
  end
  
  def test_load_yaml_file
    file =@crayola.load_file
    assert_equal(file, Crayola::Scraper.build)
  end
end
