require 'rspec'
require 'day4'


describe "blocks" do
  arr = [3, 1, 4, 2, 5]
  it "my_each" do
    expect(arr.my_each { |i| i * 2 }).to eq(arr.each { |i| i * 2 })
  end

  it "my_select" do
    expect(arr.my_select { |i| i % 2 == 1 }).to eq(arr.select { |i| i % 2 == 1 })
  end

  it "my_inject" do
    expect(arr.my_inject { |s, i| s + i }).to eq(arr.inject(&:+))
  end

  it "my_sort" do
    old_arr = arr.dup
    prc = proc { |num1, num2| num1 <=> num2 }
    prc2 = proc { |num1, num2| num2 <=> num1 }
    expect(arr.my_sort &prc).to eq(arr.sort)
    expect(arr.my_sort &prc2).to eq(arr.sort.reverse)
    expect(arr).to eq(old_arr)
  end

  it "my_sort!" do
    old_arr = arr.dup
    prc = proc { |num1, num2| num1 <=> num2 }
    prc2 = proc { |num1, num2| num2 <=> num1 }
    expect(arr.my_sort! &prc).to eq(arr.sort)
    expect(arr.my_sort! &prc2).to eq(arr.sort.reverse)
    expect(arr).to eq(old_arr.sort.reverse)
  end
end


describe "evaluate block" do

  it "should call the block, passing all the arguments to the block at once" do
    expect(eval_block("Kerry", "Washington", 23) do |fname, lname, score|
      puts "#{lname}, #{fname} won #{score} votes."
    end).to eq(nil)

    expect(eval_block(1,2,3,4,5) do |*args|
      args.inject(:+)
    end).to eq(15)

    expect(eval_block(1, 2, 3)).to eq("NO BLOCK GIVEN")
  end
end


describe "recursive" do

  it "deep_dup" do
    a = [[1, [2]], [3], 4]
    b = deep_dup(a)
    b[0] = 0

    expect(deep_dup(a)).to eq([[1, [2]], [3], 4])
  end

  it "subsets" do
    expect([].subsets).to eq([[]])
    expect([1].subsets).to eq([[], [1]])
    expect([1, 2, 3].subsets).to eq([[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]])
  end
end
