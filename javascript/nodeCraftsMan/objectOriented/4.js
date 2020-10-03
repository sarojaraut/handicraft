// Using prototyping to efficiently share behaviour between objects
// while in class-based programming the class is the place to put functions that all objects will share, in prototype-based programming, the place to put these functions is the object which acts as the prototype for our objects at hand.
// But where is the object that is the prototype of our myCar objects - we didn’t create one!
// It has been implicitly created for us, and is assigned to the Car.prototype property (in case you wondered, JavaScript functions are objects too, and they therefore have properties).
// Here is the key to sharing functions between objects: Whenever we call a function on an object, the JavaScript interpreter tries to find that function within the queried object. But if it doesn’t find the function within the object itself, it asks the object for the pointer to its prototype, then goes to the prototype, and asks for the function there. If it is found, it is then executed.
// This means that we can create myCar objects without any functions, create the honk function in their prototype, and end up having myCar objects that know how to honk - because everytime the interpreter tries to execute the honk function on one of the myCar objects, it will be redirected to the prototype, and execute the honk function which is defined there.


var Car = function () { };
// keyword function() in above line is needed simply creating null object is not going to work
// if we put any code in above function body that will be executed every time new object is created
// console.log(typeof(Car)); // function
Car.prototype.honk = function () {
    console.log('honk honk');
};
var myCar1 = new Car();
var myCar2 = new Car();

myCar1.honk();// executes Car.prototype.honk() and outputs "honk honk"
myCar2.honk();// executes Car.prototype.honk() and outputs "honk honk"

// Our constructor is now empty, because for our very simple cars, no additional setup is necessary.
// Because both myCars are created through this constructor, their prototype points to Car.prototype - executing myCar1.honk() and myCar2.honk() always results in Car.prototype.honk() being executed.

Car.prototype.honk = function () {
    console.log('meep meep');
};
myCar1.honk();// executes Car.prototype.honk() and outputs "meep meep"
myCar2.honk();// executes Car.prototype.honk() and outputs "meep meep"

// Of course, we can also add additional functions at runtime:

Car.prototype.drive = function () {
    console.log('vrooom...');
};
myCar1.drive();// executes Car.prototype.drive() and outputs "vrooom..."
myCar2.drive();// executes Car.prototype.drive() and outputs "vrooom..."

myCar2.honk = function () {
    console.log('meeeeep');
};

// When the interpreter calls myCar2.honk(), there now is a function within myCar2 itself rather than using the prototype one

myCar1.honk();// executes Car.prototype.honk() and outputs "meep meep"
myCar2.honk();// executes outputs "meeeep"

// That’s one of the major differences to class-based programming: while objects are relatively “rigid” e.g. in Java, where the structure of an object cannot be changed at runtime, in JavaScript, the prototype-based approach links objects of a certain class more loosely together, which allows to change the structure of objects at any time.
