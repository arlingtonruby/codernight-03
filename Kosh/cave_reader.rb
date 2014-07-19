require_relative 'cave'

class CaveReader
  attr_accessor :cave

  def initialize(cavefilename)
    @cavefilename = cavefilename
    @cave = nil
    @start_row = nil
    @start_col = nil
    @water_level = 0
  end

  def read
    backwards_cave = []
    File.open(@cavefilename, 'r').each_line.with_index do |line, row|
      if row == 0
        @water_level = line.strip().to_i
      elsif row > 1
        characters = []
        line.strip.each_char.with_index do |c, col|
          characters << c
          if c == '~'
            @start_row = row - 2
            @start_col = col
          end
        end

        backwards_cave << characters
      end
    end

    #fix the fact I read it in backwards from the top
    #  i want the origin at the bottom
    normalized_size = backwards_cave.size - 1
    @cave = Cave.new backwards_cave.reverse
    @start_row = normalized_size - @start_row
    self
  end

  def simulate
    heights = @cave.simulate @start_row, @start_col, @water_level
    puts heights.join ' '
  end
end
