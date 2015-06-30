require 'yaml'

class Computer
	attr_accessor :spaces, :word

	def initialize
		choose_word
		word_spaces
	end

	def choose_word
		dictionary = File.open("5desk.txt") 
		ary = dictionary.to_a
		word_list = ary.select { |word| word.length > 5 && word.length < 12 }
		word = word_list.sample.rstrip
		word = word.upcase
		@word = word.split('')
	end

	def word_spaces
		@spaces = Array.new(@word.length, "_")
	end

end

class Player

	def guess
		input = gets.chomp.upcase
		until input == "SAVE" || input.length == 1 && input =~ /[A-Z]/
			puts "Sorry, invalid entry. Try again"
			input = gets.chomp.upcase
		end
		@guess = input
	end

end

class Game

	def initialize(computer, player)
		@computer = computer
		@player = player
		@bad_letters = []
		opener
		hangman_logic
		display
	end

	def load_state?
		if File.exist?('save.txt')
			puts "\r\nWould you like to load your saved game? Y = Yes, N = No"
			load = gets.chomp.upcase
			until load == "Y" || load == "N"
				puts "Sorry, invalid entry. Try again."
				load = gets.chomp.upcase
			end
			if load == "Y"
				array = File.open('save.txt', 'r'){ |input| YAML.load(input) }
				@computer.word = array[0]
				@bad_letters = array[1]
				@computer.spaces = array[2]
				File.delete('save.txt')
			end
		end
	end

	def save_state?
		save_data = [@computer.word, @bad_letters, @computer.spaces]
		if @input == "SAVE"
			File.open("save.txt", "w") do |data|
				data.print YAML::dump(save_data)
			end
			puts "Game saved!"
			exit
		end
	end

	def opener
		puts "\r\nHello, and welcome to Hangman! Find the secret word, but don't kill the little man."
		load_state?
		puts "\r\nYou can type \"save\" at any time to save your progress!"
	end

	def display
		print "          #{@computer.spaces.join(" ")}"
		print "     Incorrect Letters: |#{@bad_letters.join(", ")}|"
		print "     Your Input: "
	end

	def bad_letters
		@bad_letters << @input if @computer.word.include?(@input) == false && @bad_letters.include?(@input) == false && @input != "SAVE"
	end

	def match?
		@computer.word.each_with_index { |letter, index| @computer.spaces[index] = letter if letter == @input }
	end

	def logic
		@input = @player.guess
		save_state?
		match?
		bad_letters
	  hangman_logic
	  display
	end

	def hangman
		@line_0 = "\r\n  ____"
		@line_1 = "\r\n |    |"
		@line_2 = "\r\n |"
		@line_3 = "\r\n |"
		@line_4 = "\r\n |"
		@line_5 = "\r\n |"
		@line_6 = "\r\n"
	end

	def hangman_logic
		hangman
		@line_2 = "\r\n |    O" if @bad_letters.length >= 1
		@line_3 = "\r\n |    |" && @line_4 = "\r\n |    |" if @bad_letters.length >= 2
		@line_3 = "\r\n |   \\|" if @bad_letters.length >= 3
		@line_3 = "\r\n |   \\|/" if @bad_letters.length >= 4
		@line_5 = "\r\n |   /" if @bad_letters.length >= 5
		@line_5 = "\r\n |   / \\" if @bad_letters.length == 6

		print "#{@line_0}#{@line_1}#{@line_2}#{@line_3}#{@line_4}#{@line_5}#{@line_6}" 
	end

	def endgame?
		if @computer.spaces == @computer.word
			puts "\r\n\r\nYou Win!"
			exit
		elsif @bad_letters.length == 6
			puts "\r\n\r\nYou Lose! He's dead and it's all your fault. Shame on you!"
			puts "The word was #{@computer.word.join}!"
			exit
		end
	end

	def play
		until endgame?
			logic
		end
	end

end

game = Game.new(Computer.new, Player.new)

game.play