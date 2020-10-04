// Blocking and non-blocking operations

// that every synchronous operation results in a blocking operation. That’s right, even an innocent

// we can distill the two most important rules for writing reponsive Node.js applications:
// • Handle IO-intensive operations through asynchronous operations
// • Keep your own code (that is, everything that happens synchronously within event loop iterations) as lean as possible

