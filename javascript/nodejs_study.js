// Install node JS 

sudo apt install node js 
sudo apt install npm 

npm -v 
node -v 

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