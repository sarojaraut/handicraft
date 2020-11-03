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
f6({}, {});// 10 undefined

//
//Template Literals
//

var name = "Kyle";
var greeting = `Hello ${name}!`;
console.log(greeting);
console.log(typeof greeting);
// "Hello Kyle!"
// "string"
// any expressions of the form ${..}  in between `` are parsed and evaluated inline immediately. The fancy term for such parsing and evaluating is interpolation (much more accurate than templating).
// typeof greeting == "string" illustrates why it’s important not to  think of these entities as special template values, since you cannot assign the unevaluated form of the literal to something and reuse it.
// One really nice benefit of interpolated string literals is they are allowed to split across multiple lines:

// Tagged Template Literals

function foo(strings, ...values) {
    console.log(strings);
    console.log(values);
}
var desc = "awesome";
foo`Everything is ${desc}!`; //a special kind of function call that doesn’t need the ( .. )
// [ "Everything is ", "!"]
// [ "awesome" ]
// The first argument — we called it strings — is an array of all the plain strings (the stuff between any interpolated expressions). We get two values in the strings array:  "Everything is " and "!".

// Arrow Functions

function foo(x, y) {
    return x + y;
}
// versus
var foo = (x, y) => x + y;
// The body only needs to be enclosed by { .. } if there’s more than one expression, or if the body consists of a non-expression statement. If there’s only one expression, and you omit the surrounding { .. }, there’s an implied return in front of the expression, as illustrated in the previous snippet.

var a = [1, 2, 3, 4, 5];
a = a.map(v => v * 2);
console.log(a);
// [2,4,6,8,10]
// In those cases, where you have such inline function expressions, and they fit the pattern of computing a quick calculation in a single statement and returning that result, arrow functions indeed look to be an attractive and lightweight alternative to the more verbose function keyword and syntax.

// Lexical this in the arrow function callback in the previous snippet now points to the same value as in the enclosing makeRequest(..) function. In other words, => is a syntactic stand-in for var self = this.

// for..of Loops
// Joining the for and for..in loops from the JavaScript we’re all familiar with, ES6 adds a for..of loop, which loops over the set of values produced by an iterator.

var a = ["a", "b", "c", "d", "e"];
for (var idx in a) {
    console.log(idx);
}
// 0 1 2 3 4
for (var val of a) {
    console.log(val);
}
// "a" "b" "c" "d" "e"

// Here’s the pre-ES6 version of the for..of from that previous snippet:
var a = ["a", "b", "c", "d", "e"],
    k = Object.keys(a);
for (var val, i = 0; i < k.length; i++) {
    val = a[k[i]];
    console.log(val);
}
// "a" "b" "c" "d" "e"

// Standard built-in values in JavaScript that are by default iterables (or provide them) include:

// • arrays
// • strings
// • generators (see Chapter 3)
// • collections / TypedArrays (see Chapter 5)

// Number Literal Extensions

var dec = 42,
    oct = 0o52, // or `0O52` :(
    hex = 0x2a, // or `0X2a` :/
    bin = 0b101010; // or `0B101010` :/
// The only decimal form allowed is base-10. Octal, hexadecimal, and binary are all integer forms.

// Symbols
// For the first time in quite awhile, a new primitive type has been added to JavaScript, in ES6: the symbol. Unlike the other primitive types, however, symbols don’t have a literal form.
var sym = Symbol("some optional description");
typeof sym;
// "symbol"
// Some things to note:
// • You cannot and should not use new with Symbol(..). It’s not a constructor, nor are you producing an object.
// • The parameter passed to Symbol(..) is optional. If passed, it should be a string that gives a friendly description for the symbol’s purpose.
// • The typeof output is a new value ("symbol") that is the primary way to identify a symbol.

// The main point of a symbol is to create a string-like value that can’t collide with any other value. So for example, consider using a symbol as a constant representing an event name:
const EVT_LOGIN = Symbol("event.login");
// You’d then use EVT_LOGIN in place of a generic string literal like "event.login":
evthub.listen(EVT_LOGIN, function (data) {
    // ..
});
