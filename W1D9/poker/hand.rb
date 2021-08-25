
class Hand

    attr_accessor :cards

    def initialize(cards)
        @cards = cards

    end

    def calculate_pairs
        sorted = @cards.sort_by {|card| card.value}



    end

    def is_a_straight_flush?(hand)
        previous_idx = 0
        # ace_idx = -1
        # hand.each_with_index do |c, j|
        #     if c.value == 1
        #         #put the ace right before the LOWEST c.value
        #         ace_idx = j
        #     end
        # end
        # if ace_idx > -1 

        hand.each_with_index do |card, i|
            if i == 0
                previous_idx = card.index
            else
                return false if card.index > previous_idx
            end
        end
        true
    end


end