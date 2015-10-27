class Player
  def initialize(name)
    @name = name
  end

  def guess
    puts "Enter a letter."
    guess = gets.chomp
  end
end
