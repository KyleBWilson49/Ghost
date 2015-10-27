require_relative "dictionary.txt"

class Ghost
  attr_reader :player1, :player2, :fragment, :current_player, :previous_player, :dictionary

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @fragment
    @dictionary = File.readlines('dictionary.txt') { |line| line.chomp }
    @current_player = player1
    @previous_player = player2
  end

  def play_round
    take_turn(@current_player)
    next_player!
  end

  def play
  end

  def next_player!
    @current_player, @previous_player = @previous_player, @current_player
  end

  def take_turn(player)
  end

  def valid_play(string)
    @dictionary.each do |word|
      return true if word[0..string.length - 1] == string
    end
    false
  end
end
