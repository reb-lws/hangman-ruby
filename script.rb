require_relative "lib/hangman.rb"

filename = "5desk.txt"

unless File.exist?(filename)
  puts "Can't find the file! Make sure #{filename} exists in the same directory as hangman.rb"
  exit
end

# Count lines in file quickly
line_count = `wc -l "#{filename}"`.strip.split(' ')[0].to_i

# PUT ALL THIS IN A FILE LATER
word_bank = File.open(filename, 'r')
randomizer = Random.new
random_line = randomizer.rand(line_count)

#
# Loop until the line specified by random_line
to_guess = nil
i = 0

until i == random_line
  to_guess = word_bank.readline.strip
  i += 1
end

# If this word isn't the right size we'll go next until we reach a word that fits
while to_guess.size < 5 || to_guess.size > 12
  to_guess = word_bank.readline.strip
end

word_bank.close
# Word is picked now and is under to_guess

