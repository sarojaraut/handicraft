// If you try to set a variablethat hasn’t been declared, you’ll either end up creating a variable inthe top-level global scope (bad!) or getting an error, depending on“strict mode” 


// console.log("start =",x); 
// if we uncomment this line this would throw ReferenceError: x is not defined 
// when undeclared variable appears in right hand side of assignment statement(or statement without any LHS) that throws exception error
// but if undeclared variable appear in left hand side of assignment expression then that creates a global variable

// "use strict"; // using this line throws error on line x = 20 ReferenceError: x is not defined
function f() {
    x = 20;
    console.log("within f x=",x);
}
f();
console.log("End =",x); // without "use strict" variable is created n global scope