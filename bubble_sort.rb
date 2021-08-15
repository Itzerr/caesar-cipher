def bubble_sort(array)
    array.each_index do |i|
        array.each.with_index do |old_value, index|
            if index == 0
                next
            end
            value = array[index]
            prev_value = array[index-1]
            if (value < prev_value)
                array[index] = prev_value
                array[index-1] = value
            end
        end
    end
    array
end

random_numbers = Array.new(16) { rand(10) }
puts "Starting Array"
p random_numbers
puts "Sorted Array"
p bubble_sort(random_numbers)