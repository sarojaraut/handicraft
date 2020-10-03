
var myCar = {};

myCar.honk = function () {
    console.log('honk honk');
};

myCar.drive = function () {
    console.log('vrooom...');
};

myCar.honk();

var newCar = myCar;

newCar.honk();

newCar.honk = function () {
    console.log('New honk honk');
};

myCar.honk();

// newCar is just a new reference to same old object
// However, if we were to create 30 cars this way, we would end up defining the honk and drive behaviour