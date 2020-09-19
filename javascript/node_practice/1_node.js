var http = require('http');
var server = http.createServer();
server.on('request', function(req, res) {
    res.writeHead(200, {'content-type': 'text/plain'});
    res.write('Hello World!');
    res.end();
});
var port = 8080;
server.listen(port);
server.once('listening', function() {
console.log('Hello World server listening on port %d', port);
});

