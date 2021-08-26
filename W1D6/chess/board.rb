require "colorize"
require "byebug"

require_relative "queen"
require_relative "king"
require_relative "bishop"
require_relative "rook"
require_relative "knight"
require_relative "pawn"
require_relative "null_piece"

class Board

    # y,x
    attr_reader :board#, :white_pieces, :black_pieces

    def initialize
        @board = Array.new(8) { Array.new(8) }
        @white_grave = []
        @black_grave = []

        @white_pieces = []
        @black_pieces = []
        populate_starting_positions
    end

    # there is a chance this doesn't work when referenced inside the class
    def [](pos)
        @board[pos[0]][pos[1]]
    end

    def []=(pos, value)
        @board[pos[0]][pos[1]] = value
        @board[pos[0]][pos[1]].pos = [pos[0], pos[1]] if !value.instance_of?(NullPiece)
    end
    
    def translate_into_coords(str)
        str = str.downcase.split
        letters_to_numbers = {
            "a" => 0,
            "b" => 1,
            "c" => 2,
            "d" => 3,
            "e" => 4,
            "f" => 5,
            "g" => 6,
            "h" => 7
        }

        [[ str[0][1].to_i,
           letters_to_numbers[str[0][0]]
           
         ],
         [ str[1][1].to_i,
           letters_to_numbers[str[1][0]]
           
         ]
        ]
    end


    def undo_move(end_pos, start_pos, taken_piece=NullPiece.new[end_pos])

       self[start_pos] = self[end_pos]
       self[end_pos] = taken_piece
    end


    def move_piece(start_pos, end_pos, player)
        #debugger 
        pp start_pos
        pp end_pos

        raise NotOccupiedError if self[start_pos].instance_of?(NullPiece)
        raise PositionNotOnBoardError if !start_pos.all? { |coord| (0..7).include?(coord) } || !end_pos.all? { |coord| (0..7).include?(coord) }
        raise ChoseSamePositionError if start_pos == end_pos
        raise NotYourColorError if player != self[start_pos].color

        if !self[end_pos].instance_of?(NullPiece)
            raise CannotTakeOwnPieceError if self[start_pos].color == self[end_pos].color
        end

        legal_move = self[start_pos].move_to(end_pos)

        return false if !legal_move

        if !self[end_pos].instance_of?(NullPiece)
            if self[end_pos].color != self[start_pos].color
                take_piece(end_pos)
            end
        end

        self[end_pos] = self[start_pos]
        self[start_pos] = NullPiece.new([start_pos])

        true
    end

    def take_piece(pos)
        self[pos].color == :white ? @white_grave << self[pos] : @black_grave << self[pos]
    end

    def change_pieces_boards(new_board)
        new_board.each do |row|
            row.each do |piece|
                piece.board = new_board
            end
        end
    end

    def check?(player, move=nil)
        king_location = find_king(player)

        player == :white ? pieces = @black_pieces : pieces = @white_pieces

        #insert move
        move_piece(move[1].pos, move[0], player) if move != nil

        pieces.each do |piece|
            if piece.move_to(king_location)
                puts piece.pos
                undo_move(move[0], move[1].pos, move[1]) if move != nil
                return true
            end
        end

        #undo move
        undo_move(move[0], move[1].pos, move[1]) if move != nil
        false
    end
    
    def checkmate?(player)
        return false if !check?(player)

        player == :white ? pieces = @black_pieces : pieces = @white_pieces

        duped_b = Marshal.load(Marshal.dump(@board))

        change_pieces_boards(new_board)

        pieces.each do |piece|
            duped_b.each_with_index do |row, i|
                row.each_with_index do |square, j|
                    if piece.move_to([i,j])
                        return false if !check?(player, [[i,j], piece])
                    end
                end
            end

        end

        change_pieces_boards(@board)

        true
    end

    def find_king(player)
        @board.each_with_index do |row, i|
            row.each_with_index do |square, j|
                return [i, j] if self[[i,j]].instance_of?(King) && self[[i,j]].color == player
            end
        end
    end

    def populate_starting_positions

        black_side_back_row = [
            Rook.new(:light_black, [0,0], self),
            Knight.new(:light_black, [0,1], self),
            Bishop.new(:light_black, [0,2], self),
            Queen.new(:light_black, [0,3], self),
            King.new(:light_black, [0,4], self),
            Bishop.new(:light_black, [0,5], self),
            Knight.new(:light_black, [0,6], self),
            Rook.new(:light_black, [0,7], self)
        ]

        black_side_back_row.each_with_index do |piece, i|
            self[[0,i]] = piece
        end

        black_side_pawns = []
        (0..7).each do |square|
            black_side_pawns << Pawn.new(:light_black, [1, square], self)
        end

        black_side_pawns.each_with_index do |piece, i|
            self[[1,i]] = piece
        end

        @black_pieces = black_side_back_row + black_side_pawns


        (0..7).each do |i|
            (2..5).each do |j|
                self[[j,i]] = NullPiece.new([j,i])
            end
        end


        white_side_back_row = [
            Rook.new(:white, [7,0], self),
            Knight.new(:white, [7,1], self),
            Bishop.new(:white, [7,2], self),
            Queen.new(:white, [7,3], self),
            King.new(:white, [7,4], self),
            Bishop.new(:white, [7,5], self),
            Knight.new(:white, [7,6], self),
            Rook.new(:white, [7,7], self)
        ]

        white_side_back_row.each_with_index do |piece, i|
            self[[7,i]] = piece
        end

        white_side_pawns = []
        (0..7).each do |square|
            white_side_pawns << Pawn.new(:white, [6, square], self)
        end

        white_side_pawns.each_with_index do |piece, i|
            self[[6,i]] = piece
        end

        @white_pieces = white_side_back_row + white_side_pawns

    end

    def display_white_grave
        formatted = @white_grave.map { |piece| piece.to_s }
        puts "#{formatted.join(" ")}".colorize(:white)
    end

    def display_black_grave
        formatted = @black_grave.map { |piece| piece.to_s }
        puts "#{formatted.join(" ")}".colorize(:light_black)
    end


    def display
        display_white_grave
        puts "  ---------------------------------".colorize(:light_blue)
        @board.each_with_index do |row, i|
            row_str = []
            row_str << "#{i + 1} |".colorize(:light_blue)
            row.each_with_index do |square, j|
                if !square.instance_of?(NullPiece)
                    row_str << "#{square.to_s} ".colorize(square.color) + "|"
                else
                    row_str << "  " + "|"
                end
            end
            puts "#{row_str.join(" ")}"
            puts "  ---------------------------------".colorize(:light_blue)
        end
        puts "    a   b   c   d   e   f   g   h  ".colorize(:light_blue)
        display_black_grave

    end



end

class NotOccupiedError < StandardError
end

class PositionNotOnBoardError < StandardError
end

class ChoseSamePositionError < StandardError
end

class CannotTakeOwnPieceError < StandardError
end

#b = Board.new

#debugger
#b.move_piece([0,1], [7,4], :light_black)

# create a map from "f8 h4" to array vals