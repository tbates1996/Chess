require_relative "Piece.rb"

class Knight < Piece
	def initialize(color)
		super color
		@value = 3
		@char = 'N'
		@moves = [[2,1],[2,-1],[-2,1],[-2,-1],[1,2],[1,-2],[-1,2],[-1,-2]]
	end
end
