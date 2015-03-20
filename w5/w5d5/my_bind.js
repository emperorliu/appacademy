Function.prototype.myBind = function (context) {
  var fn = this;

  return function () {
    return fn.apply(context);
  }
};

var rr = { name: "Rowdy Ronda" };

function printHi() {
  console.log("Hi, Im " + this.name + ", lol")
}

printHi.myBind(rr)();
