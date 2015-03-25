# This is a Caesar cipher that preserves capitalization, punctuation, and inputted numbers!

def convert_to_integer
    puts "What would you like to encode?"
    words = gets.chomp

    letters = words.split("")
   	integer = letters.map! { |letter| 
   		if letter =~ /[A-Za-z]/
    		letter.gsub(/[A-Za-z]/, 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4, 'f' => 5, 'g' => 6, 'h' => 7, 'i' => 8, 'j' => 9, 'k' => 10, 'l' => 11, 'm' => 12, 'n' => 13, 'o' => 14, 'p' => 15, 'q' => 16, 'r' => 17, 's' => 18, 't' => 19, 'u' => 20, 'v' => 21, 'w' => 22, 'x' => 23, 'y' => 24, 'z' => 25, 'A' => 100, 'B' => 101, 'C' => 102, 'D' => 103, 'E' => 104, 'F' => 105, 'G' => 106, 'H' => 107, 'I' => 108, 'J' => 109, 'K' => 110, 'L' => 111, 'M' => 112, 'N' => 113, 'O' => 114, 'P' => 115, 'Q' => 116, 'R' => 117, 'S' => 118, 'T' => 119, 'U' => 120, 'V' => 121, 'W' => 122, 'X' => 123, 'Y' => 124, 'Z' => 125).to_i
   		else
   			letter
   		end
    }
    
    return integer
end

def shift_left(integer, number = 0)
	puts "How many letters (to the left) would you like to shift it?"
	number = gets.to_i
		while number > 26 
			puts "Why would you shift that much? The alphabet's only 26 letters long!"
			number = gets.to_i
		end


	integer.map! {|x| 
		if x.is_a? Integer
			x - number
		else
			x
		end
	}

	return integer
end

def convert_to_letter(integer)
	replacements = { -26 => 'a', -25 => 'b', -24 => 'c', -23 => 'd', -22 => 'e', -21 => 'f', -20 => 'g', -19 => 'h', -18 => 'i', -17 => 'j', -16 => 'k', -15 => 'l', -14 => 'm', -13 => 'n', -12 => 'o', -11 => 'p', -10 => 'q', -9 => 'r', -8 => 's', -7 => 't', -6 => 'u', -5 => 'v', -4 => 'w', -3 => 'x', -2 => 'y', -1 => 'z', 0 => 'a', 1 => 'b', 2 => 'c', 3 => 'd', 4 => 'e', 5 => 'f', 6 => 'g', 7 => 'h', 8 => 'i', 9 => 'j', 10 => 'k', 11 => 'l', 12 => 'm', 13 => 'n', 14 => 'o', 15 => 'p', 16 => 'q', 17 => 'r', 18 => 's', 19 => 't', 20 => 'u', 21 => 'v', 22 => 'w', 23 => 'x', 24 => 'y', 25 => 'z', 74 => 'A', 75 => 'B', 76 => 'C', 77 => 'D', 78 => 'E', 79 => 'F', 80 => 'G', 81 => 'H', 82 => 'I', 83 => 'J', 84 => 'K', 85 => 'L', 86 => 'M', 87 => 'N', 88 => 'O', 89 => 'P', 90 => 'Q', 91 => 'R', 92 => 'S', 93 => 'T', 94 => 'U', 95 => 'V', 96 => 'W', 97 => 'X', 98 => 'Y', 99 => 'Z', 100 => 'A', 101 => 'B', 102 => 'C', 103 => 'D', 104 => 'E', 105 => 'F', 106 => 'G', 107 => 'H', 108 => 'I', 109 => 'J', 110 => 'K', 111 => 'L', 112 => 'M', 113 => 'N', 114 => 'O', 115 => 'P', 116 => 'Q', 117 => 'R', 118 => 'S', 119 => 'T', 120 => 'U', 121 => 'V', 122 => 'W', 123 => 'X', 124 => 'Y', 125 => 'Z'
	}
	new_words = integer.map! {|x|
		if x.is_a? Integer
			replacements[x]
		else
			x
		end
	}.join

	print new_words
end

convert_to_letter(shift_left(convert_to_integer))
