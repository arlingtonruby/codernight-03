class CaveScorer

  def self.score(board)
    board = rotate(board)

    answers = board.collect do |row|
      row_score(row)
    end.join " "
  end

  def self.rotate(data)
    (0..data[0].size-1).map do|colidx|
      data.map do|row|
        row[colidx]
      end.reverse.join
    end
  end


  def self.row_score(row)
    return "~" if row.include?(" ~")
    return row.count "~"
  end

end