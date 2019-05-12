require "./lib/game.rb"
require "./lib/get_input"
require "yaml"

class ChessCLI
  include Input

  def initialize
    begin
      mode = get_input("\nChoose the game mode:\n1. New game\n2. Continue\nEnter your choice (1 or 2): ", /^[12]$/)
      @game = mode == "1" ? Game.new : choose_game
    rescue IncorrectInput => e
      puts "#{e.message}. Try again"
      retry
    end

    play
    save if save?
  end

  def play
    catch(:exit) do
      until @game.over?
        puts "\n#{@game.filename}\n#{@game.draw}"
        declare_check if @game.king_attacked?
        begin
          @game.move(*input_move)
        rescue IncorrectInput => e
          puts "#{e.message}. Try again"
          retry
        end
      end
      game_over
    end
  end

  def choose_game
    saved_names = Dir["./saved_games/*.yaml"].map { |filename| filename[/\.\/saved_games\/(.+)\.yaml/, 1] }
    raise IncorrectInput, "You have no saved games" if saved_names.empty?
    puts "\nSaved games (#{saved_names.size}):"
    saved_names.each { |name| puts name }
    filename = get_input("Enter the name of the game that you want to continue: ",
      nil, "Such game doesn't exist, try again") { |input| saved_names.include?(input) }
    return YAML::load(File.read("./saved_games/#{filename}.yaml"))
  end

  def save?
    return false if @game.filename && File.exists?("./saved_games/#{@game.filename}.yaml") &&
                    YAML::dump(@game) == File.read("./saved_games/#{@game.filename}.yaml")
    choice = get_input("Do you want to save the game? (y/n): ", /^[yn]$/i)
    choice == "y" ? true : false
  end

  def save
    @game.filename ||= get_input("Enter the game name: ", /[^\/\>\<\|\:\&]+/)
    game = YAML::dump(@game)
    File.open("./saved_games/#{@game.filename}.yaml", "w") { |file| file.write(game) }
  end

  def declare_check
    puts "#{@game.current_color.to_s.capitalize} player is given a check"
  end

  def declare_checkmate
    puts "#{@game.current_color.to_s.capitalize} player got mated!"
  end

  def game_over
    puts @game.draw
    if @game.king_attacked?
      declare_checkmate
    else
      puts "Stalemate!"
    end
  end

  COLUMN_LETTERS = ["a", "b", "c", "d", "e", "f", "g", "h"]

  def input_move
    print "#{@game.current_color.to_s.capitalize}'s move (e. g. \"e2e4\" or \"exit\"): "
    input = gets.chomp
    throw :exit if /exit/i.match?(input)
    return input
  end

  def input_promotion
    puts "Pawn promotion. Choose the new piece:\n1. Queen\n2. Rook\n3. Knight\n4. Elephant"
    input = gets.strip
    raise IncorrectInput, "Input must be a single digit" unless /^[1-4]$/.match?(input)
    input.to_i
  end
end

ChessCLI.new
