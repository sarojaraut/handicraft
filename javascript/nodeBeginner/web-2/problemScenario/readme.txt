web-2 problem simulation
blocking operation to our request handlers then all request handlers are impacted

keep both the tabs ready and press enter for start followed by upload
http://localhost:8888/start
http://localhost:8888/upload

What you will notice is this: The /start URL takes 10 seconds to load, as we would expect. But the /upload URL also takes 10 seconds to load, although there is no sleep() in the according request handler.

Why? Because start() contains a blocking operation. We already talked about Node’s execution model - expensive operations are ok, but we must take care to not block the Node.js process with them. Instead, whenever expensive operations must be executed, these must be put in the background, and their events must be handled by the event loop.
And we will now see why the way we constructed the “request handler response handling” in our application doesn’t allow us to make proper use of non-blocking operations.

