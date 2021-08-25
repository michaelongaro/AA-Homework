require_relative "stepable"

class King
    include Stepable

    attr_reader :color, :pos, :board
    attr_writer :pos

    # will board stay updated is the question
    def initialize(color, pos, board)
        @color = color 
        @pos = pos
        @board = board
    end

    def move_to(end_pos)
        dirs = king_dirs
        dirs.each do |d|
            
            temp_pos = [(@pos[0] + d[0]), (@pos[1] + d[1])]
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

    def to_s
        "♚"
    end

end