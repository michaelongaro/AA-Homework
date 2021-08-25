require_relative 'tic_tac_toe.rb'

class TicTacToeNode
    attr_accessor :board, next_mover_mark, prev_mov_pos

    def initialize(board, next_mover_mark, prev_move_pos = nil)
        @board = board
        @next_mover_mark = next_mover_mark
        @prev_mov_pos = prev_mov_pos
    end

    def losing_node?(evaluator)
        if @board.over?
           return board.won? && board.winner != evaluator
        end

        if @next_mover_mark == evaluator
            children.all? { |node| node.losing_node?(evaluator) }
        else
            children.any? { |node| node.losing_node?(evaluator) }
        end

    end

    def winning_node?(evaluator)
      if board.over?
          return board.winner == evaluator
      end

      if @next_mover_mark == evaluator
          children.any? { |node| node.winning_node?(evaluator) }
      else
          children.all? { |node| node.winning_node?(evaluator) }
      end
    end

    # This method generates an array of all moves that can be made after
    # the current move.
    def children
        children = []
        @board.each_with_index do |row, i|
            row.each_with_index do |cell, j|
                  if cell.empty?
                      duped_board = Marshal.load(Marshal.dump(@board))
                      duped_board[i][j] = @next_mover_mark
                      next_mover_mark = (@next_mover_mark == :x ? :o : :x)
                      children << TicTacToeNode(Marshal.load(duped_board, next_mover_mark, [i, j])
                  end
            end
        end

        children
    end
end