require_relative "board"

class Game

    def initialize
        @board = Board.new
        @players = [:light_black, :white]
    end

    def switch_player
        @players[0] == :white ? @players[0] = :light_black : @players[0] = :white
    end

    def play
        @board.display

        while !@board.checkmate?(@player1) || !@board.checkmate?(@player2)
            switch_player

            # current thing: not here but shouldn't allow player to make a move that puts them in check

            puts "Your King is in check!" if @board.check?(@players[0])

            puts "#{@players[0]}, enter a starting and ending position (Ex: B3 C4) "
            unformatted = gets.chomp

            coords = @board.translate_into_coords(unformatted)

            #subtracting offset
            coords[0][0] -= 1
            coords[1][0] -= 1

            # handle errors here with try catch, etc ask user to retry their input..
            @board.move_piece(coords[0], coords[1], @players[0])
            
            @board.display


        end

        if @board.checkmate?(@player1)
            puts "#{@player1} has been checkmated. #{@player2} Wins!"
        end

        if @board.checkmate?(@player2)
            puts "#{@player2} has been checkmated. #{@player1} Wins!"
        end

    end


end

if __FILE__ == $PROGRAM_NAME
    puts "Welcome to Chess!"
    game = Game.new
    
    game.play  
end 