//server.js 
var http = require("http");
var url = require("url");
function start(route, handle) {
    function onRequest(request, response) {
        var pathname = url.parse(request.url).pathname;
        console.log("Request for " + pathname + " received.");

        var content = route(handle, pathname, response); // var content only added
        
    }
    http.createServer(onRequest).listen(8888);
    console.log("Server has started.");
}
exports.start = start;