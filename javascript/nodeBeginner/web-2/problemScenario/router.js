// router.js
function route(handle, pathname) {
    console.log("About to route a request for " + pathname);
    if (typeof handle[pathname] === 'function') {
        return handle[pathname](); // return keyword added for this version
    } else {
        console.log("No request handler found for " + pathname);
        return "404 Not found"; // new line for this version
    }
}
exports.route = route;