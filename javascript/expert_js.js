var object = {
    'foo': 'bar'
    },
num = 1;
// Passed by reference
;!function(obj) {
obj.foo = 'baz';
}(object);
// => Object {foo: "baz"}
console.log(object);

// Passed by value;
;!function(num) {
    num = 2;
}(num);
// => 1
console.log(num);


// The arguments object is a useful tool for designing functions that do not require a predetermined number of arguments as part of their method signature. The idea behind the arguments object is that it acts like a wildcard that allows you to access any number of supplied arguments by iterating over this special object just like an array. Here’s an example:
var sum = function () {
    var len = arguments.length,
    total = 0;
    for (var x = 0; x < len; x++) {
    total += arguments[x];
}
return total;
};
// => 6
console.log(sum(1, 2, 3));

// defaultParameters

var join = function (foo = 'foo', baz = (foo === 'foo') ? join(foo + "!") : 'baz') {
    return foo + ":" + baz;
}
// => hi:there
console.log(join("hi", "there"));
// Use the default parameter when not supplied
// => hi:baz
console.log(join("hi"));
// Use the default parameter when undefined is supplied
// => foo:there
console.log(join(undefined, "there"));
// Use an expression which has access to the current set of arguments
// => foo:foo!:baz
console.log(join('foo'));


var join = function (foo = 'foo', baz = (foo === 'foo') ? join(foo + "!") : 'baz') {
    console.log("foo="+foo);
    console.log("baz="+baz);
    return foo + ":" + baz;
}

console.log(join('foo'));

foo=foo!
baz=baz
foo=foo
baz=foo!:baz
"foo:foo!:baz"

// join('foo') and join() both returns the same result

// The two types of functions used in JavaScript. To the casual reader, the two appear very similar:
// Function Declaration
function isLie(cake){
return cake === true;
}
// Function Expression
var isLie = function(cake){
return cake === true;
}

// This difference may seem minor, but implications are huge; consider the following example:

declaration();// => Hi, I'm a function declaration!, calling function before declaration works fine 
function declaration() {
    console.log("Hi, I'm a function declaration!");
    }

expression(); // => Uncaught TypeError: undefined is not a function
var expression = function () {
console.log("Hi, I'm a function expression!");
}

// The concept to take away is that during parse time, JavaScript moves all function declarations to the top of the current scope. This is why it doesn’t matter where declarative functions appear in the script body.

// Immediately Invoked Function Expressions
// The immediately invoked function expression (IIFE) is one pattern you will see various libraries and frameworks use repeatedly. In its most basic form, it can be written in a couple of ways:

;(function(){
    ...
    })();

;!function(){
...
}();

;-function(){
    ...
}();

;+function(){
    ...
}();

;~function(){
    ...
}();

// Not Recommended
;void function(){
    ...
}();
// Not Recommended
;delete function(){
...
}();

// One other point worth mentioning is the use of the semicolon prepending the statement. Adding it provides a bit of defensive programming against other malformed modules that might not have a trailing semicolon.

// Higher-Order Functions

// One great feature of first-class functions is that they allow JavaScript to be used to create higher-order functions, which are functions that accept functions as arguments or return functions as return values. There are many advantages of higher-order functions, but one of the primary uses is to abstract common functionality into one place.

// Chapter - 3 Getting Closure

A closure is the act of binding all free variables and functions into a closed expression that persist beyond the lexical scope from which they were created.

Although this is a succinct definition, it is pretty impenetrable for the uninitiated; let’s dig deeper.

for (var x = 0; x < 10; x++){
    var foo = "bar";
    }
// => 'bar'
console.log(foo);

JavaScript’s function level scoping of local variables means behind the scenes the interpreter actually hoists the variable outside of the block. What actually gets interpreted looks more like this:

var x, foo;
for (x = 0; x < 10; x++) {
foo = "bar";
}
// => 'bar'
console.log(foo);
    
With the introduction of the let declaration, JavaScript can now use true block-level scoping. Here is an example:
for (var x = 0; x < 10; x++) {
let foo = "bar";
// => bar
console.log(foo);
}
// => ReferenceError: foo is not defined
console.log(foo);

