def stock_picker(stock_prices)
	lowest = stock_prices.find_index(stock_prices.max)
	highest = stock_prices.find_index(stock_prices.min)
	best_days = [0, 0]
	highest_diff = lowest - highest
	stock_prices[0..-2].each_with_index do |buy_price, buy_day|
		stock_prices[buy_day+1..-1].each.with_index(buy_day+1) do |sell_price, sell_day|
			diff = sell_price - buy_price
			#p sell_day
			if diff > highest_diff
				highest_diff = diff
				best_days = [buy_day, sell_day]
			end
		end
		#p "buy:#{buy} sell: #{sell} diff: #{sell - buy} biggest_diff: #{biggest_diff}"
	end
	best_days
end

random_prices = Array.new(10) {rand(30..60)}
p random_prices
best_days = stock_picker(random_prices)
buy_price = random_prices[best_days[0]]
sell_price = random_prices[best_days[1]]
puts "Buy Day: #{best_days[0]}"
puts "Sell Day: #{best_days[1]}"
puts "Buy Price: #{buy_price}"
puts "Sell Price: #{sell_price}"