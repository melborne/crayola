require "test/unit"

require_relative "../lib/crayola"

class TestCrayola < Test::Unit::TestCase
  def setup
    @crayola = Crayola::Crayola
    @series = ['Standard Colors', 'Silver Swirls', 'Magic Scent', 'Gem Tones', 'Pearl Brite', 'Metallic FX', 'Silly Scents', "Heads 'n Tails", 'Extreme Twistables Colors']
    @names = %w(Almond Blizzard\ Blue Canary Fern Fuzzy\ Wuzzy Manatee Orange Robin's\ Egg\ Blue Timberwolf Wisteria Pewter\ Blue Quick\ Silver Lime Daffodil Amethyst Sapphire Ruby Orchid\ Pearl Cyber\ Grape Sheen\ Green Alien\ Armpit Winter\ Wizard Sizzling\ Red Eerie\ Black Absolute\ Zero Winter\ Sky)
    @hexes = %w(EFDECD ACE5EE FFFF99 71BC78 CC6666 979AAA FF7538 1FCECB DBD7D2 CDA4DE 8BA8B7 A6A6A6 B2F302 FFFF31 892EB0 557DDB DC0646 7B4259 58427C 8FD400 84DE02 A0E6FF FF3855 1B1B1B 0048BA FF007C)
    @attrs = [['Standard Colors', 'Apricot', '#FDD9B5', [253, 217, 181], 1949, nil, nil], ['Standard Colors', 'Magic Mint', '#AAF0D1', [170, 240, 209], 1990, 2003, 'Fluorescent.'], ['Metallic FX', 'Deep Space Sparkle', '#4A646C', [74, 100, 108], 2001, nil, 'Metallic.'], ['Silly Scents', 'Gargoyle Gas', '#FFDF46', nil, nil, nil, nil], ["Heads 'n Tails", 'Denim Blue', '#2243B6', nil, nil, nil, nil]]
  end

  def test_crayola_series
    result = @series - @crayola.series
    assert(result.empty?, "Series are not match:#{result}")
  end

  def test_color_names
    cnames = @crayola.color_names
    @names.each { |name| assert(cnames.include?(name), "Name are not match:#{name}") }
  end
  
  def test_colors_size
    size = @crayola.colors.size
    assert_equal(275, size)
  end

  def test_colors_in_series
    sizes = [133, 24, 30, 16, 16, 16, 16, 16, 8]
    @series.each_with_index do |se, i|
      assert_equal(sizes[i], @crayola.colors_in_series(se).size)
    end
  end
  
  def test_color_attrs
    names = @attrs.map { |attr| attr[1] }
    names.each_with_index do |name, i|
      assert_equal(@attrs[i], @crayola.color(name).to_a)
    end
  end
  
  def test_color_hex
    @names.each_with_index do |name, i|
      assert_equal("##{@hexes[i]}", @crayola.color(name).hex)
    end
  end
  
  def test_load_build_file
    file =@crayola.load_build_file
    assert_equal(file, Crayola::Scraper.build)
  end
end
