require_relative 'cave_reader'

class Main
  def initialize(cavefilename)
    @cave_reader = CaveReader.new(cavefilename).read.simulate
  end
end

filename = ARGV[0] || 'simple_cave.txt'
Main.new filename
