var readline = require('readline')
var reader = readline.createInterface(process.stdin, process.stdout, null);

function addNumbers(sum, numsLeft, completionCallback) {
  if (numsLeft > 0) {
    reader.question("Gimme some numbers to add! ", function(number) {
      var number = parseInt(number);
      console.log("Running Sum: " + (sum + number));
      addNumbers(sum + number, numsLeft - 1, completionCallback);
    })
  } else {
    return completionCallback(sum);
  }
};

var completionCallback = function (sum) {
  console.log("Total Sum: " + sum);
};

addNumbers(0, 3, completionCallback);
