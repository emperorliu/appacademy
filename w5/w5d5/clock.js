function Clock () {
  this.currentTime = null;
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  var hr  = this.date.getHours();
  var min = this.date.getMinutes();
  var sec = this.date.getSeconds();

  console.log(hr + ":" + min + ":" + sec);
};

Clock.prototype.run = function () {
  this.date = new Date();
  this.printTime();
  setInterval(this._tick.bind(this), Clock.TICK);
};

Date.prototype.addSeconds = function(s) {
  this.setSeconds(this.getSeconds() + s);
  return this;
}

Clock.prototype._tick = function () {
  this.date = this.date.addSeconds(Clock.TICK / 1000);
  this.printTime();

};


var clock = new Clock();
clock.run();
