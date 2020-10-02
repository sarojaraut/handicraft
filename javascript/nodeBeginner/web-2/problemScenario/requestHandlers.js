//requestHandlers.js
function start() {
    console.log("Request handler 'start' was called.");
    function sleep(milliSeconds) {
        var startTime = new Date().getTime();
        while (new Date().getTime() < startTime + milliSeconds);
    }
    sleep(10000); // imagine that instead of sleeping for 10 seconds, there would be a real life blocking operation
    return "Hello Start"; // new line for this version
}
function upload() {
    console.log("Request handler 'upload' was called.");
    return "Hello Upload"; // new line for this version
}
exports.start = start;
exports.upload = upload;
