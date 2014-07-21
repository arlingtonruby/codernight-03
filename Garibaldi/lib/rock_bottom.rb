class RockBottom
  def initialize(rows, print: false)
    @print = print
    @initial_count = rows[0].to_i
    @board = rows.drop(2).map do |row|
      row.chomp.split('')
    end
  end

  def call
    simple_water_fill(@board, @initial_count, 1, 0)
    sum_water_columns(@board).join " "
  end

  private

  def clear_screen
    puts "\e[H\e[2J"
  end

  def print_board(count)
    clear_screen
    puts @initial_count - count
    puts ''
    @board.each do |line|
      line.each do |char|
        if char == '~'
          print "\033[34m#{char}\033[0m"
        else
          print char
        end
      end
      puts ''
    end
    sleep 0.2
  end

  def simple_water_fill(board, count, row, column)
    print_board(count) if @print
    if count !=1
      if flow_down_if_cell_below_is_empty(board, row, column)
        simple_water_fill(board, count-1, row+1, column)
      elsif flow_forward_if_below_is_filled(board, row, column)
        simple_water_fill(board, count-1, row, column+1)
      elsif flow_up_if_forward_and_below_filled(board, row, column)
        column = column-1 while board[row-1][column] == ' '
        simple_water_fill(board, count, row-1, column)
      else
        if board[row-1][column] == '#' && board[row][column+1] == '#'
          count = 0
        end
      end
    end

    board
  end

  def sum_water_columns(board)
    sums = Array.new(board.first.length, 0)

    board.each_with_index do |row, xi|
      row.each_with_index do |cel, yi|
        sums[yi] += 1 if board[xi][yi] == '~'
      end
    end

    sums
  end

  def flow_down_if_cell_below_is_empty(board, row, column)
    board[row+1][column] = '~' if board[row+1][column] == ' '
  end

  def flow_forward_if_below_is_filled(board, row, column)
    board[row][column+1] = '~' if board[row][column+1] == ' '
  end

  def flow_up_if_forward_and_below_filled(board, row, column)
    (board[row-1][column] == ' ')
  end
end
