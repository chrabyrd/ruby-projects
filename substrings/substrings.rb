dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(words, dictionary)
	x = 0; y = 0
	ary = words.downcase.delete(" ").split("")
	hash = []
	ary.length.times do
		until y == ary.length do
			new_ary = ary[x..y].join
			y += 1
			if dictionary.include?(new_ary) == true
				hash.push new_ary
			end
		end
		y = x + 1
		x += 1
	end
	print hash.map! { |x| [x, hash.count(x)]}.sort.to_h
end


substrings("Howdy partner, sit down! How's it going?", dictionary)