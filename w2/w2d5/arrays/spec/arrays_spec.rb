require 'arrays.rb'
require 'rspec'


describe Array do

  describe "#my_uniq" do
    it 'should return array of unique elements' do
      expect([1, 2, 3, 3, 4].my_uniq).to eq([1, 2, 3, 4])
      expect([3, 2].my_uniq).to eq([3, 2, 1])
    end
  end

  describe "#two_sum" do
    it 'should return pairs of elements whose sum is 0' do
      expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
    end

  end

end
