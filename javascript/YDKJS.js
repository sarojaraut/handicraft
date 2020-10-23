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
/********************************************************************************************** */
/********************************************************************************************** */
/********************************************************************************************** */
// CHAPTER 5 Scope Closure
// Closure is when a function can remember and access its lexical scope even when it’s invoked outside its lexical scope.

function foo() {
    var a = 2;
    function bar() {
        console.log(a);
    }
    return bar;
}
var baz = foo();
baz(); // 2 -- Whoa, closure was just observed, man.

// After foo() executed, normally we would expect that the entirety of the inner scope of foo() would go away, garbage collector that comes along and frees up memory once it’s no longer in use.Since it would appear that the contents of foo() are no longer in use, it would seem natural  that they should be considered gone.

// By virtue of where it was declared, bar() has a lexical scope closure over that inner scope of foo(), which keeps that scope alive for bar() to reference at any later time.  bar() still has a reference to that scope, and that reference is called closure.

function wait(message) {
    setTimeout(function timer() {
        console.log(message);
    }, 1000);
}
wait("Hello, closure!");

// timer has a scope closure over the scope of wait(..) , indeed keeping and using a reference to the variable message .

// essentially whenever and wherever you treat functions (that access their own respective lexical scopes) as first-class values and pass them around, you are likely to see those functions exercising closure. Be that timers, event handlers, Ajax requests, crosswindow messaging, web workers, or any of the other asynchronous (or synchronous!) tasks, when you pass in a callback function, get ready to sling some closure around!

for (var i = 1; i <= 5; i++) {
    (function () {
        setTimeout(function timer() {
            console.log(i);
        }, i * 1000);
    })();
}
// aobve block prints 6 five times because is is in global scope for each call

for (var i = 1; i <= 5; i++) {
    (function (j) {
        setTimeout(function timer() {
            console.log(j);
        }, j * 1000);
    })(i);
}
// if we want one to five to be printed then we need to make a local copy of the counter 

// also the following awesome code just works the same way
for (var i = 1; i <= 5; i++) {
    let j = i; // yay, block-scope for closure!
    setTimeout(function timer() {
        console.log(j);
    }, j * 1000);
}

// There’s a special behavior defined for let declarations used in the head of a for loop. This behavior says that the variable will be declared not just once for the loop, but each iteration. And, it will, helpfully, be initialized at each subsequent iteration with the value from the end of the previous iteration.

for (let i = 1; i <= 5; i++) {
    setTimeout(function timer() {
        console.log(i);
    }, i * 1000);
}

// There are other code patterns that leverage the power of closure but that do not on the surface appear to be about callbacks.

function CoolModule() {
    var something = "cool";
    var another = [1, 2, 3];
    function doSomething() {
        console.log(something);
    }
    function doAnother() {
        console.log(another.join(" ! "));
    }
    return {
        doSomething: doSomething,
        doAnother: doAnother
    };
}
var foo = CoolModule();
foo.doSomething(); // cool
foo.doAnother(); // 1 ! 2 ! 3

// First, CoolModule() is just a function, but it has to be invoked for there to be a module instance created. Without the execution of the outer function, the creation of the inner scope and the closures would not occur.

// Second, the CoolModule() function returns an object, denoted by the object-literal syntax { key: value, ... } . The object we return has references on it to our inner functions, but not to our inner data variables. We keep those hidden and private. It’s appropriate to think of this object return value as essentially a public API for our module.

// This object return value is ultimately assigned to the outer variable foo , and then we can access those property methods on the API, like foo.doSomething() .

// It is not required that we return an actual object (literal) from our module. We could just return back an inner function directly. jQuery is actually a good example of this. The jQuery and $ identifiers are the public API for the jQuery module, but they are, themselves, just functions (which can themselves have properties, since all functions are objects).

// An powerful variation on the module pattern is to name the object you are returning as your public API

var foo = (function CoolModule(id) {
    function change() {
        // modifying the public API
        publicAPI.identify = identify2;
    }
    function identify1() {
        console.log(id);
    }
    function identify2() {
        console.log(id.toUpperCase());
    }
    var publicAPI = {
        change: change,
        identify: identify1
    };
    return publicAPI;
})("foo module");
foo.identify(); // foo module
foo.change();
foo.identify(); // FOO MODULE

// By retaining an inner reference to the public API object inside your module instance, you can modify that module instance from the inside, including adding and removing methods and properties, and changing their values.

function foo() {
    console.log(a); // 2 
    // Lexical scope holds that the RHS reference to a in foo() will be re solved to the global variable a , which will result in value 2 being output
    // if JavaScript had dynamic scope, when foo() is executed, theoretically the code below would instead result in 3 as the output
}
function bar() {
    var a = 3;
    foo();
}
var a = 2;
bar();

// To be clear, JavaScript does not, in fact, have dynamic scope. It has lexical scope. Plain and simple. But the this mechanism is kind of like dynamic scope.

// ES6 adds a special syntactic form of function declaration called the arrow function. The so-called “fat arrow” is often mentioned as a shorthand for the tediously verbose (sarcasm) function keyword. But there’s something much more important going on with arrow functions that has nothing to do with saving keystrokes in your dec laration.

var obj = {
    id: "awesome",
    cool: function coolFn() {
        console.log(this.id);
    }
};
var id = "not awesome"
obj.cool(); // awesome
setTimeout(obj.cool, 100); // not awesome

// The problem is the loss of this binding on the cool() function. There are various ways to address that problem, but one often-repeated solution is var self = this; . That might look like:
var obj = {
    count: 0,
    cool: function coolFn() {
        var self = this;
        if (self.count < 1) {
            setTimeout(function timer() {
                self.count++;
                console.log("awesome?");
            }, 100);
        }
    }
};
obj.cool(); // awesome?

// The ES6 solution, the arrow function, introduces a behavior called lexical this .
var obj = {
    count: 0,
    cool: function coolFn() {
        if (this.count < 1) {
            setTimeout(() => { // arrow-function ftw?
                this.count++;
                console.log("awesome?");
            }, 100);
        }
    }
};
obj.cool(); // awesome?


// The short explanation is that arrow functions do not behave at all like normal functions when it comes to their this binding. They discard all the normal rules for this binding, and instead take on the this value of their immediate lexical enclosing scope, whatever it is.

// So, in that snippet, the arrow function doesn’t get its this unbound in some unpredictable way, it just “inherits” the this binding of the cool() function (which is correct if we invoke it as shown!).

// One other detraction from arrow functions is that they are anonymous

// A more appropriate approach, in my perspective, to this “problem,” is to use and embrace the this mechanism correctly.
var obj = {
    count: 0,
    cool: function coolFn() {
        if (this.count < 1) {
            setTimeout(function timer() {
                this.count++; // `this` is safe
                // because of `bind(..)`
                console.log("more awesome");
            }.bind(this), 100); // look, `bind()`!
        }
    }
};
obj.cool(); // more awesome

/*********************************************************************************************** */
/*********************************************************************************************** */
/*********************************************************************************************** */

// Part - 3 this & Object Prototypes

// CHAPTER 1 this or That?

function identify() {
    return this.name.toUpperCase();
}
function speak() {
    var greeting = "Hello, I'm " + identify.call(this);
    console.log(greeting);
}
var me = {
    name: "Kyle"
};
var you = {
    name: "Reader"
};
identify.call(me); // KYLE
identify.call(you); // READER
speak.call(me); // Hello, I'm KYLE
speak.call(you); // Hello, I'm READER

// This code snippet allows the identify() and speak() functions to be reused against multiple context objects ( me and you ), rather than needing a separate version of the function for each object.

// This code snippet allows the identify() and speak() functions to be reused against multiple context objects ( me and you ), rather than needing a separate version of the function for each object.

// However, the this mechanism provides a more elegant way of implicitly “passing along” an object reference, leading to cleaner API
// design and easier reuse.
// The more complex your usage pattern is, the more clearly you’ll see that passing context around as an explicit parameter is often messier than passing around a this context.

// To learn this , you first have to learn what this is not, despite any assumptions or misconceptions that may lead you down those paths. this is neither a reference to the function itself, nor is it a reference to the function’s lexical scope.

// Fact : 
// When a function is invoked, an activation record, otherwise known as an execution context, is created. This record contains information about where the function was called from (the call-stack), how the function was invoked, what parameters were passed, etc. One of the properties of this record is the this reference, which will be used for the duration of that function’s execution.

// this is actually a binding that is made when a function is invoked, and what it references is determined entirely by the call-site where the function is called.

/*********************************************************************************************** */
// Chapter - 2 this All Makes Sense Now!
// To understand this binding, we have to understand the call-site: the location in code where a function is called (not where it’s declared). We must inspect the call-site to answer the question: what is this this a reference to?

function baz() {
    // call-stack is: `baz`
    // so, our call-site is in the global scope
    console.log("baz");
    bar(); // <-- call-site for `bar`
}
function bar() {
    // call-stack is: `baz` -> `bar`
    // so, our call-site is in `baz`
    console.log("bar");
    foo(); // <-- call-site for `foo`
}
function foo() {
    // call-stack is: `baz` -> `bar` -> `foo`
    // so, our call-site is in `bar`
    console.log("foo");
}
baz(); // <-- call-site for `baz`


// We turn our attention now to how the call-site determines where this will point during the execution of a function.
// You must inspect the call-site and determine which of four rules applies.

// 1. Default Binding : The first rule we will examine comes from the most common case of function calls: standalone function invocation. Variables declared in the global scope, as var a = 2 is, are synonymous with global-object properties of the same name.

function foo() {
    console.log(this.a);
}
var a = 2;
foo(); // 2

// We see that when foo() is called, this.a resolves to our global variable a . Why? Because in this case, the default binding for this applies to the function call as foo() is called with a plain, undecorated function reference

// If strict mode is in effect (strict has to be inside foo or global), the global object is not eligible for the default binding, so the this is instead set to undefined :
function foo() {
    "use strict";
    console.log(this.a);
}
var a = 2;
foo(); // TypeError: `this` is `undefined`

// The first rule does not seem to be working

//2. Implicit Binding : Another rule to consider is whether the call-site has a context object, also referred to as an owning or containing object.

function foo() {
    console.log(this.a);
}
var obj = {
    a: 2,
    foo: foo
};
obj.foo(); // 2
// foo() is called, it’s preceeded by an object reference to obj . When there is a context object for a function reference, the implicit binding rule says that it’s that object that should be used for the function call’s this binding. Because obj is the this for the foo() call, this.a is synonymous with obj.a .

// Only the top / last level of an object property reference chain matters to the call - site.For instance:
function foo() {
    console.log(this.a);
}
var obj2 = {
    a: 42,
    foo: foo
};
var obj1 = {
    a: 2,
    obj2: obj2
};
obj1.obj2.foo(); // 42

// Implicitly lost : One of the most common frustrations that this binding creates is when an implicitly bound function loses that binding, which usually means it falls back to the default binding

function foo() {
    console.log(this.a);
}
var obj = {
    a: 2,
    foo: foo
};
var bar = obj.foo; // function reference/alias!
var a = "oops, global"; // `a` also property on global object
bar(); // "oops, global" undefined
// Even though bar appears to be a reference to obj.foo , in fact, it’s really just another reference to foo itself. Moreover, the call-site is what matters, and the call-site is bar() , which is a plain, undecorated call, and thus the default binding applies.

// The more subtle, more common, and more unexpected way this occurs is when we consider passing a callback function: Parameter passing is just an implicit assignment, and since we’re passing a function, it’s an implicit reference assignment, so the end result is the same as the previous snippet.

function foo() {
    console.log(this.a);
}
function doFoo(fn) {
    // `fn` is just another reference to `foo`
    fn(); // <-- call-site!
}
var obj = {
    a: 2,
    foo: foo
};
var a = "oops, global"; // `a` also property on global object
doFoo(obj.foo); // "oops, global" or  undefined

// another way that this can surprise us is when the function we’ve passed our callback to intentionally changes the this for the call.

// 3. Explicit Binding : With implicit binding, as we just saw, we had to mutate the object in question to include a reference on itself to the function, and use this property function reference to indirectly (implicitly) bind this to the object.

// But, what if you want to force a function call to use a particular object for the this binding, without putting a property function reference on the object?
// “All” functions in the language have some utilities available to them (via their [[Prototype]] —more on that later), which can be useful for this task. Specifically, functions have call(..) and apply(..) methods.

// Both call and apply take, as their first parameter, an object to use for the this , and then invoke the function with that this specified. Since you are directly stating what you want the this to be, we call it explicit binding.

function foo() {
    console.log(this.a);
}
var obj = {
    a: 2
};
foo.call(obj); // 2

// Invoking foo with explicit binding by foo.call(..) allows us to force its this to be obj.
// If you pass a simple primitive value (of type string , boolean , or num ber ) as the this binding, the primitive value is wrapped in its object form ( new String(..) , new Boolean(..) , or new Number(..) , respectively). This is often referred to as “boxing.”

// Hard Binding 

function foo(something) {
    console.log(this.a, something);
    return this.a + something;
}
var obj = {
    a: 2
};
var bar = foo.bind(obj);
var b = bar(3); // 2 3
console.log(b); // 5
// bind(..) returns a new function that is hardcoded to call the original function with the this context set as you specified.

// Many libraries’ functions, and indeed many new built-in functions in the JavaScript language and host environment, provide an optional parameter, usually called “context,” which is designed as a workaround for you not having to use bind(..) to ensure your  callback function uses a particular this . For instance:
function foo(el) {
    console.log(el, this.id);
}
var obj = {
    id: "awesome"
};
// use `obj` as `this` for `foo(..)` calls
[1, 2, 3].forEach(foo, obj);
// 1 awesome 2 awesome 3 awesome

// Internally, these various functions almost certainly use explicit binding via call(..) or apply(..) , saving you the trouble.

//4. new Binding : The fourth and final rule for this binding requires us to rethink a very common misconception about functions and objects in JavaScript.

// In traditional class-oriented languages, “constructors” are special methods attached to classes, and when the class is instantiated with a new operator, the constructor of that class is called. This usually looks something like:
something = new MyClass(..);

//However new usage in JS has no connection to class-oriented functionality. 
// In JS, constructors are just functions that happen to be called with the new operator in front of them. They are not attached to classes, nor are they instantiating a class. They are not even special types of functions. They’re just regular functions that are, in essence, hijacked by the use of their new in their invocation.

// When a function is invoked with new in front of it, otherwise known as a constructor call, the following things are done automatically:
// 1. A brand new object is created (aka constructed) out of thin air.
// 2. The newly constructed object is [[Prototype]]-linked.
// 3. The newly constructed object is set as the this binding for that function call.
// 4. Unless the function returns its own alternate object, the new-invoked function call will automatically return the newly constructed object.

// Consider this code:

function foo(a) {
    this.a = a;
}
var bar = new foo(2);
console.log(bar.a); // 2

// By calling foo(..) with new in front of it, we’ve constructed a new object and set that new object as the this for the call of foo(..). So new is the final way that a function call’s this can be bound. We’ll call this new binding.

// now we’ve uncovered the four rules for binding this in function calls. All you need to do is find the call-site and inspect it to see which rule applies. But, what if the call-site has multiple eligible rules? There must be an order of precedence to these rules, and so we will next demonstrate what order to apply the rules.

// It should be clear that the default binding is the lowest priority rule of the four. So we’ll just set that one aside. Which is more precedent, implicit binding or explicit binding? Let’s /test it:

function foo() {
    console.log(this.a);
}
var obj1 = {
    a: 2,
    foo: foo
};
var obj2 = {
    a: 3,
    foo: foo
};
obj1.foo(); // 2
obj2.foo(); // 3
obj1.foo.call(obj2); // 3
obj2.foo.call(obj1); // 2

// So, explicit binding takes precedence over implicit binding, which means you should ask first if explicit binding applies before checking for implicit binding.


// Now, we just need to figure out where new binding fits in the precedence:


function foo(something) {
    this.a = something;
}
var obj1 = {
    foo: foo
};
var obj2 = {};
obj1.foo(2);
console.log(obj1.a); // 2
obj1.foo.call(obj2, 3);
console.log(obj2.a); // 3
var bar = new obj1.foo(4);
console.log(obj1.a); // 2
console.log(bar.a); // 4


// OK, new binding is more precedent than implicit binding. But do you think new binding is more or less precedent than explicit binding?
// new and call / apply cannot be used together, so new foo.call(obj1) is not allowed to test new binding directly against explicit binding. But we can still use a hard binding to test the precedence of the two rules.

function foo(something) {
    this.a = something;
}
var obj1 = {};
var bar = foo.bind(obj1);
bar(2);
console.log(obj1.a); // 2
var baz = new bar(3);
console.log(obj1.a); // 2
console.log(baz.a); // 3


// Now, we can summarize the rules for determining this from a function call’s call-site, in their order of precedence.

// 1. Is the function called with new (new binding)? If so, this is the newly constructed object.
// var bar = new foo()
// 2. Is the function called with call or apply (explicit binding), even hidden inside a bind hard binding? If so, this is the explicitly specified object.
// var bar = foo.call( obj2 )
// 3. Is the function called with a context (implicit binding), otherwise known as an owning or containing object? If so, this is that context object.
// var bar = obj1.foo()
// 4. Otherwise, default the this (default binding). If in strict mode , pick undefined , otherwise pick the global object.
// var bar = foo()

// Binding Exceptions
// As usual, there are some exceptions to the “rules.”

// If you pass null or undefined as a this binding parameter to call, apply, or bind, those values are effectively ignored, and instead the default binding rule applies to the invocation

function foo() {
    console.log(this.a);
}
var a = 2;
foo.call(null); // 2


// Why would you intentionally pass something like null for a this binding ?
// t’s quite common to use apply(..) for spreading out arrays of values as parameters to a function call.Similarly, bind(..) can curry parameters(preset values), which can be very helpful:

function foo(a, b) {
    console.log("a:" + a + ", b:" + b);
}
// spreading out array as parameters
foo.apply(null, [2, 3]); // a:2, b:3
// currying with `bind(..)`
var bar = foo.bind(null, 2);
bar(3); // a:2, b:3

// Both these utilities require a this binding for the first parameter. If the functions in question don’t care about this , you need a placeholder value, and null might seem like a reasonable choice as shown in this snippet.

// However, there’s a slight hidden “danger” in always using null when you don’t care about the this binding. If you ever use that against a function call (for instance, a third-party library function that you don’t control), and that function does make a this reference, the default binding rule means it might inadvertently reference (or worse, mutate!) the global object ( window in the browser).

// Another thing to be aware of is that you can (intentionally or not!) create “indirect references” to functions, and in those cases, when that function reference is invoked, the default binding rule also applies.

function foo() {
    console.log(this.a);
}
var a = 2;
var o = { a: 3, foo: foo };
var p = { a: 4 };
o.foo(); // 3
(p.foo = o.foo)(); // 2
// The result value of the assignment expression p.foo = o.foo is a reference to just the underlying function object. call-site is just foo() , not p.foo() or o.foo() as you might expect. Per the rules mentioned earlier, the default binding rule applies.

// Lexical this
Arrow - functions are signified not by the function keyword, but by the so - called “fat arrow” operator, => .Instead of using the four standard this rules, arrow - functions adopt the this binding from the enclosing(function or global) scope.

function foo() {
    // return an arrow function
    return (a) => {
        // `this` here is lexically inherited from `foo()`
        console.log(this.a);
    };
}
var obj1 = {
    a: 2
};
var obj2 = {
    a: 3
};
var bar = foo.call(obj1);
bar.call(obj2); // 2, not 3! 
// The lexical binding of an arrow-function cannot be overridden (even with new !).

// Pre-ES6, we already have a fairly common pattern for doing so, which is basically almost indistinguishable from the spirit of ES6 arrow-functions:
function foo() {
    var self = this; // lexical capture of `this`
    setTimeout(function () {
        console.log(self.a);
    }, 100);
}
var obj = {
    a: 2
};
foo.call(obj); // 2

// While self = this and arrow - functions both seem like good “solutions” to not wanting to use bind(..), they are essentially fleeing from this instead of understanding and embracing it.

/********************************************************************************************************************************** */
/********************************************************************************************************************************** */
/********************************************************************************************************************************** */
// CHAPTER 3 Objects

Objects come in two forms: the declarative (literal) form and the constructed form.
// The literal syntax for an object looks like this:
var myObj = {
key: value
// ...
};
// The constructed form looks like this:
var myObj = new Object();
myObj.key = value;

// Objects are the general building block upon which much of JS is built. They are one of the six primary types (called “language types” in the specification) in JS:
• string
• number
• boolean
• null
• undefined
• object

// Note that the simple primitives ( string , boolean , number , null , and undefined ) are not themselves objects . null is sometimes referred to as an object type, but this misconception stems from a bug

// It’s a common misstatement that “everything in JavaScript is an object.” This is clearly not true.

// function is a subtype of object (technically, a “callable object”). Functions in JS are said to be “first class” in that they are basically just normal objects (with callable behavior semantics bolted on), and so they can be handled like any other plain object.

// Arrays are also a form of objects, with extra behavior. The organization of contents in arrays is slightly more structured than for general objects.

// Built-in Objects
// There are several other object subtypes, usually referred to as built-in objects. For some of them, their names seem to imply they are directly related to their simple primitive counterparts, but in fact, their relationship is more complicated

• String
• Number
• Boolean
• Object
• Function
• Array
• Date
• RegExp
• Error












/// Important :To remmebr
/*


var bar = foo.bind(obj);
bind(..) returns a new function that is hardcoded to call the original function with the this context set as you specified.


*/