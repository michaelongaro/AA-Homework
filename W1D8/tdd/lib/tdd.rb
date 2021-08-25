def my_uniq(arr)
    uniq_arr = []
    arr.each do |elem|
        uniq_arr << elem unless uniq_arr.include?(elem)
    end
    uniq_arr
end

class Array

    def two_sum
        pairs = []
        
        (0..self.length-2).each do |i|
            (i+1..self.length-1).each do |j|
                pairs << [i, j] if self[i] + self[j] == 0 && j >= i
            end
        end

        pairs
    end
end

def my_transpose(array)
    transposed_arr = []

    array.each_with_index do |row, i|
        temp_col = []
        row.each_with_index do |elem, j|
            temp_col << array[j][i]
        end
        transposed_arr << temp_col
    end

    transposed_arr
end

def stock_picker(arr)
    temp_bd = 0
    temp_dates = []
    (0..arr.length-2).each do |day|
        if (arr[day+1] - arr[day]) > temp_bd
            temp_dates = [arr[day], arr[day+1]] 
            temp_bd = (arr[day+1] - arr[day])
        end
    end
    temp_dates
end

