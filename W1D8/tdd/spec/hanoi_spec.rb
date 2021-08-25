require "hanoi"

describe Hanoi do 
    subject(:hanoi) { Hanoi.new([1,1,1,2,2,2,3,3,3] ,[] ,[]) }
    let(:arr1) { hanoi.arr1 }
    let(:arr2) { hanoi.arr2 }
    let(:arr3) { hanoi.arr3 }

    describe "#initialize" do 
        expect(arr1).to be(Array)
        expect(arr2).to be(Array)
        expect(arr3).to be(Array)
    end

    describe "#move" do 
        context 'success' do
            let(:param1) { 1 }
            let(:param2) { 2 }

            it 'should pass' do
                expect(arr1).to receive(:unshift)
                expect(arr2).to receive(param1)
                test_result = hanoi.run_job(param1, param2)
            end
        end

        context "failure" do
            let(:param3) { 3 }
            let(:param4) { 4 }

            it 'should fail' do
                expect(arr3).to receive(:unshift)
                expect(arr2).not_to receive(param4)
                test_result = hanoi.run_job(param3, param4)
            end
        end
        expect(hanoi).to receive(:won)
    end

    describe "#won?" do 
        context "success" do
            expect(arr1).to eq([])
            expect(arr2).to eq([])
            expect(arr3).to eq([1,1,1,2,2,2,3,3,3])
        end

        context "failure" do
            expect(arr1.length).to be_between(1,9)
            expect(arr2).to be_between(1,9)
            expect(arr3).to be_between(0,8)
            
        end

    end


end