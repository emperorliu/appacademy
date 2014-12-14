class Student
  attr_accessor :fname, :lname, :courses

  def initialize(fname, lname)
    @fname = fname.capitalize
    @lname = lname.capitalize
    @courses = []
  end

  def name
    "#{fname} #{lname}"
  end

  def enroll(course)
    raise "course would cause conflict!" if has_conflict?(course)
    self.courses << course unless self.courses.include?(course)
    course.students << self
  end

  def course_load
    dept2credits = Hash.new(0)
    courses.each { |course| dept2credits[course.dept] += course.credits }
    dept2credits
  end

  def has_conflict?(new_course)
    self.courses.any? do |enrolled_course|
      new_course.conflicts_with?(enrolled_course)
    end
  end
end

class Course

  attr_accessor :name, :dept, :credits, :students, :schedule

  def initialize(name, dept, credits, days, time_block)
    @name = name
    @dept = dept
    @credits = credits
    @students = []
    @schedule = days.collect { |day| [day, time_block] }.to_h
  end

  def add_student(student)
    student.enroll(self)
  end

  def conflicts_with?(course2)
    course2.schedule.each do |day, time_block|
      if schedule.keys.include?(day)
        a, b = self.schedule[day]
        c, d = time_block
        return true if c < b and c >= a
      end
    end
    false
  end
end

math = Course.new("calc", "math", 4, [:mon, :wed], [1, 3])
math2 = Course.new("algebra", "math", 4, [:mon, :wed, :fri], [2, 4])
physics = Course.new("physics", "physics", 3, [:tues, :thur], [1, 3])
velina = Student.new("Velina", "Veleva")
patrick = Student.new("Patrick", "Lo")
