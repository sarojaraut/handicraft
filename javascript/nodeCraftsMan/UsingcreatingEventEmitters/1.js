'use strict';

var fs = require('fs');

var stream = fs.createReadStream('./1.js1');
// we create a read stream that will start to retrieve the contents of file /path/to/large/1.js. The call to fs.createReadStream does not take a function argument to use it as a callback.
// The object that is returned by fs.createReadStream is an Event Emitter. These objects allow us to attach different callbacks to different events while keeping our code readable and sane.
stream.on('data', function (data) {
    console.log('Received data: ' + data);
});
// we attach a callback to one type of events the ReadStream emits: data events
// the data event will be emitted multiple times, depending on the size of the file.
stream.on('end', function () {
    console.log('End of file has been reached');
});
// we attach another callback to another type of event the ReadStream emits: the end event
// When all content has been retrieved, the end event is fired once, and no other events will be fired from then on. The end event callback is therefore the right place to do whatever we want to do after we retrieved the complete file content.

stream.on('error', function (err) {
    console.log('Sad panda: ' + err);
});
// a callback event to handle the error event

// Instead of using on, we can also attach a callback to an event using once.
// stream.once('data', function (data) {
//     console.log('I have received the first chunk of data');
// });

// Also, it’s possible to detach an attached callback manually. This only works with named callback functions:

// stream.on('data', callback);
// stream.removeListener('data', callback);
// stream.removeAllListeners('data');
