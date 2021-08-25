require "colorize"
require_relative "queen"
require_relative "king"
require_relative "bishop"
require_relative "rook"
require_relative "knight"
require_relative "pawn"
require_relative "null_piece"

class Board

    # y,x
    attr_reader :board

    def initialize
        @board = Array.new(8) { Array.new(8) }
        populate_starting_positions
    end

    # there is a chance this doesn't work when referenced inside the class
    def [](pos)
        @board[pos[0]][pos[1]]
    end

    def []=(pos, value)
        @board[pos[0]][pos[1]] = value
        #@board[pos[0]][pos[1]].pos = [pos[0], pos[1]]
    end


    def move_piece(start_pos, end_pos)
        raise NotOccupiedError if self[start_pos] == instance_of?(NullPiece)
        raise PositionNotOnBoardError if !start_pos.all? { |coord| (0..7).include?(coord) } || !end_pos.all? { |coord| (0..7).include?(coord) }
        raise ChooseDifferentPositionError if start_pos == end_pos

        legal_move = self[start_pos].move_to(end_pos)

        return false if !legal_move

        if self[end_pos] != instance_of?(NullPiece)
            if self[end_pos].color != self[start_pos].color
                take_piece(end_pos)
            end
        end

        self[end_pos] = self[start_pos]
        self[start_pos] = NullPiece.new([start_pos])
    end

    def take_piece(pos)
        #@board[pos] 
        puts "took!"
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

    end

    def display
        puts "    1   2   3   4   5   6   7   8  ".colorize(:light_blue)
        puts "  ---------------------------------".colorize(:light_blue)
        @board.each_with_index do |row, i|
            row_str = []
            row_str << "#{i + 1} |".colorize(:light_blue)
            row.each_with_index do |square, j|
                if square != NullPiece
                    row_str << "#{square.to_s} ".colorize(square.color) + "|"
                else
                    row_str << "  " + "|"
                end
            end
            puts "#{row_str.join(" ")}"
            puts "  ---------------------------------".colorize(:light_blue)
        end

        "lmfao"
    end



end

class NotOccupiedError < StandardError
end

class PositionNotOnBoardError < StandardError
end

class ChooseDifferentPositionError < StandardError
end