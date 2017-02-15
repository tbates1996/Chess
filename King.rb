require_relative 'Piece.rb'
class King < Piece

	def initialize(color)
		super(color)
		@char = 'K'
		@value = 100
		@moves = [[1,0],[0,1],[-1,0],[0,-1],[1,1],[1,-1],[-1,1],[-1,-1]]
	end

end