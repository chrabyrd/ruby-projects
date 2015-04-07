def bubble_sort(array)
	x = 0; y = 1
	array.length.times do
		(array.length - 1).times do
			array[x..y]
			if array[x] > array[y]
				array[y], array[x] = array[x], array[y]
			end
			x += 1
			y += 1
		end
		x = 0; y = 1
	end
	print array
end

def bubble_sort_by(array, &block)
	x = 0; y = 1
	array.length.times do
		(array.length - 1).times do
			array[x..y]
			if yield(array[x], array[y]) < 0
				array[y], array[x] = array[x], array[y]
			end
			x += 1
			y += 1
		end
		x = 0; y = 1
	end

	print array

end

bubble_sort([4,3,78,2,0,2])
bubble_sort([22,66,4,44,5,7,392,22,8,77,33,118,99,6,1,62,29,14,139,2])

bubble_sort_by(["hi", "hello", "hey"]) { |left, right| right.length - left.length }