// Object-orientation, prototyping, and inheritance

var Vehicle = function () { };

Vehicle.prototype.drive = function () {

    console.log('vrooom...');

};

var Car = function () { };
Car.prototype = new Vehicle();

