// javascript is not intrepreated it's compiled on the fly

// Weak typing, otherwise known as dynamic typing, allows a variable to hold any type of value at any time. It’s typically cited as a benefit for program flexibility

// In some programming languages, you declare a variable (container) to hold a specific type of value, such as number or string . Static typing, otherwise known as type enforcement, is typically cited as a benefit for program correctness by preventing nintended value conversions.

// JavaScript uses the latter approach, dynamic typing, meaning variables can hold values of any type without any type enforcement.


var amount = 99.99999;

console.log(amount.toFixed(2)) // rounding

///
var i = 0;
// a `while..true` loop would run forever, right?
while (true) {
    // keep the loop going?
    if (i <= 9) {
        console.log(i);
        i = i + 1;
    }
    // time to stop the loop!
    else {
        break;
    }
}
// 0 1 2 3 4 5 6 7 8 9
///

///
for (var i = 0; i <= 9; i = i + 1) {
    console.log(i);
}
// 0 1 2 3 4 5 6 7 8 9
///

// Programming has a term for this concept: scope (technically called lexical scope). In JavaScript, each function gets its own scope. Scope is basically a collection of variables as well as the rules for how those variables are accessed by name
// Lexical scope rules say that code in one scope can access variables of either that scope or any scope outside of it. But outer scope can't access variables from inner scope 
var a;
typeof a; // "undefined"
a = "hello world";
typeof a; // "string"
a = 42;
typeof a; // "number"
a = true;
typeof a; // "boolean"
a = null;
typeof a; // "object"--weird, bug should have been null
a = undefined;
typeof a; // "undefined"

// Notice how in this snippet the a variable holds every different type of value, and that despite appearances, typeof a is not asking for the “type of a ,” but rather for the “type of the value currently in a .” Only values have types in JavaScript; variables are just simple con‐tainers for those values.

function foo() {
    return 42;
}
foo.bar = "hello world";
typeof foo;      // "functio   
typeof foo();    // "number"
typeof foo.bar;  // "string" 

// Functions are a subtype of objects — typeof returns "function" , which implies that a function is a main type and can thus  have properties, but you typically will only use function object properties(like foo.bar) in limited cases.

// Built-In Type Methods

var a = "hello world";
var b = 3.14159;
a.length;
a.toUpperCase();
b.toFixed(4);
// 11
// "HELLO WORLD"
// "3.1416"

// Briefly, there is a String (capital S ) object wrapper form, typically called a “native,” that pairs with the primitive string type; it’s this object wrapper that defines the toUpperCase() method on its prototype.

// When you use a primitive value like "hello world" as an object by referencing a property or method (e.g., a.toUpperCase() in the previous snippet), JS automatically “boxes” the value to its object wrapper counterpart (hidden under the covers).

// A string value can be wrapped by a String object, a number can be wrapped by a Number object, and a boolean can be wrapped by a Boolean object. For the most part, you don’t need to worry about or directly use these object wrapper forms of the values

// Coercion comes in two forms in JavaScript: explicit and implicit. Explicit coercion is simply that you can see from the code that a conversion from one type to another will occur, whereas implicit coercion is when the type conversion can happen as more of a nonobvious side effect of some other operation.

// Here’s an example of explicit coercion:
var a = "42";
var b = Number(a);

// And here’s an example of implicit coercion:
var a = "42";
var b = a * 1;

// Truthy & falsy
// when a non- boolean value is coerced to a boolean , does it become true or false , respectively?

// The specific list of “falsy” values in JavaScript is as follows:
// • "" (empty string) 
// • 0 , -0 , NaN (invalid number )
// • null , undefined
// • false
// Any value that’s not on this “falsy” list is “truthy.” Here are some examples of those:
// • "hello"
// • 42
// • true
// • [ ] , [ 1, "2", 3 ] (arrays)
// • { } , { a: 42 } (objects)
// • function foo() { .. } (functions)

// To boil down a whole lot of details to a few simple takeaways,

// • If either value (aka side) in a comparison could be the true or false value, avoid == and use === .
// • If either value in a comparison could be of these specific values ( 0 , "" , or [] —empty array), avoid == and use === .
// • In all other cases, you’re safe to use == . Not only is it safe, but in many cases it simplifies your code in a way that improves readability.

// If you can be certain about the values, and == is safe, use it! If you can’t be certain about the values, use === . It’s that simple.

// You should take special note of the == and === comparison rules if you’re comparing two non-primitive values, like object s including function and array ). Because those values are actually held by reference, both == and === comparisons will simply check whether the references match, not anything about the underlying values.

var a = [1, 2, 3];
var b = [1, 2, 3];
var c = "1,2,3";
a == c;// true
b == c;// true
a == b;// false

// NaN is neither greater than nor less than any other value.

var a = 42;
var b = "foo";
a < b;// false
a > b;// false
a == b;// false

// Function Scopes
// You use the var keyword to declare a variable that will belong to thecurrent function scope, or the global scope if at the top level outsideof any function.

// Wherever a var appears inside a scope, that declaration is taken tobelong to the entire scope and accessible everywhere throughout.Metaphorically, this behavior is called hoisting,

var a = 2;
foo();// works because `foo()` declaration is "hoisted"
function foo() {
    a = 3;
    console.log(a);// 3
    var a;// declaration is "hoisted" to the top of `foo()`
}
console.log(a);// 2

// it's common to accept hoisted functions declaration but not varible hoisting

// If you try to access a variable’s value in a scope where it’s not avail‐able, you’ll get a ReferenceError thrown.

// If you try to set a variablethat hasn’t been declared, you’ll either end up creating a variable inthe top-level global scope (bad!) or getting an error, depending on“strict mode” 

// console.log("start =",x);
function f() {
    x = 20;
    console.log("within f x=", x);
}
f();
// console.log("End =",x);

switch (a) {
    case 2:
        // do something
        break;
    case 10:
        // do another thing
        break;
    case 42:
        // do yet another thing
        break;
    default:
    // fallback to here
}

// “fall through” is sometimes useful/desired
// if a is either 2 or 10 , it will execute the “some cool stuff ” code statements.
switch (a) {
    case 2:
    case 10:
        // some cool stuff
        break;
    case 42:
        // other stuff
        break;
    default:
    // fallback
}

var a = 42;
var b = (a > 41) ? "hello" : "world";
// similar to:
// if (a > 41) {
//     b = "hello";
// }
// else {
//     b = "world";
// }

// Immediately Invoked Function Expressions (IIFEs)
(function IIFE() {
    console.log("Hello!");
})();
// "Hello!"

// Closure

////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////
/********************************** 2You Don't Know JS. Scope & Closures *****************/

