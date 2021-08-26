module Stepable

    def knight_dirs
        [[-2, -1], [-2,  1], [-1, -2], [-1,  2], [ 1, -2], [ 1,  2], [ 2, -1], [ 2,  1]]
    end

    def king_dirs
        [[-1,0], [1,0], [0,-1], [0,1], [-1,-1], [-1,1], [1,-1], [1,1]]
    end

    extend self
end