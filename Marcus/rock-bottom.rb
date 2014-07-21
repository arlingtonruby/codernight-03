#!/usr/bin/ruby

def reverse(caveMap, col, row)
  while(true)
    current = caveMap[row][col]
    bottom = caveMap[row + 1][col]
    left = caveMap[row][col - 1]
    right = caveMap[row][col + 1]

    if (left == '~' and (current == ' ' or bottom == ' '))
      return caveMap, col, row, false
    end

    # if we hit the wall, scale up
    if (current != ' ' and right == '#')
      row -= 1

    # once we have air, go left until you see water
    elsif (left == ' ' and current == ' ')
      col -= 1

    # if there's no wall on the right side, we shoudl go there
    # and then restart traversing
    elsif (left != ' ' and current != ' ' and bottom != ' ')
      col += 1
      return traverse(caveMap, col, row)
    end
  end
end

def traverse(caveMap, col, row)
  # race to the bottom
  current = caveMap[row][col]
  bottom = caveMap[row + 1][col]
  right = caveMap[row][col + 1]

  # if current pos is empty, we can fill it
  if (current == ' ')
    caveMap[row][col] = '~'
    return caveMap, col, row, true
  end

  # follow empty space and water down
  if (bottom != '#')
    row += 1
    return caveMap, col, row, false
  end

  # shift right to follow when bottom is occupied
  # but don't do this through walls
  if (bottom != ' ' and right != '#')
    col += 1
    return caveMap, col, row, false
  end

  # if the bottom is filled but we hit a wall
  # gotta backtrack
  if (bottom != ' ' and right == '#')
    return reverse(caveMap, col, row)
  end
end

def fillCaveMap(caveMap)
  col = 0
  row = 1
  complete = false

  while(!complete)
    caveMap, col, row, complete = traverse(caveMap, col, row)
  end
end

inputFile = 'input/simple_cave.txt'

if ARGV.length > 0
  inputFile = ARGV[0]
end

puts 'processing %s' % inputFile

# zzz
file = File.open(inputFile, 'r')
lines = file.read.split("\n")

# how many units of water we fillin?
fillAmount = lines[0].to_i
# make us a 2d map of da cave
caveMap = lines[2..-1].map { |row| row.split('') }

# fill the cave!!!
fillAmount.times do |x|
  fillCaveMap(caveMap)
end

# we needs defffs
depths = caveMap[0].map {
  0
}

caveMap.each_with_index { |row, j|
  row.each_with_index { |col, i|
    if (col == '~')
      depths[i] += 1
    end
    if (depths[i] != 0 and col == ' ')
      depths[i] = '~'
    end
  }
}

depths = depths.join(' ')

# display da results and print em to file
puts caveMap.map { |row| row.join }
            .join("\n")
puts depths

# write our depths to file
write = File.open(inputFile.sub('input', 'output').sub('cave', 'out'), 'w')
write << depths + "\n"
write.close

