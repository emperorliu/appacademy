var readline = require('readline')
var reader = readline.createInterface(process.stdin, process.stdout, null);


function absurdBubbleSort (arr, sortCompletionCallback) {
  function outerBubbleSortLoop (madeAnySwaps) {
    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, madeAnySwaps, outerBubbleSortLoop);
    } else {
      return sortCompletionCallback(arr);
    }
  }

  outerBubbleSortLoop(true);
};

function sortCompletionCallback(arr) {
  console.log(arr);
};

function askIfLessThan(el1, el2, callback) {
  reader.question("Is " + el1 + " less than " + el2 + "?", function(answer) {
    if (answer === "y") {
      return callback(true);
    } else {
      return callback(false);
    }
  });
};

function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i < arr.length - 1) {
    askIfLessThan(arr[i], arr[i + 1], function(isLessThan) {
      if (isLessThan != true) {
        var temp = arr[i];
        arr[i] = arr[i + 1];
        arr[i + 1] = temp;
        madeAnySwaps = true;
      }
      innerBubbleSortLoop(arr, i + 1, madeAnySwaps, outerBubbleSortLoop);
    });
  } else {
    return outerBubbleSortLoop(madeAnySwaps);
  }
};

absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
