// var , let and const

// Spread / Rest
// ES6 introduces a new ... operator that’s typically referred to as the spread or rest operator, depending on where/how it’s used.

function foo(x, y, z) {
    console.log(x, y, z);
}
foo(...[1, 2, 3]);// 1 2 3
// In this usage, ... acts to give us a simpler syntactic replacement for the apply(..) method, which we would typically have used pre-ES6 as: foo.apply( null, [1,2,3] );  // 1 2 3


var a = [2, 3, 4];
var b = [1, ...a, 5];
console.log(b);
// [1,2,3,4,5]
// In this usage, ... is basically replacing concat(..), as the above behaves like [1].concat( a, [5] ).

function foo(x, y, ...z) {
    console.log(x, y, z);
}
foo(1, 2, 3, 4, 5);
// 1 2 [3,4,5]
// The ...z in this snippet is essentially saying: “gather the rest of the arguments (if any) into an array called z.” Since x was assigned 1, and y was assigned 2, the rest of the arguments 3, 4, and 5 were gathered into z.

// Of course, if you don’t have any named parameters, the ... gathers all arguments: 
function foo(...args) {
    console.log(args);
}
foo(1, 2, 3, 4, 5);  // [1,2,3,4,5]

// Default Parameter Values

function foo(x, y) {
    x = x || 11;
    y = y || 31;
}
console.log(x + y);
foo(); // 42
foo(5, 6); // 11
foo(5); //36
foo(null, 6); // 17
foo(0, 42);  // 53 <-- Oops, not 42

// Of course, if you’ve used this pattern before, you know that it’s both helpful and a little bit dangerous as in last example

// To fix this gotcha, some people will instead write the check more verbosely like this:
function foo(x, y) {
    x = (x !== undefined) ? x : 11;
    y = (y !== undefined) ? y : 31;
}
foo(0, 42); // 42
foo(undefined, 6); // 17

// With all this mind, we can now examine a nice helpful syntax added as of ES6 to streamline the assignment of default values to missing arguments:
function foo(x = 11, y = 31) {
    console.log(x + y);
}

foo(); // 42
foo(5, 6); // 11
foo(0, 42); // 42
foo(5); // 36
foo(5, undefined); // 36 <-- `undefined` is missing
foo(5, null); // 5 <-- null coerces to `0`
foo(undefined, 6); // 17 <-- `undefined` is missing
foo(null, 6); // 6 <-- null coerces to `0`


// Default Value Expressions
// Function default values can be more than just simple values like 31; they can be any valid expression, even a function call:

function bar(val) {
    console.log("bar called!");
    return y + val;
}
function foo(x = y + 3, z = bar(x)) {
    console.log(x, z);
}

// Destructuring
// ES6 introduces a new syntactic feature called destructuring

function foo() {
    return [1, 2, 3];
}
var tmp = foo(),
    a = tmp[0], b = tmp[1], c = tmp[2];
console.log(a, b, c); // 1 2 3

// we created a manual assignment of the values in the array that foo() returns to individual variables a, b, and c, and to do so we (unfortunately) needed the tmp variable.

// We can do similar with objects:
function bar() {
    return {
        x: 4,
        y: 5,
        z: 6
    };
}
var tmp = bar(),
    x = tmp.x, y = tmp.y, z = tmp.z;

// Specifically, ES6 introduces dedicated syntax for array destructuring and object destructuring

var [a, b, c] = foo();
var { x: x, y: y, z: z } = bar();
console.log(a, b, c);  // 1 2 3
console.log(x, y, z);  // 4 5 6

// If the property name being matched is the same as the variable you want to declare, you can actually shorten the syntax:
var { x, y, z } = bar();
console.log(x, y, z); // 4 5 6

// If you can write the shorter form, why would you ever write out the longer form? Because that longer form actually allows you to assign a property to a different variable name, which can sometimes be quite useful:

function bar() {
    return {
        x: 4,
        y: 5,
        z: 6
    };
}

var { x: y1, y: z1, z: x1 } = bar();
console.log(x1, y1, z1); // 6 4 5

// note value of x returned from bar is assigned to new variable y1 and so on surce => target or source : target or you can think of as  value: variable-alias
// this is assignment is different from  literal object creation target < = source or target : source

var X = 10, Y = 20;
var o = { a: X, b: Y }; //  target < = source or target : source
console.log(o.a, o.b);

// With both array destructuring assignment and object destructuring assignment, you do not have to assign all the values that are present. For example:

var [, b] = foo();
var { x, z } = bar();
console.log(b, x, z);  // 2 4 6

// The 1 and 3 values that came back from foo() are discarded, as is the 5 value from bar().

// Similarly, if you try to assign more values than are present in the value you’re destructuring/decomposing, you get graceful fallback to undefined, as you’d expect:
var [, , c, d] = foo();
var { w, z } = bar();
console.log(c, z);  // 3 6
console.log(d, w);  // undefined undefined

var a = [2, 3, 4];
var [b, ...c] = a;
console.log(b, c);  // 2 [3,4]

// Both forms of destructuring can offer a default value option for an assignment
var [a = 3, b = 6, c = 9, d = 12] = foo();
var { x = 5, y = 10, z = 15, w = 20 } = bar();
console.log(a, b, c, d);  // 1 2 3 12
console.log(x, y, z, w);  // 4 5 6 20

// destructuring is great and can be very useful, but it’s also a sharp sword that used unwisely can end up injuring (someone’s brain).

Nested Destructuring
var a1 = [1, [2, 3, 4], 5];
var o1 = { x: { y: { z: 6 } } };
var [a, [b, c, d], e] = a1;
var { x: { y: { z: w } } } = o1;
console.log(a, b, c, d, e);// 1 2 3 4 5
console.log(w);// 6

// Nested destructuring can be a simple way to flatten out object namespaces. For example:
var App = {
    model: {
        User: function () { .. }
}
};
// instead of:
// var User = App.model.User;
var { model: { User } } = App;


// Destructuring Parameters
function foo([x, y]) {
    console.log(x, y);
}
foo([1, 2]); // 1 2

foo([1]);// 1 undefined

foo([]);// undefined undefined

Object destructuring for parameters works, too:
    function foo({ x, y }) {
        console.log(x, y);
    }
foo({ y: 1, x: 2 });// 2 1
foo({ y: 42 });// undefined 42
foo({});// undefined undefined

// Of course, all the previously discussed variations of destructuring are available 
function f1([x = 2, y = 3, z]) { ..}
function f2([x, y, ...z], w) { ..}
function f3([x, y, ...z], ...w) { ..}
function f4({ x: X, y }) { ..}
function f5({ x: X = 10, y = 20 }) { ..}
function f6({ x = 10 } = {}, { y } = { y: 10 }) { ..}
// Let’s take one example from this snippet and examine it, for illustration purposes:
function f3([x, y, ...z], ...w) {
    console.log(x, y, z, w);
}
f3([]); // undefined undefined [] []
f3([1, 2, 3, 4], 5, 6);// 1 2 [3,4] [5,6]

// Destructuring Defaults + Parameter Defaults
function f6({ x = 10 } = {}, { y } = { y: 10 }) {
    console.log(x, y);
}
f6();// 10 10
f6( {}, {} );// 10 undefined

//
//Template Literals
//

var name = "Kyle";
var greeting = `Hello ${name}!`;
console.log( greeting );
console.log( typeof greeting );
// "Hello Kyle!"
// "string"


//
//Interpolated Expressions
//




