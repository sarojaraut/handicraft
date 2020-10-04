// Another way of creating objects and inheritance

var vehicle = {};

vehicle.drive = function () {
    console.log('vrooom...');
};

var car = Object.create(vehicle);

car.honk = function () {
    console.log('honk honk');
};

var myCar = Object.create(car);

myCar.honk();  // outputs "honk honk"
myCar.drive(); // outputs "vrooom..."



// Conceptually, this is really the same as in the previous example where we defined that Car.prototype shall be a new Vehicle();.
// But wait! We created the functions drive and honk within our objects, not on their prototypes - that’s memory-inefficient!
// Well, in this case, it’s actually not