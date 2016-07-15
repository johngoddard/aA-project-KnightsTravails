require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    current_node = TicTacToeNode.new(game.board, mark)

    child_nodes = current_node.children

    child_nodes.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
    end

    child_nodes.each do |child|
      return child.prev_move_pos unless child.losing_node?(mark)
    end

    raise
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
