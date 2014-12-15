#Problem 1: You have array of integers. Write a recursive solution to find
#the sum of the integers.

def sum_recur(array)
  return 0 if array.empty?
  array.shift + sum_recur(array)
end


#Problem 2: You have array of integers. Write a recursive solution to
#determine whether or not the array contains a specific value.

def includes?(array, target)
  return false if array.empty?
  return true if array.first == target
  includes?(array.drop(1), target)
end


#Problem 3: You have an unsorted array of integers. Write a recursive
#solution to count the number of occurrences of a specific value.

def num_occur(array, target)
  return 0 if array.empty?
  prev_rec = num_occur(array.drop(1), target)
  array.first == target ? prev_rec + 1 : prev_rec
end

def num_occur(arr, target)
  return 0 if arr.empty?
  prev_rec = num_occur(arr.drop(1), target)
  prev_rec + (array.first == target ? 1 : 0)
end


#Problem 4: You have array of integers. Write a recursive solution to
#determine whether or not two adjacent elements of the array add to 12.

def add_to_twelve?(arr)
  return false if arr.length < 2
  return true if arr[0] + arr[1] == 12
  add_to_twelve?(arr.drop(1))
end


#Problem 5: You have array of integers. Write a recursive solution to
#determine if the array is sorted.

def sorted?(array)
  return [] if array.empty?
  return true if array.length == 1
  return false if array[0] > array[1]
  sorted?(array.drop(1))
end


#Problem 6: Write the code to give the value of a number after it is
#reversed. Must use recursion. (Don't use any #reverse methods!)

def reverse(number)
  return number if number < 10
  "#{number % 10}#{reverse(number / 10)}".to_i
end
