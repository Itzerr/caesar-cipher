class Node
  attr_reader :pos, :parent

  def initialize(pos, parent = nil)
    @pos = pos
    @parent = parent
  end

  def within_board(pos)
    pos[0].between?(0, 7) && pos[1].between?(0, 7)
  end

  def available_moves
    moves = [[-1, 2], [1, 2], [-2, 1], [2, 1], [-2, -1], [2, -1], [-1, -2], [1, -2]]
    moves.each_with_object([]) do |move, possible_moves|
      next_pos = [pos[0] + move[0], pos[1] + move[1]]
      possible_moves << Node.new(next_pos, self) if within_board(next_pos)
    end
  end

  def history(node = self)
    return [node.pos] unless node.parent

    history(node.parent) << node.pos
  end
end

class GameBoard
  private


  public

  def knight_moves(start_pos, end_pos)
    moves_queue = []
    current_move = Node.new(start_pos)
    until current_move.pos == end_pos
      moves_queue.push *current_move.available_moves

      current_move = moves_queue.shift
    end

    history = current_move.history
    puts "You've made it in #{history.size - 1} moves! Here's your path: "
    p history
  end
end

game_board = GameBoard.new

game_board.knight_moves([3, 3], [4, 3])
