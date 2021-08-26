class Pawn

    attr_reader :color, :pos, :board
    attr_writer :pos, :board

    def initialize(color, pos, board)
        @color = color 
        @pos = pos
        @board = board
        @moves = [ [-1,0], [-1,1], [-1,-1] ] if @color == :white
        @moves = [ [1,0], [1,1], [-1,1] ] if @color == :light_black
    end

    def move_to(end_pos)   

        temp_pos = [(@pos[0] + @moves[0][0]), @pos[1]] # tests moving "forward 1/2 squares"
        if temp_pos.all? { |coord| (0..7).include?(coord) }

            if @board[temp_pos].instance_of?(NullPiece) && temp_pos != end_pos
                if (@pos[0] == 1 && @color == :light_black) || (@pos[0] == 6 && @color == :white)
                    temp_pos = [(@pos[0] + (@moves[0][0] * 2)), @pos[1]]
                    if @board[temp_pos].instance_of?(NullPiece) && temp_pos == end_pos
                        return true
                    end
                end

            elsif @board[temp_pos].instance_of?(NullPiece) && temp_pos == end_pos
                return true

            else
                temp_pos = [(@pos[0] + @moves[1][0]), (@pos[1] + @moves[1][1])] # tests moving to the right diagonally to take a piece
                if temp_pos.all? { |coord| (0..7).include?(coord) }
                    if !@board[temp_pos].instance_of?(NullPiece) && temp_pos == end_pos
                        return true
                    else
                        temp_pos = [(@pos[0] + @moves[2][0]), (@pos[1] + @moves[2][1])] # tests moving to the left diagonally to take a piece
                        if temp_pos.all? { |coord| (0..7).include?(coord) }
                            if !@board[temp_pos].instance_of?(NullPiece) && temp_pos == end_pos
                                return true
                            end
                        end
                    end
                end
            end
        end
        
        false
    end

    def to_s
        "P"
    end


end