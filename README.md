## Week 1

### Towers of Hanoi ( [source](https://github.com/vveleva/appacademy/blob/master/w1/w1d1/towers_of_hanoi.rb) )

![towers of hanoi](https://github.com/vveleva/appacademy/blob/master/images/towers_of_hanoi.png)


### Tic Tac Toe  ( [source](https://github.com/vveleva/appacademy/blob/master/w1/w1d2/tic_tac_toe.rb) )
![tic tac toe](https://github.com/vveleva/appacademy/blob/master/images/tic_tac_toe.png)


### Hangman ( [source](https://github.com/vveleva/appacademy/blob/master/w1/w1d3/hangman.rb) )
Two AIs play against one another.

![hangman](https://github.com/vveleva/appacademy/blob/master/images/hangman.png)


## Week 2

### Chess ( [source](https://github.com/vveleva/appacademy/tree/master/w2/w2d2d3) )
![chess](https://github.com/vveleva/appacademy/blob/master/images/chess.png)


### Checkers ( [source](https://github.com/vveleva/appacademy/tree/master/w2/w2d4) )
Solo day

![checkers](https://github.com/vveleva/appacademy/blob/master/images/checkers.png)


https://github.com/vveleva/appacademy/blob/master/w1/w1d1/towers_of_hanoi.rb


## Week 3

### SQLZoo ( [source](https://github.com/vveleva/appacademy/tree/master/w3/w3d1/sqlzoo-master) )

### URL Shortner App ( [source](https://github.com/vveleva/appacademy/tree/master/w3/w3d3/url_shortner_app) )

### Polls App ( [source](https://github.com/vveleva/appacademy/tree/master/w3/w3d4/PollsApp) )

### ActiveRecord ( [source](https://github.com/vveleva/appacademy/tree/master/w3/w3d5) )
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

### Contacts API ( [source](https://github.com/vveleva/appacademy/tree/master/w4/w4d1/routes_app) )

Contacts API is an application storing your email contacts.  Users can send requests to the API in order to create and share contacts, as well as retrieve their stored contact information.
- Tables: `users`, `contacts`, `contact_share`, `contact_group`, and `comments`
