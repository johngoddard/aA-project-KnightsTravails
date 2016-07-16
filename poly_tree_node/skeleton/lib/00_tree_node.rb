class PolyTreeNode
  attr_reader :parent, :value
  attr_accessor :children

  def initialize(value)
    @parent = nil
    @value = value
    @children = []
  end

  def parent=(node)
    delete_children(@parent) unless parent.nil?
    node.add_child(self) unless node.nil?
    @parent = node
  end

  def delete_children(parent)
    parent.children.delete(self)
  end

  def add_child(child_node)
    unless @children.include?(child_node)
      @children << child_node
      child_node.parent = self unless child_node.parent == self
    end
  end

  def remove_child(child)
    raise unless @children.include?(child)

    @children.delete(child)
    child.parent = nil
  end

  def dfs(target_value)
    return self if @value == target_value

    @children.each do |child|
      search_result = child.dfs(target_value)
      return search_result unless search_result.nil?
    end

    return nil
  end

  def bfs(target_value)
    return self if self.value == target_value
    queue = [self]

    until queue.empty?
      current = queue.shift
      
      current.children.each do |child|
        return child if child.value == target_value
        queue << child
      end
    end

    return nil
  end

end
