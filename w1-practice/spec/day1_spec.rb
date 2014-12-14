require 'rspec'
require 'day1'


describe "arrays" do

  it "my_uniq" do
    expect(my_uniq([1, 2, 1, 3, 3])).to eq([1, 2, 3])
  end

  it "returns pairs of positions, where elements sum to zero" do
    expect(two_sum([-1, 0, 2, -2, 1])).to eq([[0, 4], [2, 3]])
  end

  it "turns rows into columns in a given matrix" do
    matrix = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
    expect(my_transpose(matrix)).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
  end

  it "returns pair of days on which to first buy and then sell the stock" do
    expect(pick_stocks([2, 30, 18, 62, 5, 9, 11])).to eq([0, 3])
  end
end

describe "strings" do

  it "return a string representing the original number in a different base" do
    expect(num_to_s(5, 10)).to eq("5")
    expect(num_to_s(5, 2)).to eq("101")
    expect(num_to_s(5, 16)).to eq("5")
    expect(num_to_s(234, 10)).to eq("234")
    expect(num_to_s(234, 2)).to eq("11101010")
    expect(num_to_s(234, 16)).to eq("EA")
  end

  it "caesar cipher" do
    expect(caesar("hello", 3)).to eq("khoor")
  end
end

describe "hashes" do
  new_hash = HashSet.new

  it "insert" do
    expect(new_hash.insert(3)).to eq(true)
    expect(new_hash.insert(1)).to eq(true)
  end

  it "include?" do
    expect(new_hash.include?(1)).to eq(true)
    expect(new_hash.include?(6)).to eq(false)
  end

  it "delete" do
    expect(new_hash.delete(3)).to eq(true)
    expect(new_hash.delete(2)).to eq(false)
  end

  it "should convert to_a" do
    new_hash.insert(2)
    new_hash.insert(3)
    expect(new_hash.to_a).to eq([1, 2, 3])
  end

  hash1, hash2 = HashSet.new, HashSet.new
  hash1.insert(1); hash1.insert(2); hash1.insert(3)
  hash2.insert(3); hash2.insert(4); hash2.insert(5)

  it "union" do
    expect(hash1.union(hash2).to_a).to eq([1, 2, 3, 4, 5])
  end

  it "intersect" do
    expect(hash1.intersect(hash2).to_a).to eq([3])
  end

  it "minus" do
    expect(hash1.minus(hash2).to_a).to eq([1, 2])
  end
end

describe "enumerable" do
  it "should multiply each number by 2" do
    expect(multiply_by_two([1, 2, 3, 4])).to eq([2, 4, 6, 8])
  end

  it "my_each" do
    return_value = [1, 2, 3].my_each do |num|
      num * 2
    end.my_each do |num|
      num * 3
    end
    expect(return_value).to eq([1, 2, 3])
  end

  it "median" do
    expect(median([3, 2, 5, 1, 4])).to eq(3)
    expect(median([1, 2, 3, 4, 5, 6])).to eq(3.5)
  end

  it "should concatenate strings" do
    expect(concatenate(["Yay ", "for ", "strings!"])).to eq("Yay for strings!")
  end
end

describe Fixnum do

  it "reads 0 to 9" do
    0.in_words.should == 'zero'
    1.in_words.should == 'one'
    2.in_words.should == 'two'
    3.in_words.should == 'three'
    4.in_words.should == 'four'
    5.in_words.should == 'five'
    6.in_words.should == 'six'
    7.in_words.should == 'seven'
    8.in_words.should == 'eight'
    9.in_words.should == 'nine'
  end

  it "reads 10 to 12" do
    10.in_words.should == 'ten'
    11.in_words.should == 'eleven'
    12.in_words.should == 'twelve'
  end

  it "reads teens" do
    13.in_words.should == 'thirteen'
    14.in_words.should == 'fourteen'
    15.in_words.should == 'fifteen'
    16.in_words.should == 'sixteen'
    17.in_words.should == 'seventeen'
    18.in_words.should == 'eighteen'
    19.in_words.should == 'nineteen'
  end

  it "reads tens" do
    20.in_words.should == 'twenty'
    30.in_words.should == 'thirty'
    40.in_words.should == 'forty'
    50.in_words.should == 'fifty'
    60.in_words.should == 'sixty'
    70.in_words.should == 'seventy'
    80.in_words.should == 'eighty'
    90.in_words.should == 'ninety'
  end

  it "reads various other numbers less than 100" do
    20.in_words.should == 'twenty'
    77.in_words.should == 'seventy seven'
    99.in_words.should == 'ninety nine'
  end

  it "reads hundreds" do
    100.in_words.should == 'one hundred'
    200.in_words.should == 'two hundred'
    300.in_words.should == 'three hundred'
    123.in_words.should == 'one hundred twenty three'
    777.in_words.should == 'seven hundred seventy seven'
    818.in_words.should == 'eight hundred eighteen'
    512.in_words.should == 'five hundred twelve'
    999.in_words.should == 'nine hundred ninety nine'
  end

  it "reads thousands" do
    1000.in_words.should == 'one thousand'
    32767.in_words.should == 'thirty two thousand seven hundred sixty seven'
    32768.in_words.should == 'thirty two thousand seven hundred sixty eight'
  end

  it "reads millions" do
    10_000_001.in_words.should == 'ten million one'
  end

  it "reads billions" do
    1_234_567_890.in_words.should == 'one billion two hundred thirty four million five hundred sixty seven thousand eight hundred ninety'
  end

  it "reads trillions" do
    1_000_000_000_000.in_words.should == 'one trillion'
    1_000_000_000_001.in_words.should == 'one trillion one'
    1_888_259_040_036.in_words.should == 'one trillion eight hundred eighty eight billion two hundred fifty nine million forty thousand thirty six'
  end

end
