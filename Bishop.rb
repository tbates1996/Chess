require_relative "Piece.rb"

class Bishop < Piece
	
	def initialize(color)
		super color
		@value = 3
		@char = 'B'
		@moves = [[1,1],[1,-1],[-1,1],[-1,-1]]
	end
end
