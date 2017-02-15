require 'colorize'
require_relative("King.rb")
require_relative("Queen.rb")
require_relative("Rook.rb")
require_relative("Bishop.rb")
require_relative("Knight.rb")
require_relative("Pawn.rb")

class ChessBoard

	attr_accessor :board
	
	def initialize 
		@board = Array.new(8){Array.new(8){"X"}}
		populate_board
	end

	def move_to?(start,finish) #pass coords in the form [row,col]

		row = start[0]
		col = start[1]
		piece = @board[start[0]][start[1]]
		
		piece.moves.each do |dire|
				row = start[0]
				col = start[1]
				distance = 0
			loop do
				if piece.color == :white
					row -= dire[0]
					col -= dire[1]
				elsif piece.color == :black
					row += dire[0]
					col += dire[1]
				end

				if (row < 0 or row > 7) or (col < 0 or col > 7) #out of the bounds of the board
					break
				end

				location = @board[row][col] #set location on the board checking
				distance += 1 #increase the distance
				
				if piece.char == 'P'  
					if [[1,1],[1,-1]].include?(dire) 
						break if !(location.is_a?(Piece)) #Pawns cannot move diag if not taking a piece
					elsif dire == [1,0] or dire == [2,0]
						break if location.is_a?(Piece) #pawns cannot take pieces straight on
					end
				end
				
				if location.is_a?(Piece) # Only pieces of opposite color can be taken
					if location.color == piece.color 
						break   
					elsif row == finish[0] and col == finish[1]
						return true
					else
						break
					end

				end

				if row == finish[0] and col == finish[1]		
					return true
				end

				if ['K','N','P'].include?(piece.char) # These pieces cannot more more than once in their direction
					if distance == 1 
						break
					end
				end
			end
		end
		return false
	end


	def move(start,finish)
		piece = @board[start[0]][start[1]]
		@board[finish[0]][finish[1]] = piece
		@board[start[0]][start[1]] = "X"
		if piece.is_a?(Pawn) and piece.moves.include?([2,0]) #pawns can only move two spaces on first move 
			piece.moves.delete([2,0])
		end
	end
	#Displays the state of the board
	def display_board
		system "clear" or system "cls"
		print "   1 2 3 4 5 6 7 8  \n\n"
		(0..7).each do |row|
			print "#{(row+97).chr}  "
			(0..7).each do |collumn|
				print "#{@board[row][collumn]} " if @board[row][collumn] == "X"
				print @board[row][collumn].to_s + " " if @board[row][collumn].is_a?(Piece)
			end
			print " #{(row+97).chr} "
			puts

		end
		print "\n   1 2 3 4 5 6 7 8  \n"
	end
	def can_protect_king?(color)
		copy_board = Marshal.dump(@board)
		can_protect = false
		#iterate through board to find pieces of the same color
		(0..7).each do |row|
			(0..7).each do |col|
				if @board[row][col].is_a?(Piece) and @board[row][col].color == color
					piece_location = [row,col]
					#check all spots on the board to see if this brings the king out of check
					(0..7).each do |check_row|
						(0..7).each do |check_col|
							check_location = [check_row,check_col]
							if move_to?(piece_location,check_location)
								move(piece_location,check_location)
								if !(check?(color))
									can_protect = true
								end
								@board = Marshal.load(copy_board)
							end

						end
					end
				end
			end
		end
		return can_protect
	end


	def check?(color)
		king = find_king(color)

		(0..7).each do |row|
			(0..7).each do |col|
				location = [row,col]
				if @board[row][col].is_a?(Piece) and move_to?(location, king) and location != king
					return true
				end
			end
		end
		return false
	end

	def king_has_move?(color)
		has_move = false
		location = find_king(color)
		row = location[0]
		col = location[1]
		@board[row][col].moves.each do |king_move|
			row += king_move[0]
			col += king_move[1]
			new_loc = [row,col]
			if move_to?(location,new_loc)
				move(location,new_loc)
				if !(check?(color))
					has_move = true
				end	
				move(new_loc,location)
			end
			row -= king_move[0]
			col -= king_move[1]
		end
		return has_move
	end

	#returns array location of the king
	def find_king(color)
		@board.each_with_index do |row, i|
			row.each_with_index do |collumn, j|
				if collumn.is_a?(King) and collumn.color == color
					return [i,j]
				end
			end
		end
	end



	private

	def populate_board
		(0..7).each{|space| @board[1][space] = Pawn.new(:black); @board[6][space] = Pawn.new(:white)}	

		@board[0][0] = Rook.new(:black)
		@board[0][1] = Knight.new(:black)
		@board[0][2] = Bishop.new(:black)
		@board[0][3] = Queen.new(:black)
		@board[0][4] = King.new(:black)
		@board[0][5] = Bishop.new(:black)
		@board[0][6] = Knight.new(:black)
		@board[0][7] = Rook.new(:black)

		@board[7][0] = Rook.new(:white)
		@board[7][1] = Knight.new(:white)
		@board[7][2] = Bishop.new(:white)
		@board[7][3] = Queen.new(:white)
		@board[7][4] = King.new(:white)
		@board[7][5] = Bishop.new(:white)
		@board[7][6] = Knight.new(:white)
		@board[7][7] = Rook.new(:white)
	end

end

