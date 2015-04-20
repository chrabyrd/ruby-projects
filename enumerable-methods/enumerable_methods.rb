module Enumerable
	def my_each
		return self unless block_given?
		self.length.times { |n| yield(self[n]) }
	end

	def my_each_with_index
		return self unless block_given?
		x = 0
		self.length.times do |n| 
			yield(self[n], x)
			x += 1
		end
	end

	def my_select
		return self unless block_given?
		ary = []
		self.my_each { |x| ary.push x if yield(x) == true }
		return ary
	end

	def my_all?
		n = true
		if block_given?
			self.my_each { |x| n = false if yield(x) == false && yield(x) == nil }
		else
			self.my_each { |x| n = false if x == false && x == nil }
		end
		return n
	end

	def my_any?
		n = false
		if block_given?
			self.my_each { |x| n = true if yield(x) != false && yield(x) != nil }
		else
			self.my_each { |x| n = true if x != false && x != nil }
		end
		return n
	end

	def my_none?
		n = true
		if block_given?
			self.my_each { |x| n = false if yield(x) != false && yield(x) != nil }
		else
			self.my_each { |x| n = false if x != false && x != nil }
		end
		return n
	end

	def my_count(n = nil)
		count = 0
		if n != nil
			self.my_each { |x| count += 1 if x == n }
		elsif block_given?
			self.my_each { |x| count += 1 if yield(x) == true }
		else
			self.my_each { |x| count += 1 }
		end
		return count
	end

	def my_map
		return self unless block_given?
		ary = []
		self.my_each { |x| ary.push yield(x) }
		return ary
	end

	def my_inject(n = nil)
		accumulator = n
		self.my_each { |x| accumulator = yield(accumulator, x) }
		return accumulator
	end

#to test my_inject with an implicit block
	def multiply_els(ary = nil)
		return self.my_inject(1) { |product, x| product * x }
	end
end

array = [10, 2, 3, 4]

#puts array.my_each { |x| x + 2 }
#puts array.my_each_with_index { |x, y| x + 2, y }
#puts new_ary = array.my_select { |x| x.even? }
#puts array.my_all? { |x| x.even? }
#puts array.my_all?
#puts array.my_any? { |x| x.odd? }
#puts array.my_any?
#puts array.my_none? { |x| x.odd? }
#puts array.my_none?
#puts array.my_count
#puts array.my_count(2)
#puts array.my_count { |x| x.even? }
#puts array.my_map { |x| x + 2 }
#puts array.my_inject(0) { |sum, x| sum + x }
#puts array.multiply_els