//server.js 
var http = require("http");
var url = require("url");
function start(route, handle) {
    function onRequest(request, response) {
        var pathname = url.parse(request.url).pathname;
        console.log("Request for " + pathname + " received.");

        var content = route(handle, pathname); // var content only added

        response.writeHead(200, {"Content-Type": "text/plain"});
        response.write(content); // variable content is passed instead of earlier hard coded string
        response.end();
    }
    http.createServer(onRequest).listen(8888);
    console.log("Server has started.");
}
exports.start = start;