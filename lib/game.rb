require "./lib/board.rb"
require "./lib/player.rb"
require "./lib/validator.rb"
require "./lib/move.rb"
Dir["./lib/pieces/*.rb"].each { |file| require file }

class Game
  attr_accessor :filename, :board, :current_player
  include MoveValidator

  def initialize
    @board = Board.new
    @board.set_default
    @players = [Player.new(:white), Player.new(:black)]
    @current_player = @players[0]
    @last_piece = nil
    @filename = nil
  end

  def move(from, to)
    piece = @board.at(from)
    raise IncorrectInput, "Empty square is chosen" if piece.nil?
    raise IncorrectInput, "This is not your piece" unless piece.color == @current_player.color
    raise IncorrectInput, "Invalid move" unless valid_moves(from).include?(to)
    move = Move.new(@board, from, to)
    move.commit
    if king_attacked?
      move.rollback
      raise IncorrectInput, "Fatal move"
    end

    @last_piece = piece
    piece.moves_count += 1
    promotion(piece) if piece.class == Pawn && [7, 0].include?(to[1])
    next_player
  end

  def promotion(pawn)
    piece_classes = [Queen, Rook, Knight, Elephant]
    @board.set_at(pawn.position, piece_classes[@current_player.input_promotion - 1].new(@current_player.color))
  end

  def castling(length)
    row = @current_player.color == :white ? 0 : 7
    king = @board[4, row]
    rook = length == 2 ? @board[7, row] : @board[0, row]
    line = length == 2 ? [5, 6] : [1, 2, 3]
    raise IncorrectInput, "Invalid castling" unless
      king.class == King && rook.class == Rook &&
      king.moves == 0 && rook.moves == 0 &&
      line.all? { |x| @board[x, row].nil? }

    if length == 2
      @board.move_piece([4, row], [6, row])
      @board.move_piece([7, row], [5, row])
    else
      @board.move_piece([4, row], [2, row])
      @board.move_piece([0, row], [3, row])
    end
  end

  def over?
    @board.piece_coordinates(@current_player.color).all? do |coord|
      safe_moves(coord).empty?
    end
  end

  def next_player
    @current_player = @current_player == @players[0] ? @players[1] : @players[0]
  end

  def check?
    opposite_color = @current_player.color == :black ? :white : :black
    @board.piece_coordinates(opposite_color).any? do |coord|
      valid_moves(coord).include? @board.kings[@current_player.color]
    end
  end

  def king_attacked?
    king_coords = @board.kings[@current_player.color]
    [[1, 1], [-1, 1], [-1, -1], [1, -1]].each do |move|
      edge_coords = repeated_move(king_coords, move).last
      piece = edge_coords.nil? ? nil : @board.at(edge_coords)
      return true if !piece.nil? && piece.beats_diagonally?
    end
    [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |move|
      edge_coords = repeated_move(king_coords, move).last
      piece = edge_coords.nil? ? nil : @board.at(edge_coords)
      return true if !piece.nil? && piece.beats_straight?
    end
    [[1, 2], [2, 1], [1, -2], [-2, 1],
    [-1, 2], [2, -1], [-1, -2], [-2, -1]].each do |move|
      coords = relative_coords(king_coords, move)
      piece = valid_move?(coords) ? @board.at(coords) : nil
      return true if !piece.nil? && piece.knight?
    end
    false
  end
end
