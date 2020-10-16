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

Hiding in Plain Scope
The traditional way of thinking about functions is that you declare a
function and then add code inside it.But the inverse thinking is equally
powerful and useful: take any arbitrary section of code you’ve written
and wrap a function declaration around it, which in effect “hides” the
code.

“hide” variables and functions by enclosing them in the scope of a
function.

Why would “hiding” variables and functions be a useful technique ?
    There’s a variety of reasons motivating this scope - based hiding.They
tend to arise from the software design principle Principle of Least
Privilege 1, also sometimes called Least Authority or Least Exposure.

function doSomething(a) {
    b = a + doSomethingElse(a * 2);
    console.log(b * 3);
}
function doSomethingElse(a) {
    return a - 1;
}
var b;
doSomething(2); // 15

In this snippet, the b variable and the doSomethingElse(..) function
    are likely “private” details of how doSomething(..) does its job.Giving
the enclosing scope “access” to b and doSomethingElse(..) is not only
unnecessary but also possibly “dangerous, ” in that they may be used
    in unexpected ways,

        A more “proper” design
would hide these private details inside the scope of doSometh
ing(..), such as:

function doSomething(a) {
    function doSomethingElse(a) {
        return a - 1;
    }
    var b;
    b = a + doSomethingElse(a * 2);
    console.log(b * 3);
}
doSomething(2); // 15
Now, b and doSomethingElse(..) are not accessible to any outside
influence, instead controlled only by doSomething(..).The func‐
tionality and end result has not been affected, but the design keeps
private details private, which is usually considered better software.

Collision Avoidance
Another benefit of “hiding” variables and functions inside a scope is
to avoid unintended collision between two different identifiers with
the same name but different intended usages.Collision results often
    in unexpected overwriting of values.
For example:
function foo() {
    function bar(a) {
        i = 3; // changing the `i` in the enclosing scope's
        // for-loop
        console.log(a + i);
    }
    for (var i = 0; i < 10; i++) {
        bar(i * 2); // oops, inifinite loop ahead!
    }
}
foo();

The i = 3 assignment inside of bar(..) overwrites, unexpectedly, the
i that was declared in foo(..) at the for loop.In this case, it will result
    in an infinite loop, because i is set to a fixed value of 3 and that will
forever remain < 10.

The assignment inside bar(..) needs to declare a local variable to use,
    regardless of what identifier name is chosen.var i = 3;

Global namespaces
A particularly strong example of(likely) variable collision occurs in
    the global scope.Multiple libraries loaded into your program can quite
easily collide with each other if they don’t properly hide their internal /
    private functions and variables.
Such libraries typically will create a single variable declaration, often
an object, with a sufficiently unique name, in the global scope.

For example:
var MyReallyCoolLibrary = {
    awesome: "stuff",
    doSomething: function () {
        // ...
    },
    doAnotherThing: function () {
        // ...
    }
};

Module management
Another option for collision avoidance is the more modern module
approach, using any of various dependency managers.Using these
tools, no libraries ever add any identifiers to the global scope, but are
instead required to have their identifier(s) be explicitly imported into
another specific scope through usage of the dependency manager’s
various mechanisms.

Functions as Scopes
We’ve seen that we can take any snippet of code and wrap a function
    around it, and that effectively “hides” any enclosed variable or function
    declarations from the outside scope inside that function’s inner scope.
For example:
var a = 2;
function foo() { // <-- insert this
    var a = 3;
    console.log(a); // 3
} // <-- and this
foo(); // <-- and this
console.log(a); // 2
While this technique works, it is not necessarily very ideal.There are
a few problems it introduces.The first is that we have to declare a
named - function foo() , which means that the identifier name foo itself
“pollutes” the enclosing scope(global, in this case).We also have to
explicitly call the function by name(foo()) so that the wrapped code
actually executes.
It would be more ideal if the function didn’t need a name(or, rather,
    the name didn’t pollute the enclosing scope), and if the function could
automatically be executed.

var a = 2;
(function foo() { // <-- insert this
    var a = 3;
    console.log(a); // 3
})(); // <-- and this
console.log(a); // 2

First, notice that the wrapping function statement starts with (func
tion...as opposed to just function... .While this may seem like a minor
detail, it’s actually a major change.Instead of treating the function as
a standard declaration, the function is treated as a function-
    expression.

        First, notice that the wrapping function statement starts with (func
tion...as opposed to just function... .While this may seem like a minor
detail, it’s actually a major change.Instead of treating the function as
a standard declaration, the function is treated as a function-
    expression.

Anonymous Versus Named
You are probably most familiar with function expressions as callback
parameters, such as:
setTimeout(function () {
    console.log("I waited 1 second!");
}, 1000);
This is called an anonymous function expression, because function()
...has no name identifier on it.Function expressions can be anony‐
mous, but function declarations cannot omit the name

Anonymous function expressions are quick and easy to type, and
many libraries and tools tend to encourage this idiomatic style of code.
    However, they have several drawbacks to consider:
1. Anonymous functions have no useful name to display in stack
traces, which can make debugging more difficult.
2. Without a name, if the function needs to refer to itself, for recur‐
sion, etc., the deprecated arguments.callee reference is unfortu‐
nately required.Another example of needing to self - reference is
when an event handler function wants to unbind itself after it fires.
3. Anonymous functions omit a name, which is often helpful in
    providing more readable / understandable code.A descriptive
name helps self - document the code in question.

The best practice is to always
name your function expressions:
    setTimeout(function timeoutHandler() { // <-- Look, I have a
        // name!
        console.log("I waited 1 second!");
    }, 1000);


var a = 2;
(function IIFE() {
    var a = 3;
    console.log(a); // 3
})();
console.log(a); // 2
There’s a slight variation on the traditional IIFE form, which some
prefer: (function () { ..}()).Look closely to see the difference.In
the first form, the function expression is wrapped in ( ), and then the
invoking() pair is on the outside right after it.In the second form, the
invoking() pair is moved to the inside of the outer() wrapping pair.
These two forms are identical in functionality.It’s purely a stylistic
choice which you prefer.

Blocks as Scopes
While functions are the most common unit of scope, and certainly the most widespread of the design approaches in the majority of JS in circulation, other units of scope are possible

for (var i = 0; i < 10; i++) {
    console.log(i);
}
We declare the variable i directly inside the for loop head, most likely because our intent is to use i only within the context of that for loop, and essentially ignore the fact that the variable actually scopes itself to the enclosing scope(function or global).

    That’s what block - scoping is all about.Declaring variables as close as possible, as local as possible, to where they will be used.

        Fortunately, ES6 changes that, and introduces a new keyword let, which sits alongside var as another way to declare variables.The let keyword attaches the variable declaration to the scope of whatever block(commonly a { .. } pair) it’s contained in.

Declarations made with let will not hoist to the entire scope of the block they appear in.Such declarations will not observably “ex
ist” in the block until the declaration statement.
{
    console.log(bar); // ReferenceError!
    let bar = 2;
}


// Garbage collection
// Another reason block-scoping is useful relates to closures and garbage collection to reclaim memory.

function process(data) {
    // do something interesting
}
var someReallyBigData = { .. };
process(someReallyBigData);
var btn = document.getElementById("my_button");
btn.addEventListener("click", function click(evt) {
    console.log("button clicked");
}, /*capturingPhase=*/false);

The click function click handler callback doesn’t need the someReal lyBigData variable at all.That means, theoretically, after pro
cess(..) runs, the big memory - heavy data structure could be garbage collected.However, it’s quite likely(though implementation dependent) that the JS engine will still have to keep the structure around, since the click function has a closure over the entire scope.

Block - scoping can address this concern, making it clearer to the engine that it does not need to keep someReallyBigData around:

function process(data) {
    // do something interesting
}
// anything declared inside this block can go away after!
{
    let someReallyBigData = { .. };
    process(someReallyBigData);
}
var btn = document.getElementById("my_button");
btn.addEventListener("click", function click(evt) {
    console.log("button clicked");
}, /*capturingPhase=*/false);

// const
// In addition to let , ES6 introduces const , which also creates a block-scoped variable, but whose value is fixed (constant). Any attempt to change that value at a later time results in an error.

/********************************************************************************************** */
/********************************************************************************************** */
/********************************************************************************************** */
// CHAPTER 4 - Hoisting

