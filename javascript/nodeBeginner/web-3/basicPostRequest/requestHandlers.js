//requestHandlers.js

var exec = require("child_process").exec;
// we just introduced a new Node.js module, child_process. We did so because it allows us to make use of a very simple yet useful non-blocking

function start(response) {
    console.log("Request handler 'start' was called.")
    var body = '<html>'+
        '<head>'+
        '<meta http-equiv="Content-Type" content="text/html; '+
        'charset=UTF-8" />'+
        '</head>'+
        '<body>'+
        '<form action="/upload" method="post">'+
        '<textarea name="text" rows="20" cols="60"></textarea>'+
        '<input type="submit" value="Submit text" />'+
        '</form>'+
        '</body>'+
        '</html>';6
    response.writeHead(200, {"Content-Type": "text/html"});
    response.write(body);
    response.end();
}

function upload(response, postData) {
    console.log("Request handler 'upload' was called.");
    response.writeHead(200, {"Content-Type": "text/plain"});
    response.write("You've sent: " + postData);
    response.end();
}
exports.start = start;
exports.upload = upload;
