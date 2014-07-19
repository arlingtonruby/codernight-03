class Cave

  def initialize(cave)
    @cave = cave
    @debug = false
    @heights = []
  end

  def simulate(row, col, water_level)
    while water_level > 0
      row, col, water_level = add_water row, col, water_level
    end
    @heights = []
    @cave.each do |r|
      @heights = r.each_with_index.map do |c, i|
        if (c == '~')
          @heights[i] ? @heights[i] + 1 : 1
        else
          @heights[i] ? @heights[i] : 0
        end
      end
    end
    @heights
  end

  protected
    def has_underneath(row, col)
      @cave[row - 1][col] != ' '
    end

    def peek(row, col)
      @cave[row][col]
    end

    def empty_forward?(row, col)
      peek(row, col + 1) == ' '
    end

    def empty_down?(row, col)
      peek(row - 1, col) == ' '
    end

    def empty?(row, col)
      peek(row, col) == ' '
    end

    def dump
      @cave.reverse.each { |line| puts line.join '' }
    end

    def mark_current(row, col)
      @cave[row][col] = '~'
      1
    end

    def more_water?(counter, water_level)
      counter <= water_level
    end

    #when have no where else to go, start row over
    def backtrace(row, col)
      row += 1
      col -= 1
      while empty?(row, col)
        puts "#{row}, #{col}: #{@cave[row][col]}" if @debug
        col -= 1
      end
      [row, col]
    end

    def traverse_y(row, col, water_level)
      counter = 0
      empty = true

      while empty && more_water?(counter, water_level)
        mark_current row, col
        counter += 1

        row -= 1
        empty = empty?(row, col)
      end
      # adjust for the premature advance for testing in the while
      counter -= 1 if counter > 0
      counter
    end

    def traverse_x(row, col, water_level)
      counter = 0
      empty = true

      # see if you need to continue
      while empty && has_underneath(row, col) && more_water?(counter, water_level)
        mark_current row, col
        counter += 1

        col += 1
        empty = empty?(row, col)
      end
      # adjust for the premature advance for testing in the while
      counter -= 1 if counter > 0
      counter
    end

    def flow_right(row, col, water_level)
      #try look ahead
      if empty_forward? row, col
        col += 1
        water_level -= mark_current(row, col)
        distance = traverse_x(row, col, water_level)
        col += distance
      else
        #when have no where else to go, backtrace
        row, col = backtrace row, col
        distance = 0
      end
      [row, col, water_level, distance]
    end

    def flow_down(row, col, water_level)
      #try look ahead
      if empty_down? row, col
        row -= 1
        water_level -= mark_current(row, col)
        distance = traverse_y(row, col, water_level)
        row -= (distance)
      end
      [row, col, water_level, distance]
    end

    def add_water(row, col, water_level)
      if has_underneath(row, col)
        row, col, water_level, distance = flow_right row, col, water_level
      else
        row, col, water_level, distance = flow_down row, col, water_level
      end
      water_level -= distance

      if @debug
        puts "#{row}, #{col}: #{water_level}"
        dump
        puts "\n"
      end

      [row, col, water_level]
    end
end
