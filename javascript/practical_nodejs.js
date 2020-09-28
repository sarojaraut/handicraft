// Install node JS 

sudo apt install nodejs 
sudo apt install npm 

npm -v 
node -v 

// Updating npm
npm i -g npm@latest

// Node.js Console (REPL read–eval–print loop)
node

> a=1;b=2;a+b
> f = function(x) {return x*2}
> f(b)

// There are slight deviations in ECMAScript implementations between Node.js and browsers, such as the Chrome Developer Tools console. rowsers don’t support Node.js modules feature.

// Launching Node.js Scripts
node filename.js or node filename
node -e "console.log(new Date());"

// If the Node.js program uses environmental variables, it’s possible to set them right before the node command. For example:
NODE_ENV=production API_KEY=442CC1FE-4333-46CE-80EE-6705A1896832 node server.js

// Node.js Basics and Syntax
// Node.js was built on top of the Google Chrome V8 engine and its ECMAScript, which means most of the Node.js syntax is similar to front-end JavaScript (another implementation of ECMAScript), including objects, functions, and methods.

/*
Node.js/JavaScript fundamentals:
• Loose typing
    There are only a few types of primitives:  • String • Number (both integer and real) • Boolean • Undefined • Null. Automatic typecasting works well. Everything else is an object. Class/Function/Array/RegExp all works as an object. Objects are passed by reference whereas primitives are passed by values.
    'a' === new String('a') // false*
    but
    'a' === new String('a').toString() // true*
    or
    'a' == new String('a') // true*
    //== performs automatic typecasting
• Buffer—Node.js super data type Object literal notation
    Buffer is the data type. It is a Node.js addition to five primitives. Node.js tries to use buffers any time it can, such as when reading from a file system and when receiving packets over the network. Buffer can be created from an array, another buffer, ArrayBuffer or a string. To create a buffer object, use "from".

    const bufFromArray = Buffer.from([0x62, 0x75, 0x66, 0x66, 0x65, 0x72])
    console.log(bufFromArray.toString()) // "buffer"

    > bufFromArray
    <Buffer 62 75 66 66 65 72>

    const bufFromArray1 = Buffer.from([10,20,30])
    > bufFromArray1
    <Buffer 0a 14 1e>

Object Literal Notation
you can extend another object, define fields dynamically, invoke super() and use shorter syntax for functions

const serviceBase = {
    port: 3000,
    url: 'azat.co'
  }
  const getAccounts = () => {
    return [1,2,3]
  }
  const accountService = {
    __proto__: serviceBase,
    getUrl() { // define method without "function"
      return "http://" + this.url + ':' + this.port
    },
    getAccounts() // define from an outer-scope function
    toString() { // overwrite proto method
      return JSON.stringify((super.valueOf()))
    },
    [ 'valueOf_' + getAccounts().join('_') ]: getAccounts()
  }
  console.log(accountService) // ready to be used

• Functions Arrays

The three most common ways to define/create a function

1.Named expression:
function f() {
  console.log('Hi')
  return true
}

2.An anonymous function expression assigned to a variable
const f = function() {
  console.log('Hi')
  return true
}

Anonymous function definition with fat arrow function syntax.
// outer "this"
const f = () => {
  // still outer "this"
  console.log('Hi')
  return true
}
This new syntax has an added benefit of safer this due to its value always remaining an outer this

3.Both approaches, anonymous and named:
const f = function f() {
  console.log('Hi')
  return true
}

A function with a property (remember, functions are just objects that can be invoked/initialized) is as follows:
const f = function() {console.log('Boo')}
f.boo = 1
f() //outputs Boo*
console.log(f.boo) //outputs 1

Pass Functions as Parameters
const convertNum = function(num) {
  return num + 10
}
const processNum = function(num, fn) {
  return fn(num)
}
processNum(10, convertNum)

There’s also an implicit return when you are using the fat arrow function. It works when there’s just one statement in a function:

const fWithImplicitReturn = (a,b) => a+b
// WithImplicitReturn(1,3) = 4
Arrays are also objects that have some special methods inherited from the Array.

https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array

• Prototypal nature Conventions
There are no classes in JavaScript because objects inherit directly from other objects, which is called prototypal inheritance. There are a few types of inheritance patterns in JavaScript:
• Classical
• Pseudoclassical
• Functional

This is an example of the functional inheritance pattern in which two function factories create objects user and agent :

let user = function (ops) {
  return { firstName: ops.firstName || 'John',
    lastName: ops.lastName || 'Doe',
    email: ops.email || 'test@test.com',
    name: function() { return this.firstName + this.lastName}
  }
}
let agency = function(ops) {
  ops = ops || {}
  var agency = user(ops)
  agency.customers = ops.customers || 0
  agency.isAgency = true
  return agency
}

With class introduced in ES2015 (ES6), things are somewhat easier, A class can be extended, defined, and instantiated with extends , class , and new .
class baseModel {
  constructor(options = {}, data = []) { // class constructor
    this.name = 'Base'
    this.url = 'http://azat.co/api'
    this.data = data
    this.options = options
  }
  getName() { // class method
    console.log(`Class name: ${this.name}`)
  }
}

Then we can create a new class using the base class. The new class will have all the
functionality of a base class from which it inherits and then some more:
class AccountModel extends baseModel {
  constructor(options, data) {
    super({private: true}, ['32113123123', '524214691'])
// call the parent method with super
    this.name = 'Account Model'
    this.url +='/accounts/'
  }
  get accountsData() { // calculated attribute getter
    // ... make XHR
    return this.data
  }
}
let accounts = new AccountModel(5)
accounts.getName()
console.log('Data is %s', accounts.accountsData)
The results will be:
Class name: Account Model
Data is %s 32113123123,524214691

*/


Almost all statements in JavaScript and thus Node.js must be terminated with a semicolon. However, JavaScript engines have an automatic semicolon insertion feature. Typing extra symbols is counterproductive. Hence, the use of semicolons is optional and counter-productive.

I Do not use semicolons, except for these cases:
1. In loop constructions such as for (var i=0; i++; i<n)
2. When a new line starts with parentheses or square brace or regular expression, such as when using an immediately invoked
function expression (IIFE): ;
­ (function(){...}())
3. When doing something weird like empty statements (see Automatic semicolon insertion in JavaScript)

Node.js Globals and Reserved Keywords
Despite being modeled after one standard, Node.js and browser JavaScript differ when it comes to globals. Browser JavaScript we have a window object which is absent in node js. New objects/keywords available in node js are P:• process • global • module.exports and exports

Node.js has a lot of useful information and methods in global.process , including but not limited to the following

node
> process.pid
> process.argv
> process.env
> process.platform
> process.memoryUsage()
> process.exit()
> process.kill()

Exporting and Importing Modules
One of the bad parts of browser JavaScript is that there is no easy way to include other JavaScript files. Browser JavaScript files are supposed to be linked together using a different language (HTML),
but everything from an included file is just run without name spacing and dependency management is hard because managing a lot of <script> tags and files is not fun.

ode.js offers modules natively. No tools or hacks are needed. Node.js borrowed many things from the browser CommonJS concept but took the implementation steps further than CommonJS.

Node.js modules are simple to learn and use. They allow of import/export only specific targeted functionality, making name spacing easier, unlike when you include a browser JavaScript file with a <script> tag. To export an object in Node.js, use exports.name = object; . An example follows:

To export an object in Node.js, use exports.name = object; . An example follows:

const messages = {
  find: function(req, res, next) {
  ...
  },
  add: function(req, res, next) {
  ...
  },
  format: 'title | date | author'
}
exports.messages = messages

const instead of let/var makes more sense as we are not updating this object, and can use an extra safety of const , which
respects the logical scope and prevents re-declaration. const will still allow you to modify object properties.
While in the file where we import the aforementioned script (assuming the path and the file name is route/messages.js ), write the following:

const messages = require('./routes/messages.js')

However, sometimes it’s more fitting to invoke a constructor

module.exports = (app) => {
    app.set('port', process.env.PORT || 3000)
    app.set('views', __dirname + '/views')
    app.set('view engine', 'jade')
    return app
  }

In the file that includes the previous sample module, write:
...
let app = express()
const config = require('./config/index.js')
app = config(app)
...

The more succinct code is to skip the config variable declaration:

const express = require('express')
let app = express()
require('./config/index.js')(app)

or core Node.js modules and modules in node_modules folder, use the name without any path—for example,
require('name')

For all other files (i.e., not modules), use . with or without a file extension. An
example follows:
const keys = require('./keys.js'),
  messages = require('./routes/messages.js')

It’s advisable to use statements with __dirname and path.join() to insure the paths work across platforms.

const messages = require(path.join(__dirname, 'routes','messages.js'))

__dirname vs. process.cwd
__dirname is an absolute path to the folder with the source code script (a file in which the global variable is called), whereas process.cwd is an absolute path to the folder from which the process that runs the script was launched.

Node.js Core Modules
Unlike other programming technologies, Node.js doesn’t come with a heavy standard library. The core modules of Node.js are a bare minimum, and the rest can be cherrypicked via the npm registry.

• http ( http://nodejs.org/api/http.html#http_http ): Allows to create HTTP clients and servers
• util ( http://nodejs.org/api/util.html ): Has a set of utilities
• querystring ( http://nodejs.org/api/querystring.html ): Parses query-string formatted data
• url ( http://nodejs.org/api/url.html ): Parses URL data
• fs ( http://nodejs.org/api/fs.html ): Works with a file system (write, read)

There is no need to install or download core modules. To include them in your application, all you need is to use the following syntax:
const http = require('http')

Node comes with core modules, but most developers rely on the vast ecosystem of community- created FOSS (free and open-source) modules. With large number of modules, it’s important to find just the right one for the job.

A list of noncore modules is found at the following locations:
• npm search: https://www.npmjs.com/browse/keyword/search : The main npm search by npm itself
• node-modules.com ( http://node-modules.com ): Search for npm
• npms.io ( https://npms.io ): Another search for npm