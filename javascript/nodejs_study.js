// Install node JS 

// sudo apt install nodejs 
// sudo apt install npm 

// npm -v 
// node -v 

// If you try installing the latest version of node using the apt-package manager, you'll end up with v10.19.0. This is the latest version in the ubuntu app store, but it's not the latest released version of NodeJS

// To get the latest versions, we can use either nodesource or nvm 

// Install NVM

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

// reconnect to the terminal
nvm --version

// Install NodeJS : Next, let's install Nodejs version 14.13.1

nvm install 14.13.1

// Above command automatically installs nodejs as well as the latest npm version which is at  v6.14.5

// 1_node.js

var http = require('http');
var server = http.createServer();
server.on('request', function(req, res) {
        res.writeHead(200, {'content-type': 'text/plain'});
        res.write('Hello World!');
        res.end();
    });
var port = 8080;
server.listen(port);
server.once('listening', function() {
console.log('Hello World server listening on port %d', port);
});

Node Package Manager (NPM)
// Node.js has a low-level API that is somewhat a translation and simplification of the Unix filesystem and networking API into JavaScript. If you plan to build a complex application, doing that solely on top of the core Node.js functionality can be hard and unproductive. Fortunately, Node.js has a way of browsing, querying, installing, and publishing third-party modules into a central repository, and it's called NPM. NPM stands for Node Package Manager.

sudo apt install npm 
npm ls 
npm restart

// package.json

{
    "name": "my-example-app",
    "version": "0.1.0",
    "dependencies": {
    "request": "*",
    "nano": "3.3.x",
    "async": "~0.2"
    }
}

// Dependenciy syntax
/* <major version>.<minor version>.<patch version>numbers
* means any version
3.3.x means any patch of 3.3
~0.2 means any patch version of 0.2. 
NPM will analyze what versions you specify and will install the latest available version that matches your specification
 */

// Displays all installed modules
npm ls 

// The callback pattern

// The pseudo-code for typical blocking code when doing a remote call to a database may look something like this:
var result = query('SELECT * FROM articles');
console.log('result:', result);
// current program would just wait untill the remote system returns the result

// In event-driven I/O, instead of returning the result of a remote operation, you pass a callback that gets invoked once that operation is finished. On such a platform, the equivalent of doing a database query similar to the previous blocking code would be:
query('SELECT * FROM articles', function(result) {
console.log('result:', result);
});

// Actually, both the blocking and non-blocking versions have been simplified, since they don't predict the case when an error happens. The correct blocking version would then be:
try {
    var result = query('SELECT * FROM articles');
    console.log('result:', result);
} catch(err) {
    console.error('error while performing query:', err.message);
}

// And the equivalent event-driven version would be:
query('SELECT * FROM articles', function(err, result) {
if (err) {
    console.error('error while performing query:',err.message);
} else {
    console.log('result:', result);
}
});

// Callback last : The callback is the last argument of the function that initiates I/O.
// Error first : The callback expects an error as the first argument and the results in the following arguments. If there is no error, the first argument is undefined or null . If an error exists, this object should be a JavaScript error instance.

Here is an actual working example of reading a file from disk, which you can write to a file named read_file.js :

var fs = require('fs');
fs.readFile(__filename, 'utf8', function(err, fileContent) {
    if (err) {
        console.error(err);
    } else {
        console.log('got file content:', fileContent);
    }
});


// Event emitter
// The callback pattern is useful when you have I/O operations that have a clear end. If you have an object in which events happen throughout time, the callback pattern is not a good fit. Thankfully, Node.js has a built-in pattern named event emitter.


var EventEmitter = require('events').EventEmitter;
var emitter = new EventEmitter();
var count = 0;

setInterval(function() {
    emitter.emit('tick', count);
    count ++;
}, 1000);

emitter.on('tick', function(count) {
    console.log('tick:', count);
});

// Parallelizing I/O
// Parallelizing I/O is natural in Node.js; you don't need to spawn new threads of execution, simply start two or more I/O operations in parallel.

var http = require('http');
var urls = [
    'http://search.twitter.com/search.json?q=Node',
    'http://search.twitter.com/search.json?q=javascript'
];
var allResults = [];
var responded = 0;
function collectResponse(res) {
    var responseBody = '';
    res.setEncoding('utf8');
    /// collect the response body
    res.on('data', function(d) {
    responseBody += d;
    });
    /// when the response ends, we should have all the response     body
    res.on('end', function() {
        var response = JSON.parse(responseBody);
        allResults = allResults.concat(response.results);
        console.log('I have %d results for', response.results.length, res.req.path);
        responded += 1;
        /// check if we have responses to all requests
        if (responded == urls.length) {
        console.log('All responses ended. Number of total results:', allResults.length);
        }
    });
}
urls.forEach(function(url) {
http.get(url, collectResponse);
});