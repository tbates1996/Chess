require_relative 'Chessboard.rb'

class Chess
	#create a new board and set current player to white
	def initialize
		@current_color = :white
		@board = ChessBoard.new
	end
	#check to make sure the position is okay for current player
	
	def start
		loop do
			@board.display_board
			puts @current_color.to_s.capitalize
			puts "Check" if check? and !checkmate? 
			if checkmate?
				puts "Checkmate"
				switch_players
				puts "#{@current_color.to_s.capitalize} wins!"
				break
			end


			get_move
			switch_players

		end
	end
	def check?
		@board.check?(@current_color) 
	end
	def checkmate?
		return true if (check? and !(@board.king_has_move?(@current_color)) and !(@board.can_protect_king?(@current_color)))
	end

	def get_move
		copy = Marshal.dump(@board)
		from = get_from
		to = get_to
		until @board.move_to?(from,to)
			from = get_from
			to = get_to
		end
		@board.move(from,to)
		if check?
			puts "You must move out of check"
			@board = Marshal.load(copy)
			get_move
		end
	end

	def get_from
		puts "Enter the piece you want to move:"
		from = gets.chomp.downcase

		if from =~ /[a-h][1-8]/ and verify(parse_input(from))
			return parse_input(from)
		else
			until from =~ /[a-h][1-8]/ and verify(parse_input(from))
				puts "Enter a space with the correct format (eg. e4) and a #{@current_color} piece:"
				from = gets.chomp.downcase
			end
			return parse_input(from)
		end
	end

	def get_to
		puts "Enter the space you want to move to:"
		to = gets.chomp.downcase

		if to =~ /[a-h][1-8]/ 
			return parse_input(to)
		else
			until to =~ /[a-h][1-8]/ 
				puts "Enter a space with the correct format (eg. e4):"
				to = gets.chomp.downcase
			end
			return parse_input(to)
		end
	end

	def verify(position)
		pos = @board.board[position[0]][position[1]]
		if pos.is_a?(Piece) 
			return true if pos.color == @current_color
			return false
		else
			return false
		end
	end

	def parse_input loc
		row = loc[0].ord - 97
		col = loc[1].to_i - 1
		return [row,col]
	end

	#swaps the current players in the game
	def switch_players
		if @current_color == :white
			@current_color = :black
		else 
			@current_color = :white
		end
	end

end
game = Chess.new
game.start
