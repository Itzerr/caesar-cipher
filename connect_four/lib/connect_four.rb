require_relative 'game_board'

class ConnectFour
  attr_reader :board, :players
  def initialize(board = GameBoard.new)
    @board = board
    @players = [ '1', '2' ]
  end

  def current_player
    players[0]
  end

  def next_turn
    @players.rotate!
  end

  def player_input
    print 'Column: '
    Integer(gets.chop, exception: false)
  end

  def valid_input?(input)
    return false if input.nil?
    input.between?(1,7)
  end

  def valid_move?(column)
    board.columns[column - 1][-1] == '0'
  end

  def add_disk(column)
    board.insert_disk(column, current_player)
  end

  def game_ended?
    board.rows.each do |row|
      return true if four_in_row(row)
    end

    board.columns.each do |column|
      return true if four_in_row(column)
    end

    board.diagonals.each do |diagonal|
      return true if four_in_row(diagonal)
    end
    false
  end

  def four_in_row(line)
    return false if line.size < 4

    (line.size - 3).times do |n|
      result = line[n...n + 4].tally.flatten
      return true if result[0] != '0' &&  result[1] == 4
    end
    false
  end

  def play
    loop do
      puts board
      input = nil
      loop do
        input = player_input

        if valid_input?(input)
          break if valid_move?(input)

          puts 'Column is full!'.red
        else
          puts 'Invalid Input!'.red
        end
      end

      add_disk(input)
      if game_ended?
        puts board
        puts " Player #{current_player} has Won!!!".green
        return
      end
      next_turn
    end
  end
end

game = ConnectFour.new
game.play
