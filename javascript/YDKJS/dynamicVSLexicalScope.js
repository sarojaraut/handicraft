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