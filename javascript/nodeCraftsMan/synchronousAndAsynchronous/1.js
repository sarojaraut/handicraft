// A Node.js application has synchronous and asynchronous operations
// The event loop is the execution model of a running Node.js application

//sync operation
console.log('Hello');

//Async operation
// Here we pass the call back function to be executed after timeout of 1000 ms
setTimeout(function () {
    console.log('World');
}, 1000);

// as long as asynchronous operations are ongoing, the Node.js process loops, waiting for events from those operations. As soon as no more asynchronous operations are ongoing, the looping stops and our application terminates.

// This prints Hello and then World to the screen, but the second text is printed with a delay of 1000 ms(1 sec).

var fs = require('fs');

fs.stat('/etc/passwd', function (err, stats) {
    console.dir(stats);
});

/* Output

Hello
Stats {
  dev: 2050,
  mode: 33188,
  nlink: 1,
  uid: 0,
  gid: 0,
  rdev: 0,
  blksize: 4096,
  ino: 2625615,
  size: 3161,
  blocks: 8,
  atimeMs: 1601731608961.694,
  mtimeMs: 1601469738453.981,
  ctimeMs: 1601469738561.9814,
  birthtimeMs: 1601469738453.981,
  atime: 2020-10-03T13:26:48.962Z,
  mtime: 2020-09-30T12:42:18.454Z,
  ctime: 2020-09-30T12:42:18.562Z,
  birthtime: 2020-09-30T12:42:18.454Z }
World

*/
