def fibonacci(n)
  arr = []
  fib = 1
  prev_fib = 0
  n.times do |number|
    if number == 0
      arr << 1
      next
    end
    temp_fib = prev_fib
    prev_fib = fib
    fib += temp_fib
    arr << fib
  end
  arr
end

def fibonacci_recursive(n)
  return [1] if n == 1
  return [1, 1] if n == 2

  fibonacci_recursive(n - 1) << fibonacci_recursive(n - 1)[-1] + fibonacci_recursive(n - 1)[-2]
end

# p fibonacci(100).last
p fibonacci_recursive(15)
