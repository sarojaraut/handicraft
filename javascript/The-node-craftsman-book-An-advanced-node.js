// The-node-craftsman-book-An-advanced-nodejs-tutorial


// ### Test-Driven Node.js Development
/*


New Node.js project with two folders in it:

src/
spec/

spec is where our test cases go - in Jasmine lingo, these are called “specifications”, hence “spec”. The spec folder mirrors the file structure under src, i.e., a source file at src/foo.js is mirrored by a specification at spec/fooSpec.js.


##spec/greetSpec.js

'use strict';
var greet = require('../src/greet');
describe('greet', function () {
    it('should greet the given name', function () {
        expect(greet('Joe')).toEqual('Hello Joe!');
    });
    it('should greet no-one special if no name is given', function () {
        expect(greet()).toEqual('Hello world!');
    });
})

Jasmine specifications have a two-level structure. The top level of this structure is a describe block, which consists of one or more it blocks.
An it block describes a single expected behaviour of a single unit under test, and a describe block summarizes one or more blocks of expected behaviours

### package.json

{
"devDependencies": {
"jasmine-node": ""
}
}

./node_modules/jasmine-node/bin/jasmine-node spec/greetSpec.js

Exception loading: spec/greetSpec.js
{ [Error: Cannot find module '../src/greet'] code: 'MODULE_NOT_FOUND' }

Now create greet.js with following content

'use strict';
var greet = function() {};
module.exports = greet;

Now we have a general infrastructure, but of course we do not yet behave as the specification wishes.
Let’s run the test cases again:

FF

Failures:

  1) greet should greet the given name
   Message:
     Expected undefined to equal 'Hello Joe!'.
   Stacktrace:
     Error: Expected undefined to equal 'Hello Joe!'.
    at jasmine.Spec.<anonymous> (/home/mybriefcase/gitrepos/handicraft/javascript/nodeCraftsMan/BDD/spec/greetSpec.js:5:30)

  2) greet should greet no-one special if no name is given
   Message:
     Expected undefined to equal 'Hello world!'.
   Stacktrace:
     Error: Expected undefined to equal 'Hello world!'.
    at jasmine.Spec.<anonymous> (/home/mybriefcase/gitrepos/handicraft/javascript/nodeCraftsMan/BDD/spec/greetSpec.js:8:25)

Finished in 0.007 seconds
2 tests, 2 assertions, 2 failures, 0 skipped

Jasmine tells us that it executed two test cases that contained a total of two assertions (or expectations), and because these expectations could not be satisfied, the test run ended with two failures.

It’s time to satisfy the first expectation of our specification, in file src/greet.js:
lnew function code :
var greet = function (name) { 
    return 'Hello ' + name + '!';
};

now we can only one test case failed out of two.

Let's implement the second bahaviour and run the test

final greet.js code

'use strict';
var greet = function (name) {
    if (name === undefined) {
        name = 'world';
    }
    return 'Hello ' + name + '!';
};
module.exports = greet;

./node_modules/jasmine-node/bin/jasmine-node spec/greetSpec.js
..

Finished in 0.004 seconds
2 tests, 2 assertions, 0 failures, 0 skipped

*/

// ## Object-oriented JavaScript
/*
Blueprints versus finger-pointing
Object orient feature of java script is quite different compared languages like C++, Java, Ruby, Python or PHP.
Those lanuguages are blur print based, i.e. first define the class the blue print and then create objects of that class. The newly built object shares certain aspects with its blueprint. If you call the method on your object myCar.honk();
then the Java VM will go to the class of myCar and look up which code it actually needs to execute, which is defined in the honk method of class Car. 

JavaScript does not have classes. Instead of an object-class relationship, there is an object-object relationship.

Where in Java our myCar, asked to honk, says “go look at this class over there, which is my blueprint, to find the code you need”, JavaScript says “go look at that other object over there, which is my prototype, it has the code you are looking for”.

Building objects via an object-object relationship is called Prototype-based programming, versus Class-based programming used in more traditional languages like Java.







*/


//
/*

*/
