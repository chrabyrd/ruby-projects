class Computer
	attr_reader :code

	def choose_pattern
		ary = ["A","B","C","D","E","F"]
		computer_code = [nil, nil, nil, nil]
		@code = computer_code.map { |letter| letter = ary.sample }
	end
end

class Player
	attr_reader :input, :name

	def initialize
		puts "Hello, do you want to be the (A) Codemaker, or (B) Codebreaker?"
		@name = gets.chomp.upcase
		until @name == "A" || @name == "B"
			puts "That was an incorrect input. Try again."
			@name = gets.chomp.upcase
		end
	end

	def get_input
		ary = gets.chomp.upcase
		ary = ary.split('')
			until ary.all? { |letter| letter =~ /[A-F]/} && ary.length == 4
				puts "That was an incorrect input. Try again."
				ary = gets.chomp.upcase
				ary = ary.split('')
			end
		@input = ary
	end
end

class Game
	def initialize(computer, player)
		@computer = computer
		@player = player
		@computer_code = [nil, nil, nil, nil]
		@ary = [["A","B","C","D","E","F"], ["A","B","C","D","E","F"], ["A","B","C","D","E","F"], ["A","B","C","D","E","F"]]
	end

	def peg_logic
		@player.get_input
		zip_array = @player.input.zip(@computer.code) #black peg logic
		zip_array.delete_if { |array| array.uniq.length == 1 }
		@black_peg = (4 - zip_array.length)

		rotate_count = 0  # white peg logic
		length = zip_array.length
		until zip_array.length == 0 || rotate_count == 3
			player_array = zip_array.transpose[0]
			computer_array = zip_array.transpose[1]
			player_array.rotate!
			zip_array = player_array.zip(computer_array)
			zip_array.delete_if { |array| array.uniq.length == 1 }
			rotate_count += 1
		end
		@white_peg = (length - zip_array.length)
	end
	
	def peg_announce
		if @black_peg == 0 && @white_peg == 0
			puts "You have no pegs!" 
		elsif @black_peg == 1 && @white_peg ==1
			puts "You have 1 black peg and 1 white peg!"
		elsif @black_peg == 1
			puts "You have 1 black peg and #{@white_peg} white pegs!"
		elsif @white_peg == 1
			puts "You have #{@black_peg} black pegs and 1 white peg!"
		else
			puts "You have #{@black_peg} black pegs and #{@white_peg} white pegs!"
		end
	end

	def guess
		new_code = @computer_code.each_index { |index| @computer_code[index] = @ary[index].sample }
		zip_array = @player.input.zip(new_code)
		zip_array.each_with_index do |array, index| 
			if array.uniq.length == 1
				@computer_code[index] = new_code[index] 
			else
				@ary[index].delete(array[1])
			end
		end
		print @computer_code
	end

	def code_maker_logic
		@player.get_input
		12.downto(1) do |x|
			guess
			puts " "
			if @computer_code == @player.input
				puts "You Lose! It took #{13 - x} turns to guess your code."
				exit
			end
		end
		puts "You Win! The computer couldn't guess your code!"
	end

	def code_breaker_logic
		@computer.choose_pattern
		12.downto(1) do |x|
			puts "You have #{x} turn(s) left to guess the code!"
			peg_logic
			if @player.input == @computer.code
				puts "You Win! It took #{13 - x} turns to guess the computer's code."
				exit
			end
			peg_announce unless x == 1
		end
		puts "You Lose! The code was #{@computer.code}"
	end

	def play
		if @player.name == "A"
			puts "Please input a combination of 4 letters, A-F. Case doesn't matter."
			puts "The computer has 12 turns to guess your code!"
			code_maker_logic
		elsif @player.name == "B"
			puts "You have to guess the computer's secret pattern."
			puts "A black peg means that you've put the correct letter in the correct place."
			puts "A white peg means that you've guessed a correct letter, but put it in the wrong place."
			puts "Choose a combination of 4 letters, A-F. Case doesn't matter."
			code_breaker_logic
		end
	end
end

game = Game.new(Computer.new, Player.new)
game.play