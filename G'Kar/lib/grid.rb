class Grid
  def self.from(cave)
    new(cave)
  end

  def initialize(cave)
    @rows = cave.split(/\n/).map(&:strip)
  end

  def at(row, col)
    @rows[row][col]
  end
  
  def water_at?(row, col)
    at(row, col) == '~'
  end

  def fill(row, col)
    @rows[row][col] = '~'
    self
  end

  def to_s
    @rows.join("\n") + "\n"
  end

  def width
    @rows.first.size
  end

  def height
    @rows.size - 1
  end

  def depth_counts
    (0...width).map { |col|
      depth_for_col(col)
    }
  end

  private

  def depth_for_col(col)
    water_found = false
    (1..height - 1).inject(0) { |m, row|
      v = @rows[row][col]
      if v == '~'
        water_found = true
        m += 1
      elsif water_found && v == ' '
        m = '~'
      end
      m
    }
  end
end

