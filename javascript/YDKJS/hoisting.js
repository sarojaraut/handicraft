
a = 2;
var a;
console.log(a); // output 2

console.log(b); // output undefined
var b = 2;

// When you see var a = 2; , you probably think of that as one statement. But JavaScript actually thinks of it as two statements: var a; and a = 2; . The first statement, the declaration, is processed during the compilation phase. The second statement, the assignment, is left in place for the execution phase.

// Only the declarations themselves are hoisted, while any assignments or other executable logic are left in place.
// It’s also important to note that hoisting is per-scope. variables inside a function are hoisted to the top of function not to the top of global
// Function declarations are hoisted, as we just saw. But function expressions are not.

foo(); // not ReferenceError, but TypeError!
var foo = function bar() {
    // ...
};

// The variable identifier foo is hoisted and attached to the enclosing scope (global) of this program, so foo() doesn’t fail as a ReferenceError . But foo has no value yet (as it would if it had been a true function declaration instead of expression). So, foo() is attempting to invoke the undefined value, which is a TypeError illegal operation.

// Both function declarations and variable declarations are hoisted. But a subtle detail (that can show up in code with multiple “duplicate” declarations) is that functions are hoisted first, and then variables.

foo(); // 1
var foo;
function foo() {
    console.log(1);
}
foo = function () {
    console.log(2);
};
// 1 is printed instead of 2! This snippet is interpreted by the Engine as:
function foo() {
    console.log(1);
}
foo(); // 1
foo = function () {
    console.log(2);
};

// Notice that var foo was the duplicate (and thus ignored) declaration, even though it came before the function foo()... declaration, because function declarations are hoisted before normal variables.

// While multiple/duplicate var declarations are effectively ignored, subsequent function declarations do override previous ones.

/**************************************************************************************** */
/**************************************************************************************** */
/**************************************************************************************** */
// CHAPTER 5 - Scope Closure

