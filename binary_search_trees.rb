class Node
  include Comparable
  attr_accessor :value, :left, :right

  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end

  def <=>(other)
    value <=> other.value
  end

  def children?
    left || right
  end

  def empty?
    left.nil? && right.nil?
  end

  def to_s(indention = 0)
    if left && right
      "#{' ' * indention}( #{value},\n"\
      "#{left.to_s(indention + 1)},\n"\
      "#{right.to_s(indention + 1)}\n"\
      "#{' ' * indention})"
    elsif left
      "#{' ' * indention}( #{value},\n"\
      "#{left.to_s(indention + 1)},\n"\
      "#{' ' * (indention + 1)}nil\n"\
      "#{' ' * indention})"
    elsif right
      "#{' ' * indention}( #{value},\n"\
      "#{' ' * (indention + 1)}nil\n"\
      "#{right.to_s(indention + 1)},\n"\
      "#{' ' * indention})"
    else
      "#{' ' * indention}( #{value} )"
    end
  end
end

class Tree
  attr :root, :size

  def initialize(array = [])
    return if array.empty?

    sorted_array = array
    @root = build_tree(sorted_array)
    @size = sorted_array.size
  end

  private

  def build_tree(array)
    array = array.uniq.sort
    return nil if array.empty?
    return Node.new(array[0]) if array.length == 1

    mid = (array.length - 1) / 2

    Node.new(array[mid], build_tree(array[0...mid]), build_tree(array[mid + 1..-1]))
  end

  def to_s
    root.to_s
  end

  public

  def insert(value, root = @root)
    @root = Node.new(value) if empty?
    return if value == @root.value

    if root.value > value
      root.left ? insert(value, root.left) : root.left = Node.new(value)
    else
      root.right ? insert(value, root.right) : root.right = Node.new(value)
    end
  end

  def delete(value, root = @root)
    return if empty?

    if root.value > value
      root.left = delete(value, root.left)
    elsif root.value < value
      root.right = delete(value, root.right)
    else
      return root.right if root.left.nil?
      return root.left if root.right.nil?

      next_node = root.right
      smallest_node = next_node
      loop do
        if next_node.left.nil?
          smallest_node = next_node
          break
        end
        next_node = next_node.left
      end

      root.value = smallest_node.value
      root.right = delete(root.value, root.right)
    end

    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    if empty?
      puts 'No root'
      return
    end

    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def empty?
    root.nil?
  end

  def find(value, root = @root)
    return if empty?

    if root.value > value
      return if root.left.nil?

      find(value, root.left)
    elsif root.value < value
      return if root.right.nil?

      find(value, root.right)
    else
      root
    end
  end

  def level_order
    values = []
    discovered = [root]
    next_node = nil
    until discovered.empty?
      next_node = discovered.shift
      discovered << next_node.left if next_node.left
      discovered << next_node.right if next_node.right

      values << next_node.value
    end

    values
  end

  def inorder(root = @root, values=[])
    return if root.nil?

    if root.left
      inorder(root.left, values)
    end

    values << root.value

    if root.right
      inorder(root.right, values)
    end

    values
  end

  def preorder(root = @root, values=[])
    return if root.nil?

    values << root.value

    if root.left
      preorder(root.left, values)
    end

    if root.right
      preorder(root.right, values)
    end

    values
  end

  def postorder(root = @root, values=[])
    return if root.nil?

    if root.left
      postorder(root.left, values)
    end

    if root.right
      postorder(root.right, values)
    end

    values << root.value

    values
  end

  def height(root = @root)
    return 0 if root.nil?

    left_height = height(root.left)
    right_height = height(root.right)

    (left_height > right_height ? left_height : right_height) + 1
  end

  def depth(value, root = @root, depth = 1)
    return if empty?

    if root.value > value
      return if root.left.nil?

      depth(value, root.left, depth + 1)
    elsif root.value < value
      return if root.right.nil?

      depth(value, root.right, depth + 1)
    else
      depth
    end
  end

  def balanced?
    return if empty?

    left_height = height(root&.left)
    right_height = height(root&.right)

    (left_height - right_height).abs <= 1
  end

  def rebalance
    @root = build_tree level_order
  end
end

# tree = Tree.new([1, 3, 5])
# tree.pretty_print
# puts 'Insert 2, 3, 4'
# tree.insert(2)
# tree.insert(3)
# tree.insert(4)
# tree.pretty_print
# puts "Delete 2, 3"
# tree.delete(2)
# tree.delete(3)
# tree.pretty_print
# puts 'Insert 2, 6'
# tree.insert(2)
# tree.insert(6)
# tree.pretty_print
# puts 'Find 2, 6'
# puts tree.find(2)
# puts tree.find(6)
# puts 'Level Order'
# p tree.level_order
# puts 'Inorder'
# p tree.inorder
# puts 'Preorder'
# p tree.preorder
# puts 'Postorder'
# p tree.postorder
# puts 'Height'
# p tree.height
# puts 'Depth 6'
# p tree.depth(6)
# puts 'Balanced?'
# p tree.balanced?

random_numbers = Array.new(15) { rand(1..100) }

bst = Tree.new(random_numbers)
bst.pretty_print
puts "Tree balanced: #{bst.balanced?}"
puts "Level Order: #{bst.level_order}"
puts "Level Preorder: #{bst.preorder}"
puts "Level Postorder: #{bst.postorder}"
puts "Level Inorder: #{bst.inorder}"
puts "Insert 101, 122, 111, 153: #{bst.balanced?}"
bst.insert(101)
bst.insert(122)
bst.insert(111)
bst.insert(153)
puts "Tree balanced: #{bst.balanced?}"
puts "Rebalance"
bst.rebalance
puts "Tree balanced: #{bst.balanced?}"
bst.pretty_print
puts "Level Order: #{bst.level_order}"
puts "Level Preorder: #{bst.preorder}"
puts "Level Postorder: #{bst.postorder}"
puts "Level Inorder: #{bst.inorder}"
