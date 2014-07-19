# Solves problem by treating input problem as 1D heightmap
# Focus is on trying to keep the solution simple
class RockBottom

  def initialize(level, target_water_count)
    width  = level[0].length-1
    @height = Array.new(width,0)
    @water  = Array.new(width,0)

    level.each do |line|
      line.chars.each_with_index.select { |char, index| char == '#' }.each { |char, index| @height[index] += 1 }
    end

    @current = {:column => 0, :height => @height[0] + 1, :count => 1}
    @water[0] = 1
    @height[0] += 1

    @target_water_count = target_water_count
  end

  def step
    new_column = @current[:column] + 1
    if (@height[new_column] < @current[:height])
      #Falling water or flowing water
      new_water = @current[:height] - @height[new_column]
      if new_water + @current[:count] > @target_water_count
        @water[new_column] = '~'
        return false
      end
      @water[new_column] += new_water
      @height[new_column] += new_water

      @current[:count] += new_water
      @current[:column] = new_column
      @current[:height] = @height[new_column] - new_water + 1 #We are at the bottom of the column of water
    else
      #Wall, backtrack
    
      @current[:height] = @height[@current[:column]]
      if @height[@current[:column]+1] >= @current[:height]
        #Still at wall
        target_height = @current[:height] + 1
        @current[:column] = (0..@current[:column]).reverse_each.find {|index| @height[index] >= target_height}
        @current[:height] = target_height
      end
    end
  
    @current[:count] < @target_water_count
  end

  def execute
    running = true
    while running do
      running = step
    end
  end 

  def result
    @water.join ' '
  end

end

target_water_count = STDIN.readline.to_i
STDIN.readline
STDIN.readline #skip blank line and ceiling
level = STDIN.readlines

solver = RockBottom.new level, target_water_count
solver.execute
puts solver.result
