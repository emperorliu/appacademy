function Student(fname, lname) {
  this.fname = fname;
  this.lname = lname;
  this.courses = [];
};

Student.prototype.name = function() {
  return this.fname + " " + this.lname;
};

Student.prototype.enroll = function(course) {
  if (this.courses.indexOf(course) === -1) {

    for (var i = 0; i < this.courses.length; i++) {
      if (this.courses[i].conflictsWith(course)) {
        alert(this.courses[i].courseName + " conflicts with " + course.courseName);
        return;
      }
    }
    course.students.push(this);
    this.courses.push(course);
  }
};

Student.prototype.course_load = function() {
    var result = {};

    for (var i = 0; i < this.courses.length; i++) {
      if (this.courses[i].dept in result) {
        result[this.courses[i].dept] += this.courses[i].credits;
      } else {
        result[this.courses[i].dept] = this.courses[i].credits;
      }
    }

    return result;
};

function Course(courseName, dept, credits, days, timeBlock) {
  this.courseName = courseName;
  this.dept = dept;
  this.credits = credits;
  this.days = days;
  this.timeBlock = timeBlock;
  this.students = [];
};

Course.prototype.addStudent = function(student) {
  student.enroll(this);
};

Course.prototype.conflictsWith = function(otherCourse) {
  if (this.days.intersection(otherCourse.days) === []){
    return false;
  } else {
     if (this.timeBlock === otherCourse.timeBlock) {
      return true;
    } else {
      return false;
    }
  }
};

Array.prototype.intersection = function(array) {
  this.filter(function(n) {
    return array.indexOf(n) != -1
  });
}


var velina = new Student("velina", "veleva");
var calc1 = new Course("calc1", "math and CS", 4, ["mon", "wed", "fri"], 2);
var calc2 = new Course("calc2", "math and CS", 4, ["tue", "wed", "fri"], 2);
var english = new Course("english", "english", 3, ["wed", "fri"], 1);
calc1.addStudent(velina);
calc2.addStudent(velina);
english.addStudent(velina);
