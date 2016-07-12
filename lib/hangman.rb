class Hangman
  attr_reader :badguess_ary

  def initialize(target_word)
    @target_word = target_word
    @badguess_ary = []
    @display = []
    target_word.size.times { @display << "_" }
  end

  def display
    @display.join(" ")
  end

  def lives
    life_str = (7 - @badguess_ary.size).to_s
    "#{life_str} tries left."
  end

  def move(guess)
    guess = guess.downcase

    if display.include?(guess)
      puts "You already guessed that!"
    elsif @target_word.include?(guess)
      index_ary = get_index_ary(guess)
      index_ary.each do |i|
        @display[i] = guess
      end
    else
      puts "Bad guess...Sorry!"
      badguess_ary << guess
    end
  end

  def victory?
    @display.include?("_") ? false : true
  end

  private
  # Get all indexes of the occurrence of guess in @target_word
  def get_index_ary(guess)
    ary_target_word = @target_word.split("")
    index_ary = []

    ary_target_word.each_with_index do |letter, index|
      index_ary << index if guess == letter
    end
    index_ary
  end
end