// user function serves as an outer scope that holds the variables username, password and the inner function doLogin()
// these are all private and can't be access from outside world
// Executing User() creates an instance of the User module—a whole new scope is created and thus a whole new copy of these items
// The inner doLogin() function has a closure over username and password , meaning it will retain its access to them even after the User() function finishes running.
function User() {
    let uname, pwd;
    function dologin(username, password) {
        uname = username;
        pwd = password;
        console.log(`username is ${uname}`);
    }
    function showUserName() {
        console.log(`My name is ${uname}`);
    }
    let publicApi = {
        login: dologin,
        whoami: showUserName
    };
    return publicApi;

}

// publicAPI is an object with one property/method on it, login , which is a reference to the inner doLogin() function. 
// When we return publicAPI from User() , it becomes the instance we call user1 .
user1 = User();
// At this point, the outer User() function has finished executing. Normally, you’d think the inner variables like username and password have gone away. But here they have not, because there’s a closure in the login() function keeping them alive.
user1.login("saroj", "pass");
// When we can call user1.login(..) —the same as calling the inner doLogin(..) —and it can still access username and password inner variables
user1.whoami();
//this call shows the username further proof that private variables are retained
user2 = User();
user2.login("ranjan", "pass");
user2.whoami();

// The most common usage of closure is module pattern ike above 

// The this keyword is dynamically bound based on how the function in question is executed, and it turns out there are four simple rules to understand and fully determine this binding.

// 1. foo() ends up setting this to the global object in non-strict mode—in strict mode, this would be undefined and you’d get an error in accessing the bar property—so "global" is the value found for this.bar .
// 2. obj1.foo() sets this to the obj1 object.
// 3. foo.call(obj2) sets this to the obj2 object.
// 4. new foo() sets this to a brand new empty object.

function foo() {
    console.log(this.bar);
}
var bar = "global";
var obj1 = {
    bar: "obj1",
    foo: foo
};
var obj2 = {
    bar: "obj2"
};
// --------
foo();    // "global"

obj1.foo();           // "obj1"
foo.call( obj2 );     // "obj2"
new foo();           // undefined
