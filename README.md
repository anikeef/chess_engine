# Command Line Chess
This library provides all the rules of the chess game. Also it provides a command line interface with serialization features

### Features:
* You can make all the legal moves, including:
  * Castling
  * En passant
  * Pawn promotion
* The game detects and declares:
  * Check
  * Checkmate
  * Stalemate
* You can quit and save the game at almost every moment

## How to install
To install the game, simply type:
```
gem install chess_engine
```
Then you can try it with `chess_engine` command

## How to use the library
Game is created with:
```
game = ChessEngine::Game.new
```
Then you can do something like this:
```
game.move("e2e4")
# or
game.castling(:long)
```
You can find the full example of using this library in the ChessEngine::CLI#play method in lib/chess_engine/cli.rb

## How to play the CL game
* Start the command line game using `chess_engine` command
* Trivial moves are made by typing in something like "e2e4" or `e3 f5` or even ` a 1 b 3 ` (whitespace doesn't matter)
* Short castling is done by typing in `00`, `oo` or `OO`
* Long castling is done by typing in `000`, `ooo` or `OOO`
* To quit the game, type in "exit". You will be asked to save the game
