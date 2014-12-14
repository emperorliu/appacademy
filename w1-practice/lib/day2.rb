def rps(choice)

end

# Examples:

# rps("Rock") # => "Paper, Lose"
# rps("Scissors") # => "Scissors, Draw"
# rps("Scissors") # => "Paper, Win"


def remix(arr)

end

# Examples:

# remix([["rum", "coke"], ["gin", "tonic"], ["scotch", "soda"]])
#   #=> [["rum, "tonic"], ["gin", "soda"], ["scotch", "coke"]]


def factors(num)
end

class Array
  def bubble_sort
  end
end

def substrings(string)
end

def super_print(string, options = {})
end

# Examples:

# super_print("Hello")                                    #=> "Hello"
# super_print("Hello", :times => 3)                       #=> "Hello" 3x
# super_print("Hello", :upcase => true)                   #=> "HELLO"
# super_print("Hello", :upcase => true, :reverse => true) #=> "OLLEH"
#
# options = {}
# super_print("hello", options)
# # options shouldn't change.

class Student

  def initialize(fname, lname)
  end

  def name
  end

  def enroll(course)
  end

  def course_load
  end

  def has_conflict?(new_course)
  end
end

class Course

  def initialize(name, department, num_credits, schedule)
  end

  def conflicts_with?(course2)
  end

  def add_student(student)
  end
end

# use these to test yoru code

# course1 = Course.new("corse1", "one", 4, [:mon, :wed], [1, 3])
# course2 = Course.new("corse2", "one", 4, [:mon, :wed, :fri], [2, 4])
# course3 = Course.new("corse3", "two", 3, [:tues, :thur], [1, 3])
# student1 = Student.new("Student", "One")
# student2 = Student.new("Another", "Student")
