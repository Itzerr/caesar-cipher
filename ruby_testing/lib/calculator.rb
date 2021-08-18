class Calculator
    def add(*args)
        args.reduce { |sum, num| sum + num } 
    end

    def multiply(a, b)
        a * b
    end

    def subtract(a, b)
        a - b
    end

    def divide(a, b)
        a / b
    end
end
