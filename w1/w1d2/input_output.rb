def guessing_game
  number = rand(1..100)
  guesses, user_guess = 0, 0
  until user_guess == number
    puts "Guess:"
    user_guess = gets.chomp.to_i
    case user_guess <=> number
    when -1
      puts "TOO LOW!"
    when 0
      puts "You guessed #{user_guess} right in #{guesses} guesses!"
    when 1
      puts "TOO HIGH!"
    end
    guesses += 1
  end
end


def shuffle_file(filename)
  filename = gets.chomp
  lines = File.readlines(filename).shuffle
  File.open("#{ filename }-shuffled.txt", "w") do |f|
    lines.each { |line| f.puts line }
  end
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.length == 1
    shuffle_file(ARGV.shift)
  else
    puts "ENTER FILENAME TO SHUFFLE:"
    filename = gets.chomp
    shuffle_file(filename)
  end
end
