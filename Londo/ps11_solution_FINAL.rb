# Date: 6/13/2014
# Approx Hours: 5-6 (more if you include other solutions that sucked)

########
### METHODS USING file_path. BUILD HASH MAPS, AND CALC "water_units"
########

# Build hash of rows using file_path; values go L->R in the row
def build_rows_hash(file_path, rows_hash={})
	file = File.readlines(file_path)
	file[2..-1].each_with_index { |line, index| rows_hash["row_#{index}".to_sym] = (line.split("")) }
	return rows_hash
end

# Build hash of columns using rows hash; values go T->B in the column, and strips top 'row' of values (removes the 'roof'). Result is that column[:column_0][0] will be the water "source", and also the top-left most position
def build_columns_hash_from_rows(rows_hash, columns_hash = {})
	for i in 0..(rows_hash[:row_0].length-2)
		rows_hash.keys[1..-1].each do |key|
			columns_hash["column_#{i}".to_sym] ||= []
			columns_hash["column_#{i}".to_sym].push(rows_hash[key][i])
		end
	end
	return columns_hash
end

# calculate number of water units ("~") to use as a counter
def water_units(file_path)
	file = File.readlines(file_path)
	units = file[0][0..-1].to_i-1
	return units
end

########
### METHODS TO INTERACT WITH THE MAP
########
def fill_space(pos_hash, rows_hash)
	# fill current position with "~"
	rows_hash["row_#{pos_hash[:row]}".to_sym][pos_hash[:col]] = "~"
	return rows_hash
end

def touch_below(pos_hash,rows_hash)
	return rows_hash["row_#{pos_hash[:row]+1}".to_sym][pos_hash[:col]]
end

def touch_right(pos_hash,rows_hash)
	return rows_hash["row_#{pos_hash[:row]}".to_sym][pos_hash[:col]+1]
end

def move_up(pos_hash, rows_hash)
	# uses current position to go up a row, then to the first open space to the right of the right-most "~" in the row
	pos_hash[:row] -= 1
	pos_hash[:col] = rows_hash["row_#{pos_hash[:row]}".to_sym].rindex("~")
	return pos_hash
end

########
### METHOD TO "FILL" CAVE
########
def fill_er_up(file_path)
	rows = build_rows_hash(file_path)
	columns = build_columns_hash_from_rows(rows)
	pos_hash = { col: 0, row: columns[:column_0].index("~")+1 }
	counter = water_units(file_path)
	
	while counter > 0
		if touch_below(pos_hash,rows) == " "
			pos_hash[:row] += 1
			fill_space(pos_hash,rows)
			counter -= 1
		elsif touch_right(pos_hash,rows) == " "
			pos_hash[:col] += 1
			fill_space(pos_hash,rows)
			counter -= 1
		else
			move_up(pos_hash, rows)
		end
	end

	return rows
end

########
### METHOD TO CALCULATE OUTPUT STRING
########

def calc_output(rows_hash)
	ans = ""
	columns = build_columns_hash_from_rows(rows_hash)
	columns.values.each do |key|
		tildes = key.count("~")
		ans += "#{tildes} "
	end
	ans = ans[0..-2]
	puts ans
	return rows_hash
end

########
### TAKE FILE PATH AS INPUT AND GENERATE OUTPUT STRING; OFFER MORE OPTIONS
########

puts "-----------","Please enter file path:"
file_path = gets.chomp
puts "-----------","Answer:"
rows = calc_output(fill_er_up(file_path))

puts "-----------","See the final state of the map in console? (y/n)"
show_map = gets.chomp
puts rows.values.to_a.join if show_map == "y"

puts "-----------","Export final_map to text file? (y/n)"
open_map = gets.chomp
if open_map == "y"
	final_map = File.open("final_map.txt", "w") { |f| f.write(rows.values.to_a.join) }
	%x{open -a TextEdit final_map.txt} if  open_map == "y"
end

puts "-----------","Delete final_map file? (y/n)"
delete_file = gets.chomp
%x{rm final_map.txt} if delete_file == "y"