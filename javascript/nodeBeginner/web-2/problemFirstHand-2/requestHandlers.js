//requestHandlers.js

var exec = require("child_process").exec;
// we just introduced a new Node.js module, child_process. We did so because it allows us to make use of a very simple yet useful non-blocking

function start(response) {
    console.log("Request handler 'start' was called.");
    exec("sleep 10; ls -ltr", function (error, stdout, stderr) {
        response.writeHead(200, {"Content-Type": "text/plain"});
        response.write(stdout);
        response.end();
    });
}

function upload(response) {
    console.log("Request handler 'upload' was called.");
    response.writeHead(200, {"Content-Type": "text/plain"});
    response.write("Hello Upload");
    response.end();
}
exports.start = start;
exports.upload = upload;
