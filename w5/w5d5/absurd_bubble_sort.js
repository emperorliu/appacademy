var readline = require('readline')
var reader = readline.createInterface(process.stdin, process.stdout, null);


function absurdBubbleSort (arr, sortCompletionCallback) {
  function outerBubbleSortLoop (madeAnySwaps) {
    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
    }
  }

  outerBubbleSortLoop(true);
};

function sortCompletionCallback(arr) {
  console.log(arr);
};

function askIfLessThan(el1, el2, callback) {
  reader.question("Is " + el1 + " less than " + el2 + "? ",
  function(answer) {
    (answer === "y") ? callback(false) : callback(true);
  });
};

function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i == (arr.length - 1)) {
    outerBubbleSortLoop(madeAnySwaps);
    return;
  }

  askIfLessThan(arr[i], arr[i + 1], function (isLessThan) {
    if (isLessThan) {
      var tmp = arr[i];
      arr[i] = arr[i + 1];
      arr[i + 1] = tmp;

      madeAnySwaps = true;
    }

    innerBubbleSortLoop(
      arr, i + 1, madeAnySwaps, outerBubbleSortLoop
    );
  });
};

absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
