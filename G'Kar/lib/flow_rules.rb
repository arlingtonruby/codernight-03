class FlowRules
  def initialize(cave, flow_stack)
    @cave = cave
    @flow_stack = flow_stack
  end

  def next_cell
    flow = @flow_stack.dup
    last_coord = flow.pop
    row, col = last_coord[0], last_coord[1]

    if cell_below_is_open?
      row += 1
    elsif cell_right_is_open?
      col += 1
    else
      row, col = FlowRules.new(@cave, flow).next_cell
    end
    [row, col]
  end

  def cell_below_is_open?
    grid = Grid.from(@cave)
    grid.at(@flow_stack.last[0] + 1, @flow_stack.last[1]) == ' '
  end

  def cell_right_is_open?
    grid = Grid.from(@cave)
    grid.at(@flow_stack.last[0], @flow_stack.last[1] + 1) == ' '
  end
end
