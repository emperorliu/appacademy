require 'rspec'
require 'day2'


describe "Iterations" do
  it "return all factors of a given number" do
    expect(factors(24)).to eq([1, 2, 3, 4, 6, 8, 12, 24])
    expect(factors(146)).to eq([1, 2, 73, 146])
  end

  it "returns sorted array (bubble_sort!)" do
    arr = [7, 6, 3, 5, 2, 1, 8]
    arr_sorted = [1, 2, 3, 5, 6, 7, 8]

    expect(arr.bubble_sort!).to eq(arr_sorted)
    expect(arr).to eq(arr_sorted)
  end


  it "returns sorted array (bubble_sort)" do
    arr = [7, 6, 3, 5, 2, 1, 8]
    arr_sorted = [1, 2, 3, 5, 6, 7, 8]
    arr2 = arr.dup
    expect(arr.bubble_sort).to eq(arr_sorted)
    expect(arr).to eq(arr2)
  end

  it "substrings" do
    expect(substrings("cat")).to eq(["c", "ca", "cat", "a", "at", "t"])
  end
end


describe "symbols and strings" do
  it "super_print" do
    expect(super_print("Hello")).to eq(nil)
    expect(super_print("Hello", :times => 3)).to eq(nil)
  end
end
