function Cat(name, owner) {
  this.name = name;
  this.owner = owner;
};

c = new Cat("kitty", "velina");
c.cuteStatement = function() {
  return (this.owner + " loves " + this.name);
};

Cat.prototype.cuteStatement = function() {
  return ("Everyone loves " + this.name);
};

Cat.prototype.meow = function() {
  return "meow!";
 };
