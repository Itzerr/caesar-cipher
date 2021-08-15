class TicTacToe
  def initialize
    @board = Array.new(9, ' ')
    @current_player = 1
  end

  private

  # @param [Numeric] move
  def valid_move?(move)
    move.between?(1, 9) && @board[move - 1] == ' '
  end

  def print_board
    formatted_board = @board.map.with_index { |cell, index| cell == ' ' ? index + 1 : cell }
    puts " #{formatted_board[0]} | #{formatted_board[1]} | #{formatted_board[2]}"
    puts '-----------'
    puts " #{formatted_board[3]} | #{formatted_board[4]} | #{formatted_board[5]}"
    puts '-----------'
    puts " #{formatted_board[6]} | #{formatted_board[7]} | #{formatted_board[8]}"
  end

  def player_won?
    check_rows || check_cols || check_diagonals
  end

  def check_rows
    @board.each_slice(3) do |row|
      return true if row.all? { |char| char == current_player_char }
    end
    false
  end

  def check_cols
    3.times do |start|
      cols = (start..8).step(3).to_a.map { |i| @board[i] }
      return true if cols.all? { |char| char == current_player_char }
    end
    false
  end

  def check_diagonals
    diagonals1 = (0..8).step(4).to_a.map { |i| @board[i] }
    diagonals2 = (2..6).step(2).to_a.map { |i| @board[i] }
    return true if diagonals1.all? { |char| char == current_player_char }
    return true if diagonals2.all? { |char| char == current_player_char }
  end

  def next_player
    @current_player = @current_player == 2 ? 1 : 2
  end

  def current_player_char
    @current_player == 1 ? 'x' : 'o'
  end

  def player_name
    "Player #{@current_player}"
  end

  def print_win
    puts "#{player_name} Wins!"
  end

  public

  def play
    loop do
      print_board
      print "Player #{@current_player}: "
      move = gets.to_i
      if valid_move?(move)
        @board[move - 1] = current_player_char
        if player_won?
          print_board
          print_win
          return
        end
        next_player
      else
        puts 'Invalid move!'
      end
    end
  end
end

game = TicTacToe.new
game.play
