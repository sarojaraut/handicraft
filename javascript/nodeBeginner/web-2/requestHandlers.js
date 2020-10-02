//requestHandlers.js
function start() {
    console.log("Request handler 'start' was called.");
    return "Hello Start"; // new line for this version
}
function upload() {
    console.log("Request handler 'upload' was called.");
    return "Hello Upload"; // new line for this version
}
exports.start = start;
exports.upload = upload;
