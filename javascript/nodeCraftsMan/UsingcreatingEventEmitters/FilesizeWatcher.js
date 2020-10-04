// Creating your own Event Emitter object
'use strict';
// we load the fs module - we need its stat function to asynchronously retrieve file information.
var fs = require('fs');
// we start to build a constructor function for FilesizeWatcher objects. They are created by     passing a path to watch as a parameter.
var FilesizeWatcher = function (path) {
    // we assign the object instance variable to a local self variable - this way we can access our     instantiated object within callback functions, where this would point to another object.
    var self = this;
    // We then create the self.callbacks object - we are going to use this as an associative array where we     will store the callback to each event.
    self.callbacks = {};
    if (/^\//.test(path) === false) {
        self.callbacks['error']('Path does not start with a slash');
        return;
    }
    // we start an initial stat operation in order to store the file size of the given path we need this base value in order to recognize future changes in file size.
    fs.stat(path, function (err, stats) {
        self.lastfilesize = stats.size;
    });
    // We set up a 1-second interval where we call stat on every interval iteration and compare the current file size with the last known file size.
    self.interval = setInterval(
        function () {
            fs.stat(path, function (err, stats) {
                // handles the case where the file grew in size, calling the event handler callback associated with the grew event; and next block handles the opposite case. In both cases, the new file size is saved.
                if (stats.size > self.lastfilesize) {
                    self.callbacks['grew'](stats.size - self.lastfilesize);
                    self.lastfilesize = stats.size;
                }
                if (stats.size < self.lastfilesize) {
                    self.callbacks['shrank'](self.lastfilesize - stats.size);
                    self.lastfilesize = stats.size;
                }
            }, 1000);
        });
};
// Event handlers can be registered using the FilesizeWatcher.on method. In our implementation, all it does is to store the callback under the event name in our callbacks object.
FilesizeWatcher.prototype.on = function (eventType, callback) {
    this.callbacks[eventType] = callback;
};
// defines the stop method which cancels the interval we set up in the constructor function.
FilesizeWatcher.prototype.stop = function () {
    clearInterval(this.interval);
};

module.exports = FilesizeWatcher;