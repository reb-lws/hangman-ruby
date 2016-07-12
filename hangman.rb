filename = "5desk.txt"

unless File.exist?(filename)
  puts "Can't find the file!"
end

# count lines in file quickly
line_count = `wc -l "#{filename}"`.strip.split(' ')[0].to_i
word_bank = File.open(filename, 'r')

randomizer = Random.new
random_line = randomizer.rand(line_count)
puts "Choosing line #{random_line}"

# Loop until the line specified by random_line
to_guess = nil
i = 0

until i == random_line
  to_guess = word_bank.readline.strip
  i += 1
end

word_bank.close

#puts "Word is #{to_guess.upcase}!"