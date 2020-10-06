// While writing code often, callbacks are used when operations are executed in the background and jump back into our code’s control flow asynchronously at a later point in time
// If those asynchronous background operations bring forth a more complex callback behaviour, they might be implemented as an event emitter

'use strict';

var http = require('http');
var url = require('url');
var queryString = require('querystring');

http.createServer(function (request, response) {
    // console.log(request);
    // http://localhost:8080/getUserStatus?id=1234
    // in the above url pathname = getUserStatus and id=1234
    // request.url = getUserStatus?id=1234
    var pathname = url.parse(request.url).pathname;
    var query = url.parse(request.url).query;
    var id = queryString.parse(query)['id'];

    var result = {
        'ip':request.ip,
        'hostname' : request.hostname,
        'baseUrl': request.baseUrl,
        'originalUrl':request.originalUrl,
        'requestUrl':request.url,
        'pathname': pathname,
        'id': id,
        'value': Math.floor(Math.random() * 100)
    };

    setTimeout(function () {
        response.writeHead(200, {
            "Content-Type": "application/json"
        });

        response.end(JSON.stringify(result));

    }, 2000 + Math.floor(Math.random() * 1000));

}).listen(
    8080,
    function () {
        console.log('Echo Server listening on port 8080');
    }
);