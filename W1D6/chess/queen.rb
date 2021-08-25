require_relative "slideable"

class Queen
    include Slideable

    attr_reader :color, :pos, :board
    attr_writer :pos

    # will board stay updated is the question
    def initialize(color, pos, board)
        @color = color 
        @pos = pos
        @board = board
    end

    def move_to(end_pos)
        dirs = horizontal_dirs + diagonal_dirs
        dirs.each do |d|
            (1..7).each do |i|
                temp_pos = [(@pos[0] + (d[0]* i)), (@pos[1] + (d[0]* i))]
                if temp_pos.all? { |coord| (0..7).include?(coord) }
                    if @board[temp_pos] == NullPiece || temp_pos == end_pos
                        return true
                    else
                        return false
                    end
                else
                    return false
                end
            end
        end
    end

    def to_s
        "♛"
    end


end