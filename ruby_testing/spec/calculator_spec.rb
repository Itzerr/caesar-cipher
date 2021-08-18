require './lib/calculator'

describe Calculator do
  describe '#add' do
    it 'returns the sum of two numbers' do
      # removed for brevity
    end

    # add this
    it 'returns the sum of more than two numbers' do
      calculator = Calculator.new
      expect(calculator.add(2, 5, 7)).to eql(14)
    end
  end
  describe '#multiply' do
		it 'returns the product of two numbers' do
			calculator = Calculator.new
			expect(calculator.multiply(5, 12)).to eql(60)
		end
  end
  describe '#subtract' do
		it 'returns the difference of two numbers' do
			calculator = Calculator.new
			expect(calculator.subtract(13, 6)).to eql(7)
		end
  end
  describe '#divide' do
		it 'returns the fraction of two numbers' do
			calculator = Calculator.new
			expect(calculator.divide(36, 6)).to eql(6)
		end
  end
end
