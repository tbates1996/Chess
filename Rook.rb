require_relative "Piece.rb"

class Rook < Piece
	def initialize(color)
		super color
		@value = 5
		@char = 'R'
		@moves = [[1,0],[0,1],[-1,0],[0,-1]]
	end

end
