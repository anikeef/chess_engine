class Array
  def get_left_diagonals
    right_padding = self.length - 1
    left_padding = 0

    self.map(&:dup).each do |row|
      right_padding.times { row << nil }
      left_padding.times { row.unshift(nil) }

      right_padding -= 1
      left_padding += 1
    end.transpose.map(&:compact)
  end

  def get_right_diagonals
    right_padding = 0
    left_padding = self.length - 1

    self.map(&:dup).each do |row|
      right_padding.times { row << nil }
      left_padding.times { row.unshift(nil) }

      right_padding += 1
      left_padding -= 1
    end.transpose.map(&:compact)
  end
end
