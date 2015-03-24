def stock_picker(days)
	x = 0
	sets_of_two = days.permutation(2).to_a
	difference = sets_of_two.map { |a,b| a-b }
	diff_low_to_high = difference.sort
	buy_sell = sets_of_two[difference.index(diff_low_to_high[0])]

	while  days.find_index(buy_sell[0]) > days.find_index(buy_sell[1])
		buy_sell = sets_of_two[difference.index(diff_low_to_high[x])]
		x += 1
	end

	print [days.find_index(buy_sell[0]), days.find_index(buy_sell[1])	
end

stock_picker([17,3,6,9,15,8,6,1,10])
stock_picker([26, 43, 53, 48, 12, 57, 35, 49, 92, 68, 55, 16, 14, 7, 10, 67, 98, 22, 51, 45, 32, 86, 41, 64, 62, 9, 29, 38, 4, 50, 82, 6, 84, 77, 8, 1, 70, 58, 20, 88, 71, 28, 19, 66, 21, 27, 13, 34, 56, 76, 69, 23, 24, 44, 54, 18, 5, 100, 91, 99, 81, 17, 94, 61, 60, 90, 79, 25, 39, 40, 74, 72, 80, 95, 37, 3, 15, 83, 46, 75, 31, 89, 2, 96, 52, 59, 73, 63, 97, 36, 47, 78, 85, 30, 42, 87, 11, 93, 33, 65])