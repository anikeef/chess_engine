# Command Line Chess
This is my final Ruby project before moving to Rails framework. In this PvP game I've tried to apply all the stuff I have learned to this moment.

### Features:
* It works
* You can make all the legal moves, including:
  * Castling
  * En passant
  * Pawn promotion
* The game detects and declares:
  * Check
  * Checkmate
  * Stalemate
* You can quit and save the game at almost every moment

## How to start
Here are the steps you need to make to play this game:
1. Make sure that Ruby is installed on your machine
2. Go to the main directory of the project
3. Type `ruby lib/chess/cli.rb` in your command line

## How to play
* Trivial moves are made by typing in something like "e2e4" or `e3 f5` or even ` a 1 b 3 ` (whitespace doesn't matter)
* Short castling is done by typing in `00`, `oo` or `OO`
* Long castling is done by typing in `000`, `ooo` or `OOO`
* To quit the game, type in "exit". You will be asked to save the game
