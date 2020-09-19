var fs = require('fs');
fs.readFile(__filename, 'utf8', function(err, fileContent) {
    if (err) {
        console.error(err);
    } else {
        console.log('got file content:', fileContent);
    }
});

// It should output the content of the read_file.js file.

// Chaining I/O read_file_conditional.js :
var fs = require('fs');
fs.stat(__filename, function(err, stats) {
    if (err) {
        console.error(err);
    } else {
        if (stats.size < 1024) {
            fs.readFile(__filename, 'utf8', functionvar fs = require('fs');
            fs.readFile(__filename, 'utf8', function(err, fileContent) {
                if (err) {
                    console.error(err);
                } else {
                    console.log('got file content:', fileContent);
                }
            });(err, fileContent)
            {
                if (err) {
                    console.error(err);
                } else {
                    console.log('Got file content:', fileContent);
                }
            });
        } else {
            console.log('Didn\'t read the file, it was too long.');
        }
    }
});

// Alternatively, you can create the callback functions at the same level and name them as in this example ( read_file_conditional_unnested.js ):
var fs = require('fs');
function readFileCallback(err, fileContent) {
if (err) {
console.error(err);
} else {
console.log('Got file content:', fileContent);
}
}
function statsCallback(err, stats) {
if (err) {
console.error(err);
} else {
if (stats.size < 1024) {
fs.readFile(__filename, 'utf8', readFileCallback);
} else {
console.log('Didn\'t read the file, it was too
long.');
}
}
}

fs.stat(__filename, statsCallback);

// This will have the benefit of reducing the code indentation level but makes the execution flow a bit harder to follow.
