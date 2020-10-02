
visit http://localhost:8888/start.

Which loads a beautiful web page that displays the string “empty”. What’s going wrong here?

exec() does its magic in a non-blocking fashion. That’s a good thing, because this way we can execute very expensive shell operations (like, e.g., copying huge files around or similar stuff) without forcing our application into a full stop as the blocking sleep operation did.

The problem is that exec(), in order to work non-blocking, makes use of a callback function. In our example, it’s an anonymous function which is passed as the second parameter to the exec() function call:

function (error, stdout, stderr) {
content = stdout;
}

And herein lies the root of our problem: our own code is executed synchronous, which means that immediately after calling exec(), Node.js continues to execute return content;. At this point, content is still “empty”, due to the fact that the callback function passed to exec() has not yet been called - because exec() operates asynchronous.

