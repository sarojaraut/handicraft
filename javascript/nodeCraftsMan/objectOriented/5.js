// memory usage comparison
var C = function () {

    this.f = function (foo) {

        console.log(foo);

    };

};


var a = [];

for (var i = 0; i < 1000000; i++) {

    a.push(new C());
}

// In Google Chrome, this results in a heap snapshot size of 328 MB.Here is the same example, but now the function is shared through the constructor’s prototype:

var C = function () { };
C.prototype.f = function (foo) {
    console.log(foo);
};
var a = [];
for (var i = 0; i < 1000000; i++) {
    a.push(new C());
}
// This time, the size of the heap snapshot is only 17 MB, i.e., only about 5 % of the non - efficient solution.
