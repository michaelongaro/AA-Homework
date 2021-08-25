require "tdd"

describe "my_uniq" do
  let(:array) { [1, 3, 4, 1, 3, 7] }
  let(:uniqued_array) { my_uniq(array.dup) }

  it "removes duplicates" do
    array.each do |item|
      expect(uniqued_array.count(item)).to eq(1)
    end
  end

  it "only contains items from original array" do
    uniqued_array.each do |item|
      expect(array).to include(item)
    end
  end

  it "does not modify original array" do
    expect {
      my_uniq(array)
    }.to_not change{array}
  end
end

describe "Array#two_sum" do 
    let(:array) { [-1, 0, 2, -2, 1] }
    let(:sums) { array.two_sum }

    it "returns pairs (internally/externally) sorted" do 

        (0..array.two_sum.length - 2).each do |pair_num|
            if sums[pair_num][0] == sums[pair_num+1][0] 
                expect(sums[pair_num][1]).to be <= sums[pair_num+1][1]
            end
            expect(sums[pair_num][0]).to be <= sums[pair_num+1][0]
        end
    end

    it "returns pairs of indices that add up to zero" do 
        array.two_sum.each do |pair|
            expect(array[pair[0]] + array[pair[1]]).to eq(0)
        end
    end
end

describe "#my_transpose" do 
    let(:array) {[
                    [0, 1, 2],
                    [3, 4, 5],
                    [6, 7, 8]
                ]}
    let(:transposed_arr) { my_transpose(array)}

    it "switches the rows and the cols of the array" do
        array.each_with_index do |row, i|
            temp_col = []
            row.each_with_index do |elem, j|
                temp_col << array[j][i]
            end
            expect(transposed_arr[i]).to eq(temp_col)
        end
    end

    it "does not change the original array" do
        expect { my_uniq(array) }.to_not change{array}
    end
end

describe "#stock_picker" do 
    let(:arr) { [4,2,6,1,8,45,4,9,3,5,7,8,3,2,6,4,4,4,3,9,7,6] }
    let(:best_days) { stock_picker(arr) }

    it "stores the positive differences between days" do
        temp_bd = 0
        temp_dates = []
        (0..arr.length-2).each do |day|
            if (arr[day+1] - arr[day]) > temp_bd
                temp_dates = [arr[day], arr[day+1]] 
                temp_bd = (arr[day+1] - arr[day])
            end
        end
        expect(best_days).to eq([8, 45])
    end

    

end