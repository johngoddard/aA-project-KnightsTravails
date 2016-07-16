require_relative './00_tree_node.rb'

class KnightPathFinder

  attr_reader :starting_pos, :visited_positions, :queue

  SIZE = 8
  DELTAS = [[2,1], [2,-1], [-2,1], [-2,-1],
            [-1,2], [1,2], [-1,-2], [1,-2]]

  def initialize(pos)
    @starting_pos = pos
    @visited_positions = [pos]
  end

  def self.valid_moves(pos)
    all_moves = DELTAS.map { |delta| add_pos(delta, pos) }
    all_moves.select {|move| move.all? { |el| el.between?(0, SIZE - 1) } }
  end

  def self.add_pos(pos1, pos2)
    [pos1[0] + pos2[0], pos1[1] + pos2[1]]
  end

  def new_move_positions(pos)
    new_moves = KnightPathFinder.valid_moves(pos).reject do |move|
      @visited_positions.include?(move)
    end

    @visited_positions += new_moves
    new_moves
  end

  def build_move_tree
    queue = [PolyTreeNode.new(@starting_pos)]
    move_tree = []

    until queue.empty?
      curr_node = queue.shift
      move_tree << curr_node

      new_move_positions(curr_node.value).each do |pos|
        new_child = PolyTreeNode.new(pos)
        new_child.parent = curr_node
        queue << new_child
      end
    end
    
    move_tree
  end

  def find_path(target)
    tree = self.build_move_tree
    target_node = tree[0].bfs(target)
    trace_path_back(target_node)
  end

  def trace_path_back(target_node)
    parent = target_node.parent
    path = [target_node.value]

    until parent.nil?
      path << parent.value
      parent = parent.parent
    end

    p path.reverse
  end

end

k = KnightPathFinder.new ([0,0])
k.find_path([7,6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
