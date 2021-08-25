class Pawn

    attr_reader :color, :pos, :board
    attr_writer :pos

    def initialize(color, pos, board)
        @color = color 
        @pos = pos
        @board = board
        if @color == :white
            @moves = [
                        [-2,0], [-1,1], [-1,-1]
            ]
        else
            @moves = [
                       [2,0], [1,1], [-1,1]
            ]
        end
    end

    def move_to(end_pos)
         
        temp_pos = [(@pos[0] + @moves[0][0]), @pos[1]] # tests moving "forward 1/2 squares"
        if temp_pos.all? { |coord| (0..7).include?(coord) }
            #puts @board[@pos]
            if @board[temp_pos] == NullPiece || temp_pos == end_pos
                color == :white ? @moves[0] = [-1,0] : @moves[0] = [1,0]
                return true
            else
                temp_pos = [(@pos[0] + @moves[1]), (@pos[1] + @moves[1])] # tests moving to the right diagonally to take a piece
                if temp_pos.all? { |coord| (0..7).include?(coord) }
                    if @board[temp_pos] != NullPiece || temp_pos == end_pos
                        return true
                    else
                        temp_pos = [(@pos[0] + @moves[2]), (@pos[1] + @moves[2])] # tests moving to the left diagonally to take a piece
                        if temp_pos.all? { |coord| (0..7).include?(coord) }
                            if @board[temp_pos] != NullPiece || temp_pos == end_pos
                                return true
                            else
                                return false
                            end
                        end
                    end
                end
            end
        else
            return false
        end
        
        
    end

    def to_s
        "P"
    end


end