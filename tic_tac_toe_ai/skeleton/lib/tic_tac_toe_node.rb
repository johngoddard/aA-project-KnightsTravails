require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      return true if @board.winner == opposite_mark(evaluator)
    elsif evaluator == @next_mover_mark
      return true if children.all? { |child| child.losing_node?(evaluator) }
    else
      return true if children.any? { |child| child.losing_node?(evaluator) }
    end
    false
  end

  def winning_node?(evaluator)
    if @board.over?
      return true if @board.winner == evaluator
    elsif evaluator == @next_mover_mark
      return true if children.any? { |child| child.winning_node?(evaluator) }
    else
      return true if children.all? { |child| child.winning_node?(evaluator) }
    end
    false
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children_array = []
    empty_positions = get_empty_positions

    empty_positions.each do |pos|
      next_turn_board = @board.dup
      next_turn_board[pos] = @next_mover_mark
      children_array << TicTacToeNode.new(next_turn_board,
        opposite_mark(@next_mover_mark), pos)
    end

    children_array
  end

  def opposite_mark(mark)
    mark == :x ? :o : :x
  end

  def get_empty_positions
    empty_positions = []

    (0..2).each do |row|
      (0..2).each do |col|
        empty_positions << [row, col] if @board.empty?([row, col])
      end
    end

    empty_positions
  end
end
