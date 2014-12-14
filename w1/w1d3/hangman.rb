class Hangman

  attr_reader :guessing_player, :checking_player
  attr_accessor :guess_response

  def initialize(guessing_player, checking_player)
    @guessing_player = guessing_player
    @checking_player = checking_player
  end

  def play
    @guess_response = "_" * checking_player.pick_secret_word.length
    guessing_player.receive_secret_length(guess_response.length)

    while guess_response.include?("_")
      play_turn
    end

    p "You win, #{guessing_player.name}!"
  end

  private

    def play_turn
      guess = guessing_player.guess
      update_guess_response(checking_player.check_guess(guess))
      guessing_player.handle_guess_response(guess_response)
    end

    def update_guess_response(str)
      str.split('').each_index do |i|
        self.guess_response[i] = str[i] if guess_response[i] == "_"
      end.join
    end

end

class HumanPlayer

  attr_reader :name, :secret_word

  def initialize(name)
    @name = name
  end

  def pick_secret_word
    print "Pick a word and give its length: "
    @secret_word = "_" * gets.chomp.to_i
  end

  def receive_secret_length(num)
    p "Secret Word: " + "_" * num
  end

  def guess
    user_guess = gets.chomp
    if user_guess.length != 1 or user_guess.match(/\d/)
      raise "Must enter only one letter (no numbers allowed)"
    else
      user_guess.downcase
    end
  rescue => e
    puts e.message
    retry
  end

  def check_guess(guess)
    p "Guessed letter: #{guess}"
    positions = gets.chomp.split(" ").map { |i| i.to_i - 1 }
    response = ""
    secret_word.length.times do |i|
      if positions.include?(i)
        response << "#{guess}"
      else
        response << "_"
      end
    end
    response
  end

  def handle_guess_response(guess_response)
    p "Secret Word: #{guess_response}"
  end
end

class ComputerPlayer

  attr_reader :secret_word, :letters, :name
  attr_accessor :word_opts

  WORDS = File.readlines("dictionary.txt").map(&:chomp)

  def initialize()
    @name = "Bot#{rand(1..100)}"
    @letters = %w(t a s h w i o b m f c l d p n e g r y u v j k q z x)
  end

  def pick_secret_word
    @secret_word = WORDS.sample
  end

  def receive_secret_length(num)
    @word_opts = WORDS.select { |w| w.length == num }
  end

  def guess
    letter = ""
    letters.each do |l|
      word_opts.each do |word|
        break if word.include?(l)
      end
      letter = l
      break
    end
    letters.delete(letter)
  end

  def check_guess(guess)
    if secret_word.include?(guess)
      secret_word.split('').map do |l|
        l == guess ? l = guess : l = "_"
      end.join
    else
      "_" * secret_word.length
    end
  end

  def handle_guess_response(guess_response)
    p "Secret Word: #{guess_response}"
    template = guess_response.tr("_", ".")

    word_opts.select! { |w| w.match(template) }
  end
end


player1 = HumanPlayer.new("VA")
player2 = ComputerPlayer.new
player3 = ComputerPlayer.new
game = Hangman.new(player1, player3)
game.play
# game = Hangman.new(player2, player1)
# game.play
