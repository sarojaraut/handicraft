alert("Hello World");

console.log();

java script added to the script section of html 

<script src="./script.js"></script>

<script>
alert("Hello World");
</script>

"use strict"

//Variables

num = 10;

console.log(num);
console.log(winndow.num);

var employee = 'Saroj'; // double quotes can also be used instead of single quote for strings but use consistently
console.log(employee);

let salary = 3000; 
// scope of a var variable is the entire enclosing function where as let is in the the block in which they are defined,
console.log(salary);

const dept = {name : 'Comp'};
dept.name = 'Sales'; // allowed even if  declared object is constant

const veg = Object.freeze({name:'Tomato'})
veg.name='pea'; // does nothing
console.log(veg);

/*

var : function scope
let : block scope
const : block scope
"use strict" : enforces extra validations

primitive data types
boolean
null
undefined
number
bigint
string
symbol


equality
==  type conversion + equality
=== equality
!= not equal
Almost always ===!

Collection 

Array - Indexed collection 
Map - Key collection
Set - Key collection unique

*/

let maxnum = Number.MAX_SAFE_INTEGER   
var person = {name :'Saroj', job:'Developer;'}
console.log(person);
console.log(person.name);
for (const property in person)[
    console.log(proterty);
]

let veggies = [];
veggies[0] = 'Tamoto';
veggies.push('Pea'); //add at the end
veggies.unshift('Beet');// add at the begning

let departments = new Map();
departments.set('10',{name:'Accounting'});
departments.set('10',{name:'Sales'});
departments.set('10',{name:'Operations'});

for (const key of departments.keys() ){
    console.log(keys);
}

for (const value of departments.values() ){
    console.log(value);
}

for (const department of departments ){
    // destructring values out of an array
    let [deptno, dept] = department;

    //destructring value out of the object
}

Operator Type	  Operators
Assignment      	=, +=, -=, *=, /=, %=
Arithmetic      	+, -, *, /, %, ++, --
Comparison	        ==, ===, !=, !==, >, <, >=, <=
Logical	            &&, ||, !

if (msg === 'bye') {
    fun = false;
}

for (var x = 0; x < things.length; x += 1) {
    console.log(things[x]);
}

// Objects and functions

var person = {
    first: 'Hello',
    last: 'World'
};

function sayHello(p) {
    console.log('Hi ' + p.first + ' ' + p.last);
}

sayHello(person);

// You can execute the above block from console


