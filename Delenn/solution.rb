class Cave
	attr_reader :stop_point
	attr_accessor :grid

	def initialize(file)
		@stop_point = 0
		@grid = []
		File.readlines(file).each { |line|
			if !!(line[0] =~ /[0-9]/)
				@stop_point = line.to_i
			elsif not line.strip.empty?
				@grid << Array( line.strip.split('') )
			end
		}
	end

	def down_count_char(char_var = "~")
		@output = []
		(0..@grid[0].length).each do |col_index|
			has_char = false
			count = 0
			@grid.each do |row|
				if row[col_index] == char_var
					unless has_char
						has_char = true
					end
					count += 1
				elsif has_char and row[col_index] == " "
					count = char_var
					break
				end
			end
			@output << count
		end
		@output[0..-2].join(" ")
	end
end

class Water
	def initialize(maxcount = 0)
		@water = "~"
		@count = 1
		@current_pos = [0,1] # x,y
		@maxcount = maxcount
	end

	def check_open_down(grid); grid[@current_pos[1]+1][@current_pos[0]] == " "; end

	def check_open_right(grid); grid[@current_pos[1]][@current_pos[0]+1] == " "; end

	def flow(grid)
		unless @count == @maxcount
			if check_open_down(grid)
				grid = flow_down(grid)
			elsif check_open_right(grid)
				grid = flow_right(grid)
			else
				@current_pos[1] -= 1
				@current_pos[0] = grid[ @current_pos[1] ].rindex( @water )
			end
			grid
		else
			"DONE"
		end
	end
	
	private

	def forward(direction, grid)
		sleep(0.1)
		@count += 1
		@current_pos[direction] += 1 
		grid[@current_pos[1]][@current_pos[0]] = @water
		grid
	end

	def flow_down(grid); forward(1,grid); end

	def flow_right(grid); forward(0,grid); end

end

def run(file)
	cave = Cave.new(file)
	water = Water.new(cave.stop_point)
	status = cave.grid
	until status == "DONE"
		system "clear" or system "cls"
		puts cave.grid.map{|i| i.join('')}.join("\n")+"\n\n"
		cave.grid = status.dup
		status = water.flow(cave.grid)
	end
	puts cave.down_count_char
end

run("simple_cave.txt")
sleep(6)
run("complex_cave.txt")
