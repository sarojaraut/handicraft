
https://javascript.info/types

//
typeof undefined // "undefined"
typeof 0 // "number"
typeof 10n // "bigint"
typeof true // "boolean"
typeof "foo" // "string"
typeof Symbol("id") // "symbol"
typeof Math // "object"  (1)
typeof null // "object"  (2)
typeof alert // "function"  (3)

//Nullish coalescing operator '??'

result = (a !== null && a !== undefined) ? a : b;
// above can alsoo be expresssed like this
result = a ?? b

/*
The OR || operator can be used in the same way as ??,

The important difference between them is that:

|| returns the first truthy value.
?? returns the first defined value.

In other words, || doesn’t distinguish between false, 0, an empty string "" and null/undefined. They are all the same – falsy values.
If any of these is the first argument of ||, then we’ll get the second argument as the result.

*/


// The “switch” construct can replace multiple if checks. It uses === (strict equality) for comparisons.

// For instance:

// let age = prompt('Your age?', 18);

switch (age) {
  case 18:
    alert("Won't work"); // the result of prompt is a string, not a number
    break;

  case "18":
    alert("This works!");
    break;

  default:
    alert("Any value not equal to one above");
}

let user = { name: "John" };
let permissions1 = { canView: true,  canEdit: false };
let permissions2 = { canEdit: true };

Object.assign(user, permissions1, permissions2); //{name: 'John', canView: true, canEdit: true}
Object.assign(user, permissions2, permissions1); //{name: 'John', canView: true, canEdit: false}


if (condition1) {
  //  block of code
} else if (condition2) {
  //  block of code
} else {
  //  block of code
}
// Ternary : Short hand if else
const word = count === 1 ? 'item' : 'items';
// Switch
switch (event.key) {
  case 'ArrowUp':
    y = y - 1;
    break;
  case 'ArrowDown':
    y = y + 1;
    break;
  default:
    console.log("That is not a valid move");
    break;
}
// Intervals and Timers
function buzzer() {
  console.log("ENNNNGGGG");
}
setTimeout(buzzer, 500); // runs after half second
setInterval(buzzer, 2000); // runs every 2 seconds
buzzerTimer = setTimeout(buzzer, 500); // runs after half second
buzzerInterval = setInterval(buzzer, 2000); // runs every 2 seconds
clearTimeout(buzzerTimer);
clearInterval(buzzerInterval);


// block scope
let name = "Aarush";
// must have assignment,
const found = true;
// pre-ES6, function/global scope
var age = 12;

// Conditionals

10 > 5 || 10 > 20;    // Logical OR: true
1 > 2 && 2 > 1;    // Logical And : false

=== "Monday" ? price -= 1.5 : price += 1.5;
//Ternary Operator

const food = 'salad';

switch (food) {
  case 'oyster':
    console.log('The taste of the sea 🦪');
    break;
  case 'pizza':
    console.log('A delicious pie 🍕');
    break;
  default:
    console.log('Enjoy your meal');
}


// function
// Defining the function:
function sum(num1, num2) {
  return num1 + num2;
}
// Function expression Anonymous function
// Function expressions are not hoisted
const rocketToMars = function() {
  return 'BOOM!';
}
// Concise arrow functions
const multiply = (a, b) => a * b;
console.log(multiply(2, 30)); // Prints: 60
// Concise arrow functions
const double = a => a * 2;
console.log(double(30)); // Prints: 60
// IIFE :immediately invoked function expression
// Does not pollute the surrounding namespace
// outer variables can't leak inside
(function () {
  console.log("Function called");
  return `Cool IIFE`;
})();

// loops
// break to exit immediately
// coontinue to skip iteration
// While loop
let i = 0;
while (i < 5) {
  console.log(i);
  i++;
}
// Do While loop
x = 0
i = 0
do {
  x = x + i;
  console.log(x)
  i++;
} while (i < 5);

// for loop
for (let i = 0; i < 4; i += 1) {
  if (i===2) continue;
  console.log(i);
};
// Output: 0, 1, 3

// Reverse Loop
const items = ['apricot', 'banana', 'cherry'];
for (let i = items.length - 1; i >= 0; i -= 1) {
  console.log(`${i}. ${items[i]}`);

// for of : sequence of values sourced from iterable
// an iterable is anything that has a length prop
// for in : iterates all enumerable string properties of object
const numbers = [2,3,4]
for (i of numbers) console.log(i) // 2,3,4
for (i in numbers) console.log(i,numbers[i])

const student =  {name : "Aarush", age: 12}
for (i in student) console.log(i) // name, age
for (const [key, value] of Object.entries(student)) {
  console.log(`${key}: ${value}`);
}
console.log(Object.values(student));
for (i in Object.keys(student)) console.log(i)

const vowels =  "aeiou";
for (i of vowels) console.log(i) // a e i o u
for (i in vowels) console.log(i,numbers[i]) // 0 a, 1 e ...
//Iterators

// objects

let mobile = {
  brand: 'Samsung',
  model: 'Galaxy Note 9',
  year: 2010
};

for (let key in mobile) {
  console.log(`${key}: ${mobile[key]}`);
}

delete mobile.year; // or delete mobile[year];

// JavaScript destructuring assignment
const {brand, model} = mobile;

// javascript factory functions

const mobileFactory = (brand, model, year) => {
  return {
    brand: brand,
    model: model,
    year: year,
    boot() {
      console.log('booted!');
    }
  };
};

//getters and setters intercept property access
// restricted interactions with object properties
const myCat = {
  _name: 'DOTTIE',
  get name() {
    return this._name;
  },
  set name(newName) {
    if (newName === newName.toUpperCase()) {
      this._name = newName;
    }else{
      throw "Only uppercase names allowed"
    }
  }
};


// Reference invokes the getter
console.log(myCat.name);

// Assignment invokes the setter
myCat.name = 'Yankee';

// When JavaScript objects are passed as arguments to functions or methods, they are passed by reference, not by value. This means that the object itself (not a copy) is accessible and mutable (can be changed) inside that function.


https://www.codecademy.com/learn/introduction-to-javascript/modules/learn-javascript-introduction/cheatsheet

https://wesbos.com/javascript/04-the-dom/introduction-to-the-dom

// When you write HTML and view it in the browser, the browser turns your HTML into something that is called the Document Object Model or the DOM.
// , and allows us to interface with the DOM via JavaScript.
// window.location
// innerHeight
// innerWidth
// document
// navigator

const p = document.querySelector("p");
const divs = document.querySelectorAll("div");
console.log(p);
console.log(divs);

const heading = document.querySelector('h2');
console.dir(heading.textContent);
// innerText returns only the human readable content whereas textContent will get the contents of all of the elements