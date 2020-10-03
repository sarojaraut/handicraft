// Using a simple function to create plain objects


var makeCar = function () {
    var newCar = {};
    newCar.honk = function () {
        console.log('honk honk');
    };
    return newCar;
};

myCar1 = makeCar();
myCar2 = makeCar();
myCar3 = makeCar();

myCar1.honk();

// One downside of this approach is efficiency: for every myCar object that is created, a new honk function is created and attached - creating 1,000 objects means that the JavaScript interpreter has to allocate memory for 1,000 functions, although they all implement the same behaviour. This results in an unnecessarily high memory footprint of the application.

// Secondly, this approach deprives us of some interesting opportunities. These myCar objects don’t share anything - they were built by the same creator function, but are completely independent from each other.

// we cannot modify the honk behaviour only once and have this change reflected in all created cars.
