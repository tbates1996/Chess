class Piece

	attr_accessor :moves, :value, :char, :color 

	def initialize(color)
		@color = color
	end
	def to_s
		return char.colorize(:red) if color == :black
		return char.colorize(:blue)

	end

end
