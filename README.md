## Prep Work for App Academy

### Twitter Clone ( [my code](https://github.com/vveleva/sample_app) )
This is the sample application for the
[*Ruby on Rails Tutorial:
Learn Web Development with Rails*](http://www.railstutorial.org/)
by [Michael Hartl](http://www.michaelhartl.com/).

## Week 1

### Mastermind ( [my code](https://github.com/vveleva/appacademy/blob/master/w1/w1d3/mastermind.rb) )

### Maze Solver ( [my code](https://github.com/vveleva/appacademy/blob/master/w1/w1d3/maze_solver.rb) )
A program that finds a route between two points in a maze.

### Towers of Hanoi ( [my code](https://github.com/vveleva/appacademy/blob/master/w1/w1d1/towers_of_hanoi.rb) )

![towers of hanoi](https://github.com/vveleva/appacademy/blob/master/images/towers_of_hanoi.png)


### Tic Tac Toe  ( [my code](https://github.com/vveleva/appacademy/blob/master/w1/w1d2/tic_tac_toe.rb) )
![tic tac toe](https://github.com/vveleva/appacademy/blob/master/images/tic_tac_toe.png)


### Hangman ( [my code](https://github.com/vveleva/appacademy/blob/master/w1/w1d3/hangman.rb) )
Two AIs play against one another.

![hangman](https://github.com/vveleva/appacademy/blob/master/images/hangman.png)


### Word Chains ( [my code](https://github.com/vveleva/appacademy/blob/master/w1/w1d4/word_chains.rb) )
Given two words of equal length as command-line arguments, the program builds a chain of words connecting the first to the second. Each word in the chain is in the dictionary and every step along the chain changes exactly one letter from the previous word.

## Week 2

### Minesweeper ( [my code](https://github.com/vveleva/appacademy/tree/master/w2/w2d1) )

### Chess ( [my code](https://github.com/vveleva/appacademy/tree/master/w2/w2d2d3) )
There is a human and an ai player. I also implemented en passant.

![chess](https://github.com/vveleva/appacademy/blob/master/images/chess.png)


### Checkers ( [my code](https://github.com/vveleva/appacademy/tree/master/w2/w2d4) )

![checkers](https://github.com/vveleva/appacademy/blob/master/images/checkers.png)


## Week 3

### SQLZoo ( [my code](https://github.com/vveleva/appacademy/tree/master/w3/w3d1/sqlzoo-master) )

### URL Shortner App ( [my code](https://github.com/vveleva/appacademy/tree/master/w3/w3d3/url_shortner_app) )
URL Shortner a tool that takes an input URL and will shorten it for the user. Subsequent users can then give the shortened URL back to the application and be directed to the original URL. You can input shortened URLs into CLI and the original URL pops open in a browser (with the help of the `launchy` gem).

### Polls App ( [my code](https://github.com/vveleva/appacademy/tree/master/w3/w3d4/PollsApp) )
- Tables: `users`, `polls`, `questions`, `answer_choices`, and `responses`
- associations and validations for all models


### ActiveRecord ( [my code](https://github.com/vveleva/appacademy/tree/master/w3/w3d5) )
I built my own lite version of ActiveRecord.
- implemented `my_attr_accessor` using
  - `define_method`
  - `instance_variable_get`
  - `instance_variable_set`
- used `SQLObject` to interact with the database to implement
  - `::all`
  - `::find`
  - `#insert`
  - `#update`
  - `#save`
  - `::table_name` and `::table_name=`
  - `::finalize!` which automatically adds getter and setter methods for each column
  - `#initialize`
  - `::parse_all`
- implemented associations
  - `belongs_to` and `has_many` associations, which store
    - `#foreign_key`
    - `#class_name`
    - `#primary_key`
  - `has_one_through`

## Week 4

### Blogger ( [my code](https://github.com/vveleva/blogger) )
JumpStart blogger tutorial, which can be found at [JumpStart Lab](http://tutorials.jumpstartlab.com/projects/blogger.html).

### Contacts API ( [my code](https://github.com/vveleva/appacademy/tree/master/w4/w4d1/routes_app) )

Contacts API is an application storing your email contacts.  Users can send requests to the API in order to create and share contacts, as well as retrieve their stored contact information.
- Tables: `users`, `contacts`, `contact_share`, `contact_group`, and `comments`
