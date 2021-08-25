require 'rspec'
require 'dessert'


describe Dessert do
  let(:chef) { double("chef") }
  subject(:dessert) { Dessert.new("ice cream", 3, chef) }

  describe "#initialize" do
    it "sets a type" do 
      expect(dessert.type).to eq("ice cream")
    end
    it "sets a quantity"do 
      expect(dessert.quantity).to eq(3)
    end

    it "starts ingredients as an empty array"do 
      expect(dessert.ingredients.class).to be(Array)
      expect(dessert.ingredients).to eq([])
    end

    it "raises an argument error when given a non-integer quantity"do 
      expect { Dessert.new("ice cream", "many", chef)}.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do 
      dessert.add_ingredient("strawberry")
      expect(dessert.ingredients).to include("strawberry")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do 
      expect(dessert.ingredients).to receive(:shuffle!)
      dessert.mix!
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      dessert.eat(3)
      expect(dessert.quantity).to eq(0)
    end
    it "raises an error if the amount is greater than the quantity" do 
      expect {dessert.eat(5)}.to raise_error(RuntimeError)
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
        expect(chef).to receive(:titleize)
        expect(dessert.type).to receive(:pluralize)
        dessert.serve
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do 
      expect(chef).to receive(:bake).with(dessert)
      dessert.make_more
    end
  end
end
