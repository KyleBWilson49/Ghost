require 'byebug'
require_relative 'player'

class Ghost
  attr_reader :player1, :player2, :fragment, :current_player, :previous_player, :dictionary

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @fragment = ""
    @dictionary = File.readlines('dictionary.txt').map(&:chomp)
    @current_player = player1
    @previous_player = player2
  end

  def play_round
    puts "The current fragment is: #{@fragment}"
    take_turn
    next_player!
  end

  def play
    # debugger
    play_round until game_over?
  end

  def game_over?
    @dictionary.include?(@fragment)
  end

  def next_player!
    @current_player, @previous_player = @previous_player, @current_player
  end

  def take_turn
    #debugger
    player_guess = @current_player.guess
    until valid_play?(player_guess)
      take_turn
    end
    @fragment << player_guess
  end

  def valid_play?(string)
    guess = @fragment + string
    @dictionary.each do |word|
      return true if word[0...guess.length] == guess
    end
    false
  end
end

if __FILE__ == $PROGRAM_NAME
  jane = Player.new('jane')
  fred = Player.new('fred')
  game = Ghost.new(jane, fred)
  game.play
end
