require "test/unit"

require_relative "../lib/crayola"

class TestCrayola < Test::Unit::TestCase
  def setup
    @crayola = Crayola::Crayola
  end

  def test_crayola_series
    p @crayola.series
  end

  def test_color_names
    p @crayola.color_names
  end

  def test_all_colors
    colors = @crayola.all_colors
  end

  def test_color_hex
    names = ['Apricot', 'Blue Green', 'Mauvelous', "Purple Mountain's Majesty"]
    hexes = ['#FDD9B5', '#0D98BA', '#EF98AA', '#9D81BA']
    names.each_with_index do |name, i|
      assert_equal(hexes[i], @crayola.color(name).hex)
    end
  end

  def test_load_yaml_file
    puts @crayola.load_file
  end
end
