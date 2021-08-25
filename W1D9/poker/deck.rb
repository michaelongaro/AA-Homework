require_relative "card"

class Deck
    
    attr_reader :deck

    def initialize
        @deck = []

        ranks = %w{A 2 3 4 5 6 7 8 9 10 J Q K}
        suits = %w{S H D C}
        suits.each do |suit|
            ranks.size.times do |i|
                @deck << Card.new(ranks[i], suit, i+1 )
            end
        end
        
    end




end