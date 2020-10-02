
//First Version
var http = require("http");
function onRequest(request, response) {
    console.log("Request received.");
    response.writeHead(200, {"Content-Type": "text/plain"});
    response.write("Hello World");
    response.end();
}

http.createServer(onRequest).listen(8888);
console.log("Server has started.");

//Second Version

//Server.js 
var http = require("http");
function start() {
    function onRequest(request, response) {
        console.log("Request received.");
        response.writeHead(200, {"Content-Type": "text/plain"});
        response.write("Hello World");
        response.end();
    }
    http.createServer(onRequest).listen(8888);
    console.log("Server has started.");
}
exports.start = start;

//index.js

var server = require("./server");
server.start();

// node index.js

//Third Version

//Server.js 
var http = require("http");
var url = require("url");
function start(route) {
    function onRequest(request, response) {
        var pathname = url.parse(request.url).pathname;
        console.log("Request for " + pathname + " received.");
        route(pathname);
        response.writeHead(200, {"Content-Type": "text/plain"});
        response.write("Hello World");
        response.end();
    }
    http.createServer(onRequest).listen(8888);
    console.log("Server has started.");
}
exports.start = start;

// Router.js
function route(pathname) {
    console.log("About to route a request for " + pathname);
}
exports.route = route;

//index.js
var server = require("./server");
var router = require("./router");
server.start(router.route);

//Fourth Version : Routing to real request handlers

//requestHandlers.js
function start() {
    console.log("Request handler 'start' was called.");
}
function upload() {
    console.log("Request handler 'upload' was called.");
}
exports.start = start;
exports.upload = upload;

// router.js
function route(handle, pathname) {
    console.log("About to route a request for " + pathname);
    if (typeof handle[pathname] === 'function') {
        handle[pathname]();
    } else {
        console.log("No request handler found for " + pathname);
    }
}
exports.route = route;

//server.js 
var http = require("http");
var url = require("url");
function start(route, handle) {
    function onRequest(request, response) {
        var pathname = url.parse(request.url).pathname;
        console.log("Request for " + pathname + " received.");

        route(handle, pathname);

        response.writeHead(200, {"Content-Type": "text/plain"});
        response.write("Hello World");
        response.end();
    }
    http.createServer(onRequest).listen(8888);
    console.log("Server has started.");
}
exports.start = start;

//index.js
var server = require("./server");
var router = require("./router");
var requestHandlers = require("./requestHandlers");

var handle = {};
handle["/"] = requestHandlers.start;
handle["/start"] = requestHandlers.start;
handle["/upload"] = requestHandlers.upload;

server.start(router.route, handle);

//Fifth Version



//Second Version
//Second Version
//Second Version