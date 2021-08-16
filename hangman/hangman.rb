require 'json'

module JSONable
  def to_json
      hash = {}
      self.instance_variables.each do |var|
          hash[var] = self.instance_variable_get var
      end
      hash.to_json
  end
  def from_json! string
      JSON.load(string).each do |var, val|
          self.instance_variable_set var, val
      end
  end
end


words = File.readlines('5desk.txt', chomp: true)
words = words.select { |word| word.length.between?(5, 12) }

class Hangman
  include JSONable
  def initialize(words)
    @remaining_guesses = 9
    @secret_word = words.sample.downcase
    @visible_word = @secret_word.gsub(/./, '_')
    @incorrect_guesses = []
    @correct_guesses = []
  end

  private

  def print_visible_word
    puts "Secret Word: #{@visible_word.capitalize}"
  end

  def print_remaining_guesses
    puts "Remaining Guesses: #{@remaining_guesses}"
  end

  def print_invalid_guess
    puts 'Invalid Guess!'
  end

  def print_incorrect_guesses
    puts "Incorrect Guesses: #{@incorrect_guesses.join(', ')}"
  end

  def print_correct_guesses
    puts "Correct Guesses: #{@correct_guesses.join(', ')}"
  end

  def invalid_guess?(guess)
    guess.length != 1 ||
     @correct_guesses.include?(guess) ||
      @incorrect_guesses.include?(guess)
  end

  def correct_guess?(guess)
    correct = @secret_word.include? guess
    if correct
      @correct_guesses << guess
    else
      @incorrect_guesses << guess
    end
    correct
  end

  def guess_indices(guess)
    @secret_word.split('').each_with_index.reduce([]) do |indices, (char, index)|
      indices.push(index) if char == guess
      indices
    end
  end

  def add_guess_to_visible_word(guess)
    indices = guess_indices(guess)
    @secret_word.length.times do |index|
        @visible_word[index] = guess if indices.include?(index)
    end
  end

  def print_divider
    puts '--------------------------'
  end

  def print_thick_divider
    puts "=========================="
  end

  def game_ended?
    @remaining_guesses == 0 || !@visible_word.include?('_')
  end

  def player_won?
    !@visible_word.include?('_')
  end

  def print_game_ended
    puts ''
    print_thick_divider
    puts "Secret Word was: #{@secret_word.capitalize}"
    if player_won?
      puts "You Won! Remaining Guesses: #{@remaining_guesses}"
    else
      puts "You found: #{@visible_word.capitalize}"
      puts "You Lose!"
    end
  end

  def save
    File.write('save.json', self.to_json)
  end

  def load
    if File.exist?('save.json')
      from_json!(File.read('save.json'))
      puts "Loaded game successfully!"
    else
      puts "Can't load: No save file!"
    end
  end

  public

  def play
    print_thick_divider
    puts "type 'save' to save game or 'load' to load game"
    loop do
      print_divider
      print_visible_word
      print_remaining_guesses
      print_correct_guesses
      print_incorrect_guesses
      print 'Your Guess: '
      guess = gets.chomp.downcase
      if guess == "save"
        save
        next
      elsif guess == 'load'
        load
        next
      elsif invalid_guess?(guess)
        print_invalid_guess 
        next
      end
      add_guess_to_visible_word(guess) if correct_guess?(guess)
      @remaining_guesses -= 1
      if game_ended?
        print_game_ended
        return
      end
    end
  end
end

game = Hangman.new(words)
game.play
