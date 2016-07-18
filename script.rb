require_relative "lib/hangman.rb"
filename = "5desk.txt"

unless File.exist?(filename)
  puts "Can't find the file! Make sure #{filename} exists in the same directory as hangman.rb"
  exit
end

# Return a random word from the specified file.
def game_word(filename)
  # Count lines in file quickly
  line_count = `wc -l "#{filename}"`.strip.split(' ')[0].to_i
  word_bank = File.open(filename, 'r')
  randomizer = Random.new
  random_line = randomizer.rand(line_count)

  # Loop until the line specified by random_line
  to_guess = nil
  i = 0

  until i == random_line
    to_guess = word_bank.readline.strip
    i += 1
  end

  # If this word isn't the right size we'll go to the next word 
  # until we reach a word that fits
  while to_guess.size < 5 || to_guess.size > 12
    to_guess = word_bank.readline.strip
  end

  word_bank.close
  return to_guess
end

def show_saves
  save = ""
  savedir_ary = Dir.entries("./saves")
  savedir_ary.each { |save| puts save + "\n-----" if save.include?(".sav") }
end

# Game script follows
# Initialize new game
puts "Hello, (s)tart a new Hangman game or (l)oad an existing game?"
input = nil
savedir_ary = Dir.entries("./saves")
until input == "s" || input == "l" do
  input = gets.chomp
  if input == "s"
    game = Hangman.new(game_word(filename))
  elsif input == "l"
    puts "Saved Games:"
    show_saves()
    save_file = nil

    until savedir_ary.include?(save_file) do
      save_file = gets.chomp
      if savedir_ary.include?(save_file)
        game = Hangman.load(save_file)
        puts "Loading #{save_file}........................................."
      else
        puts "Enter a savename that exists!"
      end
    end
  else
    puts "(s) or (l), please."
  end
end

until game.victory? do
  game.game_status
  print "\n"
  print "Guess a letter >> "
  input = gets.chomp
  if input == "quit"
    puts "Leaving game...bye!"
    exit
  elsif input == "save"
    game.save
    exit 
  else
    game.move(input)
  end

  if game.defeat?
    puts "You lost! No lives left!"
    exit
  end
end

puts "You've won!\n\n\n"
game.game_status
