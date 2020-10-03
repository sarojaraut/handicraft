
http://localhost:8080/start

Serving something useful
handle incoming POST requests (but not file uploads)
We will present a textarea that can be filled by the user and submitted to the server in a POST request. Upon receiving and handling this request, we will display the content of the textarea.
We'll not include an extra level of abstraction (i.e., separating view and controller logic) and will all add html code to ourrequest handler
To make the whole process non-blocking, Node.js serves our code the POST data in small chunks, callbacks that are called upon certain events. These events are data (a new chunk of POST data arrives) and end (all chunks have been received).
We need to tell Node.js which functions to call back to when these events occur. This is done by adding listeners to the request object that is passed to our onRequest callback whenever an HTTP request is received.