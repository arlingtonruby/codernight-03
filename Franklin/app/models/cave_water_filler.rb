class CaveWaterFiller

  def self.fill(cave)
    puts cave
    x, y = Cave.new(cave).next_water_position
    cave[x][y] = "~"
    cave
  end

end

class Cave

  def initialize(cave_data)
    sleep 0.01
    @cave_data =  Marshal.load(Marshal.dump(cave_data))
  end

  def next_water_position(x=1, y=0)
    return [x, y] if @cave_data[x][y] == " "
    @cave_data[x][y]="X"
    return next_water_position(x+1 , y) unless ["#", "X"].include? @cave_data[x+1][y]
    return next_water_position(x, y+1) unless @cave_data[x][y+1] == "#"
    return next_water_position(x-1, @cave_data[x-1].rindex("X"))
  end

end