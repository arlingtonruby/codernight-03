require 'flow_rules'
require 'grid'

class Simulator
  def initialize(cave, flow_stack = [[1, 0]])
    @cave = cave
    @flow_stack = flow_stack
  end

  def flow!(iterations = 1)
    iterations.times do
      coord = FlowRules.new(@cave, @flow_stack).next_cell
      @flow_stack.push(coord)
      @cave = fill_coord_in_cave(*coord)
    end
    self
  end

  def to_s
    @cave
  end

  def depth_counts
    Grid.from(@cave).depth_counts
  end

  private

  def fill_coord_in_cave(row, col)
    Grid.from(@cave).fill(row, col).to_s
  end
end
