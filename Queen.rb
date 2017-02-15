require_relative 'Piece.rb'
class Queen < Piece

	def initialize(color)
		super color
		@value = 9
		@char = 'Q'
		@moves = [[1,0],[0,1],[-1,0],[0,-1],[1,1],[1,-1],[-1,1],[-1,-1]]
	end

end
