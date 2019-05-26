require_relative "board"
require_relative "move_validator"
require_relative "move"

module ChessEngine
  class InvalidMove < StandardError; end

  ##
  # This class provides all the rules for the chess game. It recognizes check,
  # checkmate and stalemate. Move validations logic can be found in the
  # MoveValidator module, which is included in this class

  class Game
    attr_accessor :name
    attr_reader :current_color
    include MoveValidator

    def initialize
      @board = Board.new
      @board.set_default
      @current_color = :white
      @last_piece = nil
      @name = nil
      @promotion_coord = false
    end

    ##
    # Accepts the move string in algebraic notation, e.g. "e2e4",
    # and applies it to the board.
    # Raises InvalidMove if:
    # * Game is already over
    # * Pawn promotion should be executed first
    # * Empty square is chosen
    # * Player tries to move piece of the opponent
    # * Move is invalid (checks via the MoveValidator module)
    # * Move is fatal (king is attacked after the move)
    #
    # After successfull move, the method changes the current player or
    # goes into "A pawn needs promotion" state, which can be checked by
    # #needs_promotion? method

    def move(string)
      from, to = Game.string_to_coords(string)
      piece = @board.at(from)
      raise InvalidMove, "Game is over" if over?
      raise InvalidMove, "#{@current_color} player should execute pawn promotion first" if needs_promotion?
      raise InvalidMove, "Empty square is chosen" if piece.nil?
      raise InvalidMove, "This is not your piece" unless piece.color == @current_color
      raise InvalidMove, "Invalid move" unless valid_moves(from).include?(to)
      move = Move.new(@board, from, to)
      move.commit
      if king_attacked?
        move.rollback
        raise InvalidMove, "Fatal move"
      end

      @last_piece = piece
      piece.moves_count += 1
      @promotion_coord = to and return if piece.pawn? && [7, 0].include?(to[1])
      next_player
    end

    ##
    # Returns a piece (or nil if the square is empty) at given coordinates
    # === Example
    #   g = Game.new
    #   g["e2"] #=> <Pawn ...>
    #   g["e4"] #=> nil

    def [](str)
      letters = ("a".."h").to_a
      return nil unless /[a-h][1-8]/.match?(str)
      @board.at([letters.find_index(str[0]), str[1].to_i - 1])
    end

    ##
    # Returns the board in the nice-looking string

    def draw
      @board.to_s
    end

    ##
    # Accepts a string with name of the piece.
    # Promotes a pawn and changes the current player.
    # Raises InvalidMove if promotion is not needed or invalid +class_name+
    # has been passed
    # === Example
    #   game.promotion("queen")

    def promotion(class_name)
      unless needs_promotion? && ["rook", "knight", "elephant", "queen"].include?(class_name.downcase)
        raise InvalidMove, "Invalid promotion"
      end
      @board.set_at(@promotion_coord, Module.const_get("ChessEngine::#{class_name.capitalize}").new(@current_color))
      @promotion_coord = nil
      next_player
    end

    ##
    # Accepts a +length+ sybmol :short or :long. Ensures that castling is
    # possible and commits appropriate moves. Otherwise, raises InvalidMove

    def castling(length)
      row = @current_color == :white ? 0 : 7
      king = @board.at([4, row])
      if length == :short
        rook = @board.at([7, row])
        line = [5, 6]
        moves = [Move.new(@board, [4, row], [6, row]),
          Move.new(@board, [7, row], [5, row])]
      else
        rook = @board.at([0, row])
        line = [1, 2, 3]
        moves = [Move.new(@board, [4, row], [2, row]),
          Move.new(@board, [0, row], [3, row])]
      end
      raise InvalidMove, "Invalid castling" unless
        king && rook && king.moves_count == 0 && rook.moves_count == 0 &&
        line.all? { |x| @board.at([x, row]).nil? }

      moves.each { |move| move.commit }
      if king_attacked?
        moves.each { |move| move.rollback }
        raise InvalidMove, "Fatal move"
      end
      @last_piece = nil
      next_player
    end

    ##
    # Returns true if game is over

    def over?
      @board.piece_coordinates(@current_color).all? do |coord|
        safe_moves(coord).empty?
      end
    end

    ##
    # Checks if pawn promotion is needed

    def needs_promotion?
      !!@promotion_coord
    end

    ##
    # Returns true if current king is attacked

    def check?
      king_attacked?
    end

    private

    def king_attacked?
      king_coords = @board.king_coords(@current_color)
      [[1, 1], [-1, 1], [-1, -1], [1, -1]].each do |move|
        next_coords = relative_coords(king_coords, move)
        piece = @board.at(next_coords)
        return true if piece && piece.color != @current_color && (piece.pawn? || piece.king?)
        edge_coords = repeated_move(king_coords, move).last
        piece = edge_coords.nil? ? nil : @board.at(edge_coords)
        return true if piece && piece.beats_diagonally?
      end
      [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |move|
        next_coords = relative_coords(king_coords, move)
        piece = @board.at(next_coords)
        return true if piece && piece.king?
        edge_coords = repeated_move(king_coords, move).last
        piece = edge_coords.nil? ? nil : @board.at(edge_coords)
        return true if !piece.nil? && piece.beats_straight?
      end
      [[1, 2], [2, 1], [1, -2], [-2, 1],
      [-1, 2], [2, -1], [-1, -2], [-2, -1]].each do |move|
        coords = relative_coords(king_coords, move)
        piece = possible_move?(coords) ? @board.at(coords) : nil
        return true if !piece.nil? && piece.knight?
      end
      false
    end

    ##
    # Converts a string in algebraic notation to array of coordinates
    # === Example
    #   Game.string_to_coord("a2a4") #=> [[0, 1], [0, 3]]

    def Game.string_to_coords(string)
      string = string.gsub(/\s+/, "").downcase
      raise InvalidMove, "Input must look like \"e2 e4\" or \"a6b5\"" unless /^[a-h][1-8][a-h][1-8]$/.match?(string)
      letters = ("a".."h").to_a
      [[letters.find_index(string[0]), string[1].to_i - 1],
       [letters.find_index(string[2]), string[3].to_i - 1]]
    end

    def opposite_color
      @current_color == :white ? :black : :white
    end

    def next_player
      @current_color = opposite_color
    end
  end
end
