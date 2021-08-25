class Hanoi
    attr_reader :arr1, :arr2, :arr3

    def initialize(arr1, arr2, arr3)
        @arr1 = arr1
        @arr2 = arr2
        @arr3 = arr3
        @not_over = true
    end

    def move
        while @not_over
            puts "please enter a ring to move the top ring to and from: 1 2"
            input = gets.chomp
            first = input[0].to_i
            second = input[1].to_i

            



        end




    end



end