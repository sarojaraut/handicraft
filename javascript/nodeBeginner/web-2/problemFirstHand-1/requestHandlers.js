//requestHandlers.js

var exec = require("child_process").exec;
// we just introduced a new Node.js module, child_process. We did so because it allows us to make use of a very simple yet useful non-blocking

function start() {
    console.log("Request handler 'start' was called.");
    // new exec block
    var content = "empty"; 
    // without intialisation it will break the line 12 of server.js response.write(content);  with following error
    // _http_outgoing.js:595 throw new ERR_INVALID_ARG_TYPE('first argument',TypeError [ERR_INVALID_ARG_TYPE]: The first argument must be one of type string or Buffer. Received type undefined
    exec("ls -lah", function (error, stdout, stderr) {
        content = stdout;
        // simply assigning the stdout to content is not going to return the actual data to client
        // as this is an sync process and it will not be completed before the response.end is called.
        // so we need to pass response object here and do response object manipulation here
    });
    return content;
}
function upload() {
    console.log("Request handler 'upload' was called.");
    return "Hello Upload"; // new line for this version
}
exports.start = start;
exports.upload = upload;
