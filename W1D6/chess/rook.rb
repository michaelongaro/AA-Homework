require_relative "slideable"

class Rook
    include Slideable
    
    attr_reader :color, :pos, :board
    attr_writer :pos, :board

    def initialize(color, pos, board)
        @color = color 
        @pos = pos
        @board = board
    end

    def move_to(end_pos)
        dirs = Slideable.horizontal_dirs
        dirs.each do |d|
            clear_path = true
            (1..7).each do |i|
                temp_pos = [(@pos[0] + (d[0] * i)), (@pos[1] + (d[1] * i))]
                if temp_pos.all? { |coord| (0..7).include?(coord) }
                    break if !@board[temp_pos].instance_of?(NullPiece) && temp_pos != end_pos
                    if @board[temp_pos].instance_of?(NullPiece) && temp_pos == end_pos
                        return true
                    end
                end
            end
        end

        false
    end

    def to_s
        "R"
    end


end