module Slideable

    def horizontal_dirs 
        [[0,-1], [0,1], [-1,0], [1,0]]    
    end

    def diagonal_dirs 
        [[-1,-1], [-1,1], [1,-1], [1,1]]
    end

    extend self
end