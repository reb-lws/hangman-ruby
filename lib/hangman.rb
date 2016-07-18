require 'yaml'
class Hangman
  attr_reader :badguess_ary, :game_progress

  def initialize(target_word, badguess_ary=[], game_progress=[])
    @target_word = target_word
    @badguess_ary = badguess_ary
    target_word.size.times { game_progress << "_" } if game_progress.empty?
    @game_progress = game_progress
  end

  def game_status
    puts progress_str
    puts "You have #{lives} lives left."
    puts "Bad guesses: #{badguess_str}" unless @badguess_ary.empty? || victory?
  end

  def move(guess)
    guess = guess.downcase
    if verify_input(guess)
      if game_progress.include?(guess)
        puts "You already guessed that!"
      elsif @target_word.include?(guess)
        index_ary = get_index_ary(guess)

        index_ary.each do |i|
          @game_progress[i] = guess
        end
      else
        puts "Bad guess...Sorry!"
        badguess_ary << guess
      end
    else
      puts "That's not a letter!"
    end
  end

  def victory?
    @game_progress.include?("_") ? false : true
  end

  def defeat?
    lives == 0
  end

  def save
    save_num = 1
    savedir_ary = Dir.entries("./saves")
    game_state = Marshal::dump(self)

    while savedir_ary.include?("#{save_num}.sav") do 
      save_num += 1
    end

    save_file = "#{save_num}.sav"
    puts "Saving as #{save_file}"

    File.open("./saves/#{save_file}", "w") { |file| file << game_state }
  end

  # Load a game and return the gameclass from the saves
  def self.load(save_file)
    saved_game = nil
    file_path = "./saves/#{save_file}"
    File.open(file_path) { |f| saved_game = Marshal.load(f) }
    File.delete(file_path)
    return saved_game
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

  def lives
    7 - @badguess_ary.size
  end

  def progress_str
    @game_progress.join(" ")
  end

  def badguess_str
    @badguess_ary.join(", ")
  end

  def verify_input(s)
    s.size == 1 && [*("a".."z")].include?(s) ? true : false
  end

  def load_marshal(save_num)

  end
end