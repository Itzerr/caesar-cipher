class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end

  def to_s
    "( #{value} ) -> #{next_node}#{'nil' if next_node.nil? }"
  end
end

class LinkedList
  attr_reader :size, :head, :tail

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(value)
    new_node = Node.new(value)
    if head.nil?
      @head = new_node
      @tail = new_node
      @size = 1
      return
    end

    @size += 1
    tail.next_node = new_node
    @tail = new_node
  end

  def prepend(value)
    @head = Node.new(value, head)
    @size += 1
  end

  def at(index)
    current_node = head
    index.times do |node_index|
      current_node = current_node.next_node
    end
    current_node
  end

  def pop
    current_node = head
    size.times do |index|
      unless index == size - 2
        current_node = current_node.next_node
        next
      end

      current_node.next_node = nil
      @tail = current_node
      @size -= 1
    end
  end

  def contains?(value)
    current_node = head
    size.times do
      return true if current_node.value == value

      current_node = current_node.next_node
    end
    false
  end

  def find(value)
    current_node = head
    size.times do |index|
      return index if current_node.value == value
      current_node = current_node.next_node
    end
    nil
  end

  def to_s
    head.to_s
  end

  def insert_at(value, index)
    current_node = head
    index.times do |node_index|
      if node_index + 1 == index
        next_node = current_node.next_node
        current_node.next_node = Node.new(value, next_node)
        return
      end

      current_node = current_node.next_node
    end
  end

  def remove_at(index)
    current_node = head
    index.times do |node_index|
      if node_index + 1 == index
        next_node = current_node.next_node
        current_node.next_node = next_node.next_node
        @size -= 1
      end

      current_node = current_node.next_node
    end
  end
end

random_numbers = Array.new(6) { rand(100) }

linked_list = LinkedList.new
random_numbers.each { |number| linked_list.append(number) }

puts 'Initial:'
puts linked_list
puts 'Prepand(10)'
linked_list.prepend(10)
puts linked_list
puts "Size: #{linked_list.size}"
puts "Head: #{linked_list.head.value}"
puts "Tail: #{linked_list.tail.value}"
puts "At 3: #{linked_list.at(3).value}"
puts 'Pop:'
linked_list.pop
puts linked_list
puts "Contains?(-1): #{linked_list.contains?(-1)}"
puts "Find(-1): #{linked_list.find(-1)}"
puts 'Insert_at(101, 3):'
linked_list.insert_at(101, 3)
puts linked_list
puts 'Remove_at(3)'
linked_list.remove_at(3)
puts linked_list
