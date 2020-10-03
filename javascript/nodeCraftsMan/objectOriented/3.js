// Using a constructor function to create objects


var Car = function () {
    this.honk = function () {
        console.log('honk honk');
    };
};

var myCar = new Car();
myCar.honk();

Car = function () {

    this.honk = function () {

        console.log('New honk honk');

    };

};

myCar.honk(); // still points to old version function

var newCar = new Car();
newCar.honk(); // this will print new function

console.log(myCar.constructor); // outputs [Function: Car]
console.log(newCar.constructor); // outputs [Function: Car]


// this method of using new and this implicitly returns a newly created object with the honk function attached.
// we still cannot modify the honk behaviour only once and have this change reflected in all created cars.
// But we laid the first cornerstone for it. By using a constructor, all objects received a special property that links them to their constructor:
