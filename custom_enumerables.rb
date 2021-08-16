module Enumerable
  def my_each(&block)
    each(&block)
  end

  def my_each_with_index
    length.times do |index|
      yield(self[index], index)
    end
  end

  def my_select
    result = []
    my_each do |value|
      result << value if yield value
    end
    result
  end

  def my_all?
    my_each do |value|
      return false unless yield(value)
    end
    true
  end

  def my_any?
    my_each do |value|
      return true if yield(value)
    end
    false
  end

  def my_none?
    my_each do |value|
      return false if yield(value)
    end
    true
  end

  def my_count?(*args)
    if block_given?
      my_select { |element| yield(element) }.length
    elsif args.size.zero?
      length
    else
      my_select { |element| element == args.first }.length 
    end
  end

  def my_map
    map = []
    my_each do |value|
      map << yield(value)
    end
    map
  end

  def my_reduce(initial = nil)
    result = initial
    my_each do |value|
      result = yield(result, value)
    end
    result
  end

  def my_reduce_proc(reduce_proc, initial = nil)
    result = initial
    my_each do |value|
      result = reduce_proc.call(result, value)
    end
    result
  end
end

numbers = [1, 2, 3, 4, 5]
others = [1, 1, 2, 2, 3, 3, 3]
# puts "each:"
# numbers.each  { |item| puts item }
# puts "my_each:"
# numbers.my_each  { |item| puts item }

# puts "each_with_index:"
# numbers.each_with_index  { |item, index| puts "#{index} #{item}" }
# puts "my_each_with_index:"
# numbers.my_each_with_index  { |item, index| puts "#{index} #{item}" }

# puts "select:"
# p numbers.select  { |item| item.odd? }
# puts "my_select:"
# p numbers.my_select  { |item| item.odd? }

# puts "all?:"
# p numbers.all?  { |item| item.between?(2, 5) }
# puts "my_all?:"
# p numbers.my_all?  { |item| item.between?(2, 5) }

# p others
# p others.any? { |item| item == 1 }
# p others.any? { |item| item > 3 }
# p others.any? { |item| item < 3 }
# p others.any? { |item| item == 3 }

# p others
# p others.none? { |item| item == 1 }

# p others
# p others.my_count?
# p others.my_count?(1)
# p others.my_count? { |item| item < 3 }

# p others
# p others.my_map { |value| value*value }
# p others.my_map { |value| value+value }

# p others
# p others.my_reduce(0) { |sum, num| sum + num }
# p others.my_reduce(100) { |sum, num| sum + num }
# p others.my_reduce(1) { |sum, num| sum * num }
# p others.my_reduce(0) { |sum, num| sum * num }

# p others
# p others.my_reduce_proc proc { |sum, num| sum + num }, 0
