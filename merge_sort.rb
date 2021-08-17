def merge_sort(array)
  return array if array.length == 1

  first_half = array[0...array.length / 2]
  last_half = array[array.length / 2..-1]

  left = merge_sort(first_half)
  right = merge_sort(last_half)

  sorted = Array.new(left.length + right.length)
  left_index = 0
  right_index = 0
  sorted.size.times do |i|
    if left_index == left.size
      sorted[i] = right[right_index]
      right_index += 1
    elsif right_index == right.size || left[left_index] < right[right_index]
      sorted[i] = left[left_index]
      left_index += 1
    else
      sorted[i] = right[right_index]
      right_index += 1
    end
  end

  sorted
end

random_numbers = Array.new(12) { rand(100) }
p random_numbers
p merge_sort random_numbers
