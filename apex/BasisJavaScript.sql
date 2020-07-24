BasicJavaScript

Identifiers are case sensitive.

// Two slashes start single-line comments and /* and */ is multi line comment
var x;  // declaring a variable
var foo = 6; // declaring a variable and assigning 
foo = 4;  // changing the value of existing variable foo

x = 3 + y;  // assigning a value to the variable `x`
Compound Assignment Operators : The following two assignments are equivalent: 
x += 1;
x = x + 1;

foo(x, y);  // calling function `foo` with parameters `x` and `y`
obj.bar(3);  // calling method `bar` of object `obj`

// A conditional statement
if (x === 0) {  // Is `x` equal to zero?
    x = 123;
}

// Defining function `baz` with parameters `a` and `b`
function baz(a, b) {
    return a + b;
}

A single equals sign (=) is used to assign a value to a variable. 
A triple equals sign (===) is used to compare two values

Equality Operators : JavaScript has two kinds of equality:

Normal, or �lenient,� (in)equality: == and != 
Strict (in)equality: === and !== 

Normal equality considers (too) many values to be equal (the details are explained in Normal (Lenient) Equality (==, !=)), which can hide bugs. Therefore, always using strict equality is recommended.

JavaScript has two different ways to do if-then-else�either as a statement:
var x;
if (y >= 0) {
    x = y;
} else {
    x = -y;
}

or as an expression: var x = y >= 0 ? y : -y;

Semicolons are optional in JavaScript. However, recommend to including them always, because otherwise JavaScript can guess wrong about the end of a statement

All values in JavaScript have properties. Each property has a key (or name) and a value. You can think of properties like fields of a record. You use the dot (.) operator to read a property: value.propKey

For example, the string 'abc' has the property length:
> var str = 'abc';
> str.length
3

The preceding can also be written as:
> 'abc'.length

The dot operator is also used to assign a value to a property:
> var obj = {};  // empty object
> obj.foo = 123; // create property `foo`, set it to 123
123
> obj.foo
123

And you can use it to invoke methods:
> 'hello'.toUpperCase()
'HELLO'

avaScript makes a somewhat arbitrary distinction between values:

? The primitive values are booleans, numbers, strings, null, and undefined. 
? All other values are objects. 

A major difference between the two is how they are compared; each object has a unique identity and is only (strictly) equal to itself:
> var obj1 = {};  // an empty object
> var obj2 = {};  // another empty object
> obj1 === obj2
false
> obj1 === obj1
true

In contrast, all primitive values encoding the same value are considered the same:
> var prim1 = 123;
> var prim2 = 123;
> prim1 === prim2
true

Primitives have the following characteristics:

1. Compared by value 
The �content� is compared: 
> 3 === 3
true
> 'abc' === 'abc'
true
2. Always immutable  : Properties can�t be changed, added, or removed: 

> var str = 'abc';

> str.length = 1; // try to change property `length`
> str.length      // ? no effect
3

> str.foo = 3; // try to create property `foo`
> str.foo      // ? no effect, unknown property
undefined

Objects

All nonprimitive values are objects. The most common kinds of objects are:


? Plain objects, which can be created by object literals (see Single Objects): 
{
    firstName: 'Jane',
    lastName: 'Doe'
}

The preceding object has two properties: the value of property firstName is 'Jane' and the value of property lastName is 'Doe'.


? Arrays, which can be created by array literals (see Arrays): 
[ 'apple', 'banana', 'cherry' ]

The preceding array has three elements that can be accessed via numeric indices. For example, the index of 'apple' is 0.


Regular expressions, which can be created by regular expression literals (see Regular Expressions): 
/^a+b+$/

Objects have the following characteristics:

1. Compared by reference 
Identities are compared; every value has its own identity: 
> ({} === {})  // two different empty objects
false

> var obj1 = {};
> var obj2 = obj1;
> obj1 === obj2
true

2. Mutable by default 
You can normally freely change, add, and remove properties (see Single Objects): 
> var obj = {};
> obj.foo = 123; // add property `foo`
> obj.foo
123

3. undefined and null
Most programming languages have values denoting missing information. JavaScript has two such �nonvalues,� undefined and null:

undefined means �no value.� Uninitialized variables are undefined: 
> var foo;
> foo
undefined

Missing parameters are undefined:
> function f(x) { return x }
> f()
undefined

If you read a nonexistent property, you get undefined:
> var obj = {}; // empty object
> obj.foo
undefined

null means �no object.� It is used as a nonvalue whenever an object is expected (parameters, last in a chain of objects, etc.). 

Warning : undefined and null have no properties, not even standard methods such as toString().

Checking for undefined or null
You can do the same via an explicit check:
if (x === undefined || x === null) {
    ...
}

You can also exploit the fact that both undefined and null are considered false:

if (!x) {
    ...
}

Warning : false, 0, NaN, and '' are also considered false.

Categorizing Values Using typeof and instanceof

There are two operators for categorizing values: typeof is mainly used for primitive values, while instanceof is used for objects. 
typeof looks like this: typeof value

typeof looks like this:
typeof value

It returns a string describing the �type� of value. Here are some examples:
> typeof true
'boolean'
> typeof 'abc'
'string'
> typeof {} // empty object literal
'object'
> typeof [] // empty array literal
'object'

The following table lists all results of typeof:

Operand   >> Result 


undefined >> 'undefined'
null  >> 'object'
Boolean value >> 'boolean'
Number value >> 'number'
String value >> 'string'
Function  >> 'function'
All other normal values >> 'object'
(Engine-created value) >> JavaScript engines are allowed to create values for which typeof returns arbitrary strings (different from all results listed in this table).
 
typeof null returning 'object' is a bug that can�t be fixed, because it would break existing code. It does not mean that null is an object.
 
instanceof looks like this:
value instanceof Constr

It returns true if value is an object that has been created by the constructor Constr

> var b = new Bar();  // object created by constructor Bar
> b instanceof Bar
true

> {} instanceof Object
true
> [] instanceof Array
true
> [] instanceof Object  // Array is a subconstructor of Object
true

> undefined instanceof Object
false
> null instanceof Object
false

Booleans

The primitive boolean type comprises the values true and false. The following operators produce booleans:

Binary logical operators: && (And), || (Or) 
Prefix logical operator: ! (Not) 

Comparison operators: 

Equality operators: ===, !==, ==, != 
Ordering operators (for strings and numbers): >, >=, <, <= 


Truthy and Falsy

Whenever JavaScript expects a boolean value (e.g., for the condition of an if statement), any value can be used. It will be interpreted as either true or false. The following values are interpreted as false. The following values are interpreted as false:

? undefined, null 
? Boolean: false 
? Number: 0, NaN 
? String: '' 

All other values (including all objects!) are considered true. Values interpreted as false are called falsy, and values interpreted as true are called truthy. Boolean(), called as a function, converts its parameter to a boolean. You can use it to test how a value is interpreted:
> Boolean(undefined)
false
> Boolean(0)
false
> Boolean(3)
true
> Boolean({}) // empty object
true
> Boolean([]) // empty array
true




Binary Logical Operators

Binary logical operators in JavaScript are short-circuiting. That is, if the first operand suffices for determining the result, the second operand is not evaluated. For example, in the following expressions, the function foo() is never called:
false && foo()
true  || foo()

And (&&) : If the first operand is falsy, return it. Otherwise, return the second operand: 
Or (||)  : If the first operand is truthy, return it. Otherwise, return the second operand:




Numbers

All numbers in JavaScript are floating-point:
> 1 === 1.0
true
NaN (�not a number�) 
> Number('xyz')  // 'xyz' can�t be converted to a number
NaN
Infinity 
Also mostly an error value: 
> 3 / 0
Infinity
> Math.pow(2, 1024)  // number too large
Infinity

Operators

JavaScript has the following arithmetic operators (see Arithmetic Operators):

? Addition: number1 + number2 
? Subtraction: number1 - number2 
? Multiplication: number1 * number2 
? Division: number1 / number2 
? Remainder: number1 % number2 
? Increment: ++variable, variable++ 
? Decrement: --variable, variable-- 
? Negate: -value 
? Convert to number: +value 

Strings

Strings can be created directly via string literals. Those literals are delimited by single or double quotes. The backslash (\) escapes characters and produces a few control characters. Here are some examples:
'abc'
"abc"

'Did she say "Hello"?'
"Did she say \"Hello\"?"

'That\'s nice!'
"That's nice!"

'Line 1\nLine 2'  // newline
'Backlash: \\'

Single characters are accessed via square brackets:
> var str = 'abc';
> str[1]
'b'

The property length counts the number of characters in the string:
> 'abc'.length
3

Like all primitives, strings are immutable; you need to create a new string if you want to change an existing one.


String Operators

Strings are concatenated via the plus (+) operator, which converts the other operand to a string if one of the operands is a string:
> var messageCount = 3;
> 'You have ' + messageCount + ' messages'
'You have 3 messages'

String Methods

Strings have many useful methods (see String Prototype Methods). Here are some examples:
> 'abc'.slice(1)  // copy a substring
'bc'
> 'abc'.slice(1, 2)
'b'

> '\t xyz  '.trim()  // trim whitespace
'xyz'

> 'mj�lnir'.toUpperCase()
'MJ�LNIR'

> 'abc'.indexOf('b')  // find a string
1
> 'abc'.indexOf('x')
-1

Conditionals >> compared to "elsif" or plsql and brace in place of "end;" 
if (myvar === 0) {
    // then
} else if (myvar === 1) {
    // else-if
} else if (myvar === 2) {
    // else-if
} else {
    // else
}

Always recomended using braces (they denote blocks of zero or more statements). But you don�t have to do so if a clause is only a single statement (the same holds for the control flow statements for and while): compares to case () when then end clause of plsql. ensure : and break;

switch (fruit) {
    case 'banana':
        // ...
        break;
    case 'apple':
        // ...
        break;
    default:  // all other cases
        // ...
}

The �operand� after case can be any expression; it is compared via === with the parameter of switch.




Loops

The for loop has the following format:
for (�init�; �condition�; �post_iteration�)
    �statement�
init is executed at the beginning of the loop. condition is checked before each loop iteration; if it becomes false, then the loop is terminated. post_iteration is executed after each loop iteration.
for (var i=0; i < arr.length; i++) {
    console.log(arr[i]);
}

var i = 0;
while (i < arr.length) {
    console.log(arr[i]);
    i++;
}

do {
    // ...
} while (condition);

In all loops:

? break leaves the loop. 
? continue starts a new loop iteration.

Functions

One way of defining a function is via a function declaration:
function add(param1, param2) {
    return param1 + param2;
}

This is how you call that function:
> add(6, 1)
7

Another way of defining add() is by assigning a function expression to a variable add:
var add = function (param1, param2) {
    return param1 + param2;
};


The Special Variable arguments

You can call any function in JavaScript with an arbitrary amount of arguments; the language will never complain. It will, however, make all parameters available via the special variable arguments. arguments looks like an array, but has none of the array methods:
> function f() { return arguments }
> var args = f('a', 'b', 'c');
> args.length
3
> args[0]  // read element at index 0
'a'

Too Many or Too Few Arguments
function f(x, y) {
    console.log(x, y);
    return toArray(arguments);
}

Additional parameters will be ignored (except by arguments):
> f('a', 'b', 'c')
a b
[ 'a', 'b', 'c' ]

Missing parameters will get the value undefined:
> f('a')
a undefined
[ 'a' ]
> f()
undefined undefined
[]

Optional Parameters

The following is a common pattern for assigning default values to parameters:
function pair(x, y) {
    x = x || 0;  // (1)
    y = y || 0;
    return [ x, y ];
}

In line (1), the || operator returns x if it is truthy (not null, undefined, etc.). Otherwise, it returns the second operand:

Enforcing an Arity

If you want to enforce an arity (a specific number of parameters), you can check arguments.length:
function pair(x, y) {
    if (arguments.length !== 2) {
        throw new Error('Need exactly 2 arguments');
    }
    ...
}

Converting arguments to an Array

arguments is not an array, it is only array-like (see Array-Like Objects and Generic Methods). It has a property length, and you can access its elements via indices in square brackets. You cannot, however, remove elements or invoke any of the array methods on it. Thus, you sometimes need to convert arguments to an array, which is what the following function does (it is explained in Array-Like Objects and Generic Methods):
function toArray(arrayLikeObject) {
    return Array.prototype.slice.call(arrayLikeObject);
}

Exception Handling

The most common way to handle exceptions (see Chapter 14) is as follows:
function getPerson(id) {
    if (id < 0) {
        throw new Error('ID must not be negative: '+id);
    }
    return { id: id }; // normally: retrieved from database
}

function getPersons(ids) {
    var result = [];
    ids.forEach(function (id) {
        try {
            var person = getPerson(id);
            result.push(person);
        } catch (exception) {
            console.log(exception);
        }
    });
    return result;
}

The try clause surrounds critical code, and the catch clause is executed if an exception is thrown inside the try clause. Using the preceding code

Strict Mode

Strict mode (see Strict Mode) enables more warnings and makes JavaScript a cleaner language (nonstrict mode is sometimes called �sloppy mode�). To switch it on, type the following line first in a JavaScript file or a <script> tag:
'use strict';

Variable Scoping and Closures

In JavaScript, you declare variables via var before using them:
> var x;
> x
undefined

You can declare and initialize several variables with a single var statement:
var x = 1, y = 2, z = 3;

But I recommend using one statement per variable (the reason is explained in Syntax). Thus, I would rewrite the previous statement to:
var x = 1;
var y = 2;
var z = 3;

Variables Are Function-Scoped

The scope of a variable is always the complete function (as opposed to the current block). For example:
function foo() {
    var x = -512;
    if (x < 0) {  // (1)
        var tmp = -x;
        ...
    }
    console.log(tmp);  // 512
}

We can see that the variable tmp is not restricted to the block starting in line (1); it exists until the end of the function.




Variables Are Hoisted

Each variable declaration is hoisted: the declaration is moved to the beginning of the function, but assignments that it makes stay put. As an example, consider the variable declaration in line (1) in the following function:
function foo() {
    console.log(tmp); // undefined
    if (false) {
        var tmp = 3;  // (1)
    }
}

Internally, the preceding function is executed like this:
function foo() {
    var tmp;  // hoisted declaration
    console.log(tmp);
    if (false) {
        tmp = 3;  // assignment stays put
    }
}

Single Objects
In JavaScript, you can directly create plain objects, via object literals:
'use strict';
var jane = {
    name: 'Jane',

    describe: function () {
        return 'Person named '+this.name;
    }
};

The preceding object has the properties name and describe. You can read (�get�) and write (�set�) properties:
> jane.name  // get
'Jane'
> jane.name = 'John';  // set
> jane.newProperty = 'abc';  // property created automatically


Function-valued properties such as describe are called methods. They use this to refer to the object that was used to call them:
> jane.describe()  // call method
'Person named John'
> jane.name = 'Jane';
> jane.describe()
'Person named Jane'

The in operator checks whether a property exists:
> 'newProperty' in jane
true
> 'foo' in jane
false

If you read a property that does not exist, you get the value undefined. Hence, the previous two checks could also be performed like this:[2]
> jane.newProperty !== undefined
true
> jane.foo !== undefined
false

The delete operator removes a property:
> delete jane.newProperty
true
> 'newProperty' in jane
false

Square brackets also allow you to compute the key of a property:
> var obj = { hello: 'world' };
> var x = 'hello';

> obj[x]
'world'
> obj['hel'+'lo']
'world'

Array Literals

Array literals are handy for creating arrays:
> var arr = [ 'a', 'b', 'c' ];

> arr[0]
'a'
> arr[0] = 'x';
> arr
[ 'x', 'b', 'c' ]

> arr.length
3
> arr[arr.length] = 'd';
> arr
[ 'a', 'b', 'c', 'd' ]

The in operator works for arrays, too:
> var arr = [ 'a', 'b', 'c' ];
> 1 in arr // is there an element at index 1?
true
> 5 in arr // is there an element at index 5?
false

Note that arrays are objects and can thus have object properties:
> var arr = [];
> arr.foo = 123;
> arr.foo
123


Array Methods
> var arr = [ 'a', 'b', 'c' ];
> arr.push('x')  // append an element
4
> arr
[ 'a', 'b', 'c', 'x' ]
> arr.pop()  // remove last element
'x'
> arr
[ 'a', 'b', 'c' ]
> arr.shift()  // remove first element
'a'
> arr
[ 'b', 'c' ]
> arr.unshift('x')  // prepend an element
3
> arr
[ 'x', 'b', 'c' ]
> arr.indexOf('b')  // find the index of an element
1
> arr.indexOf('y')
-1

> arr.join('-')  // all elements in a single string
'x-b-c'
> arr.join('')
'xbc'
> arr.join()
'x,b,c'

Iterating over Arrays

There are several array methods for iterating over elements . The two most important ones are forEach and map.

forEach iterates over an array and hands the current element and its index to a function:
[ 'a', 'b', 'c' ].forEach(
    function (elem, index) {  // (1)
        console.log(index + '. ' + elem);
    });

The preceding code produces the following output:
0. a
1. b
2. c

Note that the function in line (1) is free to ignore arguments. It could, for example, only have the parameter elem.

map creates a new array by applying a function to each element of an existing array:
> [1,2,3].map(function (x) { return x*x })
[ 1, 4, 9 ]

Regular Expressions

Method test(): Is There a Match?
> /^a+b+$/.test('aaab')
true
> /^a+b+$/.test('aaa')
false

Method exec(): Match and Capture Groups
> /a(b+)a/.exec('_abbba_aba_')
[ 'abbba', 'bbb' ]

The returned array contains the complete match at index 0, the capture of the first group at index 1, and so on

Method replace(): Search and Replace
> '<a> <bbb>'.replace(/<(.*?)>/g, '[$1]')
'[a] [bbb]'

The first parameter of replace must be a regular expression with a /g flag; otherwise, only the first occurrence is replaced


Java script
Core syntax from java
string array and regular expression from perl
Functions from AWK




http://speakingjs.com/es5/ch01.html#basic_equality_operators

Attrbute Defination
Hierarchy
Data set
Publishing event
Perform a DB Push

Default Hierarchy workflow
Edit transition > submitted to approved automatic earlier manual

Default Hierarchy node workflow - submitted to approved automatic earlier manual (frist element only)
Default Hierarchy unit assignment workflow - submitted to approved automatic earlier manual

There is no Hierarchy in ACTIVE system status

all changed to system

is different user precondition deleted

Hierarchy

jdbc:oracle:thin:@gba71011:10200:AMSTEST
jdbc:oracle:thin:@gba71010:11200:AMSPERF

pa moses > more about mapping of llp changes
cube build > 
Walk through

sqlplus ams_etl/angus@gba71010:11200/AMSPERF

PIy77b9f79


