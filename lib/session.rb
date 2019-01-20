require "./lib/game.rb"
require "./lib/get_input"
require "yaml"

class Session
  include Input

  def initialize
    begin
      mode = get_input("\nChoose the game mode:\n1. New game\n2. Continue\nEnter your choice (1 or 2): ", /^[12]$/)
      @game = mode == "1" ? Game.new : choose_game
    rescue IncorrectInput => e
      puts "#{e.message}. Try again"
      retry
    end
    
    catch(:exit) do
      @game.play
    end
    save if save?
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
end

Session.new
