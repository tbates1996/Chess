require_relative 'Piece.rb'

class Pawn < Piece
	
	def initialize color
		super color
		@char = 'P'
		@value = 1
		@moves = [[1,0], [1,-1],[1,1],[2,0]]
	end

end
