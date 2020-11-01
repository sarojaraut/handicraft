// Gate and Latch 

// if (a && b) {
//     baz();
//     }

// The  if (a && b) conditional around the baz() call is traditionally called a "gate," because we're not sure what order a and b will arrive, but we wait for both of them to get there before we proceed to open the gate (call baz() ).

// Another concurrency interaction condition you may run into is sometimes called a "race," but more correctly called a "latch." It's characterized by "only the first one wins" behavior. Here, nondeterminism is acceptable, in that you are explicitly saying it's OK for the "race" to the finish line to have only one winner.

var a;
function foo(x) {
    if (!a) {
        a = x * 2;
        baz();
    }
}
function bar(x) {
    if (!a) {
        a = x / 2;
        baz();
    }
}

// The if (!a) conditional allows only the first of foo() or bar() through, and the second (and indeed any subsequent) calls would just be ignored. There's just no virtue in coming in second place!





// A JavaScript program is (practically) always broken up into two or more chunks, where the first chunk runs now and the next chunk runs later, in response to an event. Even though the program is executed chunk-by-chunk, all of them share the same access to the program scope and state, so each modification to state is made on top of the previous state.
// Whenever there are events to run, the event loop runs until the queue is empty. Each iteration of the event loop is a "tick." User interaction, IO, and timers enqueue events on the event queue.
// At any given moment, only one event can be processed from the queue at a time. While an event is executing, it can directly or indirectly cause one or more subsequent events.
// Concurrency is when two or more chains of events interleave over time, such that from a high-level perspective, they appear to be running simultaneously (even though at any given moment only one event is being processed).
// It's often necessary to do some form of interaction coordination between these concurrent "processes" (as distinct from operating system processes), for instance to ensure ordering or to prevent "race conditions." These "processes" can also cooperate by breaking themselves into smaller chunks and to allow other "process" interleaving.

/************************************************************************************************************************** */
/************************************************************************************************************************** */
/************************************************************************************************************************** */
// Chapter 2: Callbacks

// callbacks are by far the most common way that asynchrony in JS programs is expressed and managed.Indeed, the callback is the most fundamental async pattern in the language.

// Nested / Chained Callbacks
// Consider:
listen("click", function handler(evt) {
    setTimeout(function request() {
        ajax("http://some.url.1", function response(text) {
            if (text == "hello") {
                handler();
            }
            else if (text == "world") {
                request();
            }
        });
    }, 500);
});


// rewrite the previous nested event/timeout/Ajax example without using nesting:
listen("click", handler);
function handler() {
    setTimeout(request, 500);
}
function request() {
    ajax("http://some.url.1", response);
}
function response(text) {
    if (text == "hello") {
        handler();
    }
    else if (text == "world") {
        request();
    }
}

// This formulation of the code is not hardly as recognizable as having the nesting/indentation woes of its previous form, and yet it's every bit as susceptible to "callback hell." Why?
// As we go to linearly (sequentially) reason about this code, we have to skip from one function, to the next, to the next, and bounce all around the code base to "see" the sequence flow. And remember, this is simplified code in sort of best-case fashion. We all know that real async JS program code bases are often afntastically more jumbled, which makes such reasoning orders of magnitude more difficult.

// Another thing to notice: to get steps 2, 3, and 4 linked together so they happen in succession, the only affordance callbacks one gives us is to hardcode step 2 into step 1, step 3 into step 2, step 4 into step 3, and so on. The hardcoding isn't necessarily a bad thing, if it really is a fixed condition that step 2 should always lead to step 3. But the hardcoding definitely makes the code a bit more brittle, as it doesn't account for anything going wrong that might cause a deviation in the progression of steps. For example, if step 2 fails, step 3 never gets reached, nor does step 2 retry, or move to an alternate error handling flow, and so on.

// All of these issues are things you can manually hardcode into each step, but that code is often very repetitive and not reusable in other steps or in other async flows in your program.

// But the brittle nature of manually hardcoded callbacks (even with hardcoded error handling) is often far less graceful. Once you end up specifying (aka pre-planning) all the various eventualities/paths, the code becomes so convoluted that it's hard to ever maintain or update it.

// That is what "callback hell" is all about! The nesting/indentation are basically a side show, a red herring.


// That's the first major deficiency to articulate about callbacks. There's something much deeper to be concerned about.

// Trust Issues

// A
ajax("..", function (..) {
    // C
});
// B
// A and // B happen now, under the direct control of the main JS program. But // C gets deferred to happen later, and under the control of another party Many times it's a utility provided by some third party. We call this "inversion of control," when you take part of your program and give over control of its execution to another third party. There's an unspoken "contract" that exists between your code and the third-party utility -- a set of things you expect to be maintained.

// Imagine you're a developer tasked with building out an ecommerce checkout system for a site that sells expensive TVs. You already have all the various pages of the checkout system built out just fine. On the last page, when the user clicks "confirm" to buy the TV, you need to call a third-party function (provided say by some analytics tracking company) so that the sale can be tracked.

// you will have the final code that charges the customer's credit card and displays the thank you page. This code might look like:

analytics.trackPurchase(purchaseData, function () {
    chargeCreditCard();
    displayThankyouPage();
})


Imagine there was a temporary bug at the third party and they end up calling the call back function more than once and customer charged multiple TimeRanges.and you'll need to figure out how to protect the checkout code from such a vulnerability again. After thinking a bit you implemented a latch :

var tracked = false;
analytics.trackPurchase(purchaseData, function () {
    if (!tracked) {
        tracked = true;
        chargeCreditCard();
        displayThankyouPage();
    }
});

// But then one of your QA engineers asks, "what happens if they never call the callback?" Oops. Neither of you had thought about that.

// You begin to chase down the rabbit hole, and think of all the possible things that could go wrong with them calling your callback. Here's roughly the list you come up with of ways the analytics utility could misbehave:

// Call the callback too early (before it's been tracked)
// Call the callback too late (or never)
// Call the callback too few or too many times (like the problem you encountered!)
// Fail to pass along any necessary environment/parameters to your callback
// Swallow any errors/exceptions that may happen

// That should feel like a troubling list, because it is. You're probably slowly starting to realize that you're going to have to invent an awful lot of ad hoc logic in each and every single callback that's passed to a utility you're not positive you can trust.
// Now you realize a bit more completely just how hellish "callback hell" is.

// Some of you may be skeptical at this point whether this is as big a deal as I'm making it out to be. Perhaps you don't interact with truly third - party utilities much if at all.Perhaps you use versioned APIs or self - host such libraries, so that its behavior can't be changed out from underneath you.

// So, contemplate this: can you even really trust utilities that you do theoretically control(in your own code base) ?
// Think of it this way: most of us agree that at least to some extent we should build our own internal functions with some defensive checks on the input parameters, to reduce / prevent unexpected issues.


// Overly trusting of input:
function addNumbers(x, y) {
    return x + y;
}
addNumbers(21, 21); // 42
addNumbers(21, "21");  // "2121"

// Defensive against untrusted input:
function addNumbers(x, y) {
    // ensure numerical input
    if (typeof x != "number" || typeof y != "number") {
        throw Error("Bad parameters");
    }
}
// if we get here, + will safely do numeric addition
return x + y;
addNumbers(21, 21); // 42
addNumbers(21, "21");  // Error: "Bad parameters"

// Or perhaps still safe but friendlier:
function addNumbers(x, y) {
    // ensure numerical input
    x = Number(x);
    y = Number(y);
}
// + will safely do numeric addition
return x + y;
addNumbers(21, 21); // 42
addNumbers(21, "21");  // 42

// However you go about it, these sorts of checks/normalizations are fairly common on function inputs, even with code we theoretically entirely trust. In a crude sort of way, it's like the programming equivalent of the geopolitical principle of "Trust But Verify."
// So, doesn't it stand to reason that we should do the same thing about composition of async function callbacks, not just with truly external code but even with code we know is generally "under our own control"? Of course we should.

// But callbacks don't really offer anything to assist us. We have to construct all that machinery ourselves, and it often ends up being a lot of boilerplate/overhead that we repeat for every single async callback.

// If you have code that uses callbacks, especially but not exclusively with third-party utilities, and you're not already applying some sort of mitigation logic for all these inversion of control trust issues, your code has bugs in it right now even though they may not have bitten you yet. Latent bugs are still bugs. Hell indeed.


// Trying to Save Callbacks
// There are several variations of callback design that have attempted to address some (not all!) of the trust issues we've just looked at.

// For example, regarding more graceful error handling, some API designs provide for split callbacks (one for the success notification, one for the error notification):
function success(data) {
    console.log(data);
}
function failure(err) {
    console.error(err);
}
ajax("http://some.url.1", success, failure);

// In APIs of this design, often the failure() error handler is optional, and if not provided it will be assumed you want the errors swallowed. Ugh.

// Note: This split-callback design is what the ES6 Promise API uses


// Another common callback pattern is called "error-first style" (sometimes called "Node style," as it's also the convention used across nearly all Node.js APIs), where the first argument of a single callback is reserved for an error object (if any). If success, this argument will be empty/falsy (and any subsequent arguments will be the success data), but if an error result is being signaled, the first argument is set/truthy (and usually nothing else is passed):
function response(err, data) {
    // error?
    if (err) {
        console.error(err);
    }
    // otherwise, assume success
    else {
        console.log(data);
    }
}
ajax("http://some.url.1", response);

// In both of these cases, several things should be observed. There's nothing about either callback that prevents or filters unwanted repeated invocations. Moreover, things are worse now, because you may get both success and error signals, or neither, and you still have to code around either of those conditions. Also, don't miss the fact that while it's a standard pattern you can employ, it's definitely more verbose and boilerplate-ish without much reuse. 

// What about the trust issue of never being called? If this is a concern (and it probably should be!), you likely will need to set up a timeout that cancels the event. You could make a utility (proof-of-concept only shown) to help you with that:

function timeoutify(fn, delay) {
    var intv = setTimeout(function () {
        intv = null;
        fn(new Error("Timeout!"));
    }, delay)
        ;
}
return function () {
    // timeout hasn't happened yet?
    if (intv) {
        clearTimeout(intv);
        fn.apply(this, arguments);
    }
};


// Here's how you use it:
// using "error-first style" callback design
function foo(err, data) {
    if (err) {
        console.error(err);
    }
    else {
        console.log(data);
    }
}
ajax("http://some.url.1", timeoutify(foo, 500));



/************************************************************************************************************************** */
/************************************************************************************************************************** */
/************************************************************************************************************************** */
// Chapter 3: Promises

// In Chapter 2, we identified two major categories of deficiencies with using callbacks to express program asynchrony and manage concurrency: lack of sequentiality and lack of trustability. 

// But what if we could uninvert that inversion of control? What if instead of handing the continuation of our program to another party, we could expect it to return us a capability to know when its task finishes, and then our code could decide what to do next?
// This paradigm is called Promises.

// Imagine this scenario: I walk up to the counter at a fast-food restaurant, and place an order for a cheeseburger. I hand the cashier $1.47. By placing my order and paying for it, I've made a request for a value back (the cheeseburger). I've started a transaction. But often, the chesseburger is not immediately available for me. The cashier hands me something in place of my cheeseburger: a receipt with an order number on it. This order number is an IOU ("I owe you") promise that ensures that eventually, I should receive my cheeseburger. So I hold onto my receipt and order number. I know it represents my future cheeseburger, so I don't need to worry about it anymore -- aside from being hungry!

// While I wait, I can do other things, like send a text message to a friend that says, "Hey, can you come join me for lunch? I'm going to eat a cheeseburger."

// Eventually, I hear, "Order 113!" and I gleefully walk back up to the counter with receipt in hand. I hand my receipt to the cashier, and I take my cheeseburger in return.

// But there's another possible outcome.  the cashier may regretfully inform me, "I'm sorry, but we appear to be all out of cheeseburgers."

// Every time I order a cheeseburger, I know that I'll either get a cheeseburger eventually, or I'll get the sad news of the cheeseburger shortage, and I'll have to figure out something else to eat for lunch.

// In code, things are not quite as simple, because metaphorically the order number may never be called, in which case we're left indefinitely in an unresolved state. We'll come back to dealing with that case later.


// Values Now and Later

// When you write code to reason about a value, such as performing math on a number, whether you realize it or not, you've been assuming something very fundamental about that value, which is that it's a concrete now value already:
var x, y = 2;
console.log(x + y); // NaN  <-- because `x` isn't set yet
// The x + y operation assumes both x and y are already set. In terms we'll expound on shortly, we assume the x and y values are already resolved.

Let's go back to our x + y math operation. Imagine if there was a way to say, "Add x and y , but if either of them isn'tready yet, just wait until they are.Add them as soon as you can."

function add(getX, getY, cb) {
    var x, y;
    getX(function (xVal) {
        x = xVal;
        // both are ready?
        if (y != undefined) {
            cb(x + y);
            // send along sum
        }
    });
    getY(function (yVal) {
        y = yVal;
        // both are ready?
        if (x != undefined) {
            cb(x + y);
            // send along sum
        }
    });
}
// `fetchX()` and `fetchY()` are sync or async
// functions
add(fetchX, fetchY, function (sum) {
    console.log(sum); // that was easy, huh?
});

// While the ugliness is undeniable, there's something very important to notice about this async pattern.

// In that snippet, we treated  x and y as future values, and we express an operation add(..) that (from the outside) does not care whether x or y or both are available right away or not. In other words, it normalizes the now and later, such that we can rely on a predictable outcome of the add(..) operation.
// To put it more plainly: to consistently handle both now and later, we make both of them later: all operations become async.

// let's just briefly glimpse at how we can express the x + y example via Promise s:

function add(xPromise, yPromise) {
    // `Promise.all([ .. ])` takes an array of promises,
    // and returns a new promise that waits on them
    // all to finish
    return Promise.all([xPromise, yPromise])
        // when that promise is resolved, let's take the
        // received `X` and `Y` values and add them together.
        .then(function (values) {
            // `values` is an array of the messages from the
            // previously resolved promises
            return values[0] + values[1];
        }
}
// `fetchX()` and `fetchY()` return promises for
// their respective values, which may be ready
// *now* or *later*.
add(fetchX(), fetchY())
    // we get a promise back for the sum of those
    // two numbers.
    // now we chain-call `then(..)` to wait for the
    // resolution of that returned promise.
    .then(function (sum) {
        console.log(sum); // that was easier!
    });


// There are two layers of Promises in this snippet.
// fetchX() and fetchY() are called directly, and the values they return (promises!) are passed into add(..). The underlying values those promises represent may be ready now or later, but each promise normalizes the behavior to be the same regardless. We reason about X and Y values in a time-independent way. They are future values.
// The second layer is the promise that add(..) creates (via Promise.all([ .. ]) ) and returns, which we wait on by callingthen(..) . When the add(..) operation completes, our sum future value is ready and we can print it out. We hide inside ofadd(..) the logic for waiting on the X and Y future values.    


// With Promises, the  then(..) call can actually take two functions, the first for fulfillment (as shown earlier), and the second for rejection:
add(fetchX(), fetchY())
    .then(
        // fullfillment handler
        function (sum) {
            console.log(sum);
        },
        // rejection handler
        function (err) {
            console.error(err); // bummer!
        }
    );
// If something went wrong getting X or Y , or something somehow failed during the addition, the promise that add(..)returns is rejected, and the second callback error handler passed to then(..) will receive the rejection value from the promise.

// Because Promises encapsulate the time-dependent state -- waiting on the fulfillment or rejection of the underlying value -- from the outside, the Promise itself is time-independent, and thus Promises can be composed (combined) in predictable ways regardless of the timing or outcome underneath.

// Moreover, once a Promise is resolved, it stays that way forever -- it becomes an immutable value at that point -- and can then be observed as many times as necessary.

// Thenable Duck Typing
// In Promises-land, an important detail is how to know for sure if some value is a genuine Promise or not. Or more directly, is it a value that will behave like a Promise?

// Promise Scheduling Quirks
var p3 = new Promise(function (resolve, reject) {
    resolve("B");
});
var p1 = new Promise(function (resolve, reject) {
    resolve(p3);
});
var p2 = new Promise(function (resolve, reject) {
    resolve("A");
});
p1.then(function (v) {
    console.log(v);
});
p2.then(function (v) {
    console.log(v);
});
// A B          < --not B A as you might expect

// p1 is resolved not with an immediate value, but with another promise p3 which is itself resolved with the value "B" . The specified behavior is to unwrap p3 into p1 , but asynchronously, so p1 's callback(s) are behind p2 's callback(s) in the asynchronus Job queue


// Promises can have, at most, one resolution value (fulfillment or rejection). If you don't explicitly resolve with a value either way, the value is undefined. If you want to pass along multiple values, you must wrap them in another single value that you pass, such as an array or an object.
// If you reject a Promise with a reason (aka error message), that value is passed to the rejection callback(s). If at any point in the creation of a Promise, or in the observation of its resolution, a JS exception error occurs, such as a TypeError or ReferenceError , that exception will be caught, and it will force the Promise in question to become rejected.

// For example:

var p = new Promise(function (resolve, reject) {
    foo.bar(); // `foo` is not defined, so error!
    resolve(42); // never gets here :(
});
p.then(
    function fulfilled() {
        // never gets here :(
    },
    function rejected(err) {
        // `err` will be a `TypeError` exception object
        // from the `foo.bar()` line.
    }
);

// Promises turn even JS exceptions into asynchronous behavior, thereby reducing the race condition chances greatly.
// if a Promise is fulfilled, but there's a JS exception error during the observation (in a then(..) registered callback)? Even those aren't lost, but you may find how they're handled a bit surprising, until you dig in a little deeper:

var p = new Promise(function (resolve, reject) {
    resolve(42);
});
p.then(
    function fulfilled(msg) {
        foo.bar();
        console.log(msg);
        // never gets here :(
    },
    function rejected(err) {
        // never gets here either :(
    }
);

// Wait, that makes it seem like the exception from foo.bar() really did get swallowed. Never fear, it didn't. But something deeper is wrong, which is that we've failed to listen for it. The p.then(..) call itself returns another promise, and it's that promise that will be rejected with the TypeError exception.

// Why couldn't it just call the error handler we have defined there? Seems like a logical behavior on the surface. But it would violate the fundamental principle that Promises are immutable once resolved. p was already fulfilled to the value 42 , so it can't later be changed to a rejection just because there's an error in observing p's resolution.

// Besides the principle violation, such behavior could wreak havoc, if say there were multiple then(..) registered callbacks on the promise p, because some would get called and others wouldn't, and it would be very opaque as to why.

// Trustable Promise?

// You've no doubt noticed that Promises don't get rid of callbacks at all. They just change where the callback is passed to. Instead of passing a callback to foo(..) , we get something (ostensibly a genuine Promise) back from foo(..) , and we pass the callback to that something instead.
// But why would this be any more trustable than just callbacks alone? How can we be sure the something we get back is in fact a trustable Promise? Isn't it basically all just a house of cards where we can trust only because we already trusted? One of the most important, but often overlooked, details of Promises is that they have a solution to this issue as well. Included with the native ES6 Promise implementation is Promise.resolve(..) .If you pass an immediate, non-Promise, non-thenable value to Promise.resolve(..) , you get a promise that's fulfilled with that value. In other words, these two promises p1 and p2 will behave basically identically:

var p1 = new Promise(function (resolve, reject) {
    resolve(42);
});
var p2 = Promise.resolve(42);
// But if you pass a genuine Promise to Promise.resolve(..) , you just get the same promise back:
var p1 = Promise.resolve(42);
var p2 = Promise.resolve(p1);
p1 === p2; // true

// Promise.resolve(..) will accept any thenable, and will unwrap it to its non-thenable value. But you get back from Promise.resolve(..) a real, genuine Promise in its place, one that you can trust. If what you passed in is already a genuine Promise, you just get it right back, so there's no downside at all to filtering through Promise.resolve(..) to gain trust.

// So let's say we're calling a foo(..) utility and we're not sure we can trust its return value to be a well-behaving Promise, but we know it's at least a thenable. Promise.resolve(..) will give us a trustable Promise wrapper to chain off of:
// don't just do this:
foo(42)
    .then(function (v) {
        console.log(v);
    });
// instead, do this:
Promise.resolve(foo(42))
    .then(function (v) {
        console.log(v);
    });

// Note: Another beneficial side effect of wrapping Promise.resolve(..) around any function's return value (thenable or not) is that it's an easy way to normalize that function call into a well-behaving async task. If foo(42) returns an immediate value sometimes, or a Promise other times, Promise.resolve( foo(42) ) makes sure it's always a Promise result. And avoiding Zalgo makes for much better code.

// Chain Flow

// we can string multiple Promises together to represent a sequence of async steps. The key to making this work is built on two behaviors intrinsic to Promises:

// Every time you call  then(..) on a Promise, it creates and returns a new Promise, which we can chain with.
// Whatever value you return from the then(..) call's fulfillment callback (the first parameter) is automatically set as the fulfillment of the chained Promise (from the first point).

var p = Promise.resolve(21);
var p2 = p.then(function (v) {
    console.log(v); // 21
    // fulfill `p2` with value `42`
    return v * 2;
});
// chain off `p2`
p2.then(function (v) {

    console.log(v); // 42
});

// But it's a little annoying to have to create an intermediate variable p2 (or p3 , etc.). Thankfully, we can easily just chain these together:
var p = Promise.resolve(21);
p
    .then(function (v) {
        console.log(v); // 21
        // fulfill the chained promise with value `42`
        return v * 2;
    })
    // here's the chained promise
    .then(function (v) {
        console.log(v); // 42
    });
// So now the first then(..) is the first step in an async sequence, and the second then(..) is the second step. This could keep going for as long as you needed it to extend. 

// But there's something missing here. What if we want step 2 to wait for step 1 to do something asynchronous? We're using an immediate return statement, which immediately fulfills the chained promise. e.g. setTimeout(function () { return v * 2; }, 100);

// so instead of setTimeout(function () { return v * 2; }, 100); we need to write return new Promise(function (resolve, reject) { setTimeout(function () { resolve (v * 2); }, 100);  });


// That's incredibly powerful! Now we can construct a sequence of however many async steps we want, and each step can delay the next step (or not!), as necessary.

// To further the chain illustration, let's generalize a delay-Promise creation (without resolution messages) into a utility we can reuse for multiple steps:
function delay(time) {
    return new Promise(function (resolve, reject) {
        setTimeout(resolve, time);
    });
}
delay(100) // step 1
    .then(function STEP2() {
        console.log("step 2
            (after 100ms)" );
return delay(200);
    })
    .then(function STEP3() {
        console.log("step 3
            (after another 200ms)" );
})
    .then(function STEP4() {
        console.log("step 4
            (next Job)" );
return delay(50);
    })
    .then(function STEP5() {
        console.log("step 5
            (after another 50ms)" );
})
...


// Let's review briefly the intrinsic behaviors of Promises that enable chaining flow control: A then(..) call against one Promise automatically produces a new Promise to return from the call.
// Inside the fulfillment/rejection handlers, if you return a value or an exception is thrown, the new returned (chainable) Promise is resolved accordingly.
// If the fulfillment or rejection handler returns a Promise, it is unwrapped, so that whatever its resolution is will become the resolution of the chained Promise returned from the current then(..).

// Error Handling
// The most natural form of error handling for most developers is the synchronous try..catch construct. Unfortunately, it's synchronous-only, so it fails to help in async code patterns:
function foo() {
    setTimeout(function () {
        baz.bar();
    }, 100);
}
try {
    foo();
    // later throws global error from `baz.bar()`
}
catch (err) {
    // never gets here
}

// try..catch would certainly be nice to have, but it doesn't work across async operations. That is, unless there's some additional environmental support, which we'll come back to with generators later

// In callbacks, some standards have emerged for patterned error handling, 
// 1. most notably the "error-first callback" style:

function foo(cb) {
    setTimeout(function () {
        try {
            var x = baz.bar();
            cb(null, x); // success!
        }
        catch (err) {
            cb(err);
        }
    }, 100);
}
foo(function (err, val) {
    if (err) {
        console.error(err); // bummer :(
    }
    else {
        console.log(val);
    }
});

// Note: The try..catch here works only from the perspective that the baz.bar() call will either succeed or fail immediately, synchronously. If  baz.bar() was itself its own async completing function, any async errors inside it would not be catchable. 
// The callback we pass to foo(..) expects to receive a signal of an error by the reserved first parameter err . If present, error is assumed. If not, success is assumed.
// This sort of error handling is technically async capable, but it doesn't compose well at all. Multiple levels of error-first callbacks woven together with these ubiquitous if statement checks inevitably will lead you to the perils of callback hell

// 2. Some developers have claimed that a "best practice" for Promise chains is to always end your chain with a final catch(..) , like:

var p = Promise.resolve(42);
p.then(
    function fulfilled(msg) {
        // numbers don't have string functions,
        // so will throw an error
        console.log(msg.toLowerCase());
    }
)
    .catch(handleErrors);

// Because we didn't pass a rejection handler to the then(..) , the default handler was substituted, which simply propagates the error to the next promise in the chain. As such, both errors that come into p , and errors that come after p in its resolution (like the msg.toLowerCase() one) will filter down to the final handleErrors(..)

// Now What happens if handleErrors(..) itself also has an error in it? Who catches that? There's still yet another unattended promise: the one catch(..) returns, which we don't capture and don't register a rejection handler for.


// Promise Patterns
// There are lots of variations on asynchronous patterns that we can build as abstractions on top of Promises.

// Promise.all([ .. ])
// In an async sequence (Promise chain), only one async task is being coordinated at any given moment -- step 2 strictly follows step 1, and step 3 strictly follows step 2. But what about doing two or more steps concurrently (aka "in parallel")?
// In classic programming terminology, a "gate" is a mechanism that waits on two or more parallel/concurrent tasks to complete before continuing. It doesn't matter what order they finish in, just that all of them have to complete for the gate to open and let the flow control through.
// Say you wanted to make two Ajax requests at the same time, and wait for both to finish, regardless of their order, before making a third Ajax request. Consider:

// `request(..)` is a Promise-aware Ajax utility,
// like we defined earlier in the chapter
var p1 = request("http://some.url.1/");
var p2 = request("http://some.url.2/");
Promise.all([p1, p2])
    .then(function (msgs) {
        // both `p1` and `p2` fulfill and pass in
        // their messages here
        return request(
            "http://some.url.3/?v=" + msgs.join(",")
        );
    })
    .then(function (msg) {
        console.log(msg);
    });

// Promise.all([ .. ]) expects a single argument, an array , consisting generally of Promise instances. Technically, the array of values passed into  Promise.all([ .. ]) can include Promises, thenables, or even immediate values. Each value in the list is essentially passed through Promise.resolve(..) to make sure it's a genuine Promise to be waited on, so an immediate value will just be normalized into a Promise for that value. If the array is empty, the main Promise is immediately fulfilled.

// The main promise returned from Promise.all([ .. ]) will only be fulfilled if and when all its constituent promises are fulfilled. If any one of those promises instead is rejected, the main Promise.all([ .. ]) promise is immediately rejected, discarding all results from any other promises.
// Remember to always attach a rejection/error handler to every promise, even and especially the one that comes back from Promise.all([ .. ])

// Promise.race([ .. ])
// sometimes you only want to respond to the "first Promise to cross the finish line," letting the other Promises fall away. This pattern is classically called a "latch," but in Promises it's called a "race."
// Don't confuse Promise.race([..]) with "race condition."
// Promise.race([ .. ]) also expects a single array argument, containing one or more Promises, thenables, or immediate values. It doesn't make much practical sense to have a race with immediate values, because the first one listed willobviously win -- like a foot race where one runner starts at the finish line!
// `request(..)` is a Promise-aware Ajax utility,
// like we defined earlier in the chapter
var p1 = request("http://some.url.1/");
var p2 = request("http://some.url.2/");
Promise.race([p1, p2])
    .then(function (msg) {
        // either `p1` or `p2` will win the race
        return request(
            "http://some.url.3/?v=" + msg
        );
    })
    .then(function (msg) {
        console.log(msg);
    });
// Because only one promise wins, the fulfillment value is a single message, not an  array as it was for Promise.all([ .. ])
// While native ES6 Promises come with built-in Promise.all([ .. ]) and Promise.race([ .. ]) , there are several other commonly used patterns with variations on those semantics:

// none([ .. ]) is like all([ .. ]) , but fulfillments and rejections are transposed. All Promises need to be rejected --rejections become the fulfillment values and vice versa.
// any([ .. ]) is like all([ .. ]) , but it ignores any rejections, so only one needs to fulfill instead of all of them.
// first([ .. ]) is a like a race with any([ .. ]) , which is that it ignores any rejections and fulfills as soon as the first Promise fulfills.
// last([ .. ])  is like first([ .. ]) , but only the latest fulfillment wins.

// Promise API Recap

// new Promise(..) Constructor
// The revealing constructor Promise(..) must be used with new , and must be provided a function callback that is synchronously/immediately called. This function is passed two function callbacks that act as resolution capabilities for thepromise. We commonly label these resolve(..) and reject(..) :
var p = new Promise(function (resolve, reject) {
    // `resolve(..)` to resolve/fulfill the promise
    // `reject(..)` to reject the promise
});

// reject(..) simply rejects the promise, but resolve(..) can either fulfill the promise or reject it, depending on what it's passed. If resolve(..) is passed an immediate, non-Promise, non-thenable value, then the promise is fulfilled with that value. But if resolve(..) is passed a genuine Promise or thenable value, that value is unwrapped recursively, and whatever its final resolution/state is will be adopted by the promise.

// A shortcut for creating an already-rejected Promise is Promise.reject(..) , so these two promises are equivalent:
var p1 = new Promise(function (resolve, reject) {
    reject("Oops");
});

var p2 = Promise.reject("Oops");

// Each Promise instance (not the Promise API namespace) has then(..) and catch(..) methods, which allow registering of fulfillment and rejection handlers for the Promise. Once the Promise is resolved, one or the other of these handlers will be called, but not both, and it will always be called asynchronously

// then(..) takes one or two parameters, the first for the fulfillment callback, and the second for the rejection callback. If either is omitted or is otherwise passed as a non-function value, a default callback is substituted respectively. The default fulfillment callback simply passes the message along, while the default rejection callback simply rethrows (propagates) the error reason it receives.

// catch(..) takes only the rejection callback as a parameter, and automatically substitutes the default fulfillment callback, as just discussed. In other words, it's equivalent to  then(null,..):
p.then(fulfilled);
p.then(fulfilled, rejected);
p.catch(rejected); // or `p.then( null, rejected )`

// then(..) and catch(..) also create and return a new promise, which can be used to express Promise chain flow control. If the fulfillment or rejection callbacks have an exception thrown, the returned promise is rejected. If either callback returnsan immediate, non-Promise, non-thenable value, that value is set as the fulfillment for the returned promise. If the fulfillment handler specifically returns a promise or thenable value, that value is unwrapped and becomes the resolution of the returned promise.


// Promise Limitations
Single Value
// Promises by definition only have a single fulfillment value or a single rejection reason. In simple examples, this isn't that big of a deal, but in more sophisticated scenarios, you may find this limiting. The typical advice is to construct a values wrapper (such as an object or array ) to contain these multiple messages. This solution works, but it can be quite awkward and tedious to wrap and unwrap your messages with every single step of your Promise chain.

// Splitting Values
// Sometimes you can take this as a signal that you could/should decompose the problem into two or more Promises.
// Imagine you have a utility  foo(..) that produces two values (x and y ) asynchronously:
function getY(x) {
    return new Promise(function (resolve, reject) {
        setTimeout(function () {
            resolve((3 * x) - 1);
        }, 100);
    });
}
function foo(bar, baz) {
    var x = bar * baz;
}
return getY(x)
    .then(function (y) {
        // wrap both values into container
        return [x, y];
    });
foo(10, 20)
    .then(function (msgs) {
        var x = msgs[0];
        var y = msgs[1];
        console.log(x, y);
    });
// First, let's rearrange what foo(..) returns so that we don't have to wrap x and y into a single array value to transport through one Promise. Instead, we can wrap each value into its own promise:

function foo(bar, baz) {
    var x = bar * baz;
}
// return both promises
return [
    Promise.resolve(x),
    getY(x)
];
Promise.all(
    foo(10, 20)
)
    .then(function (msgs) {
        var x = msgs[0];
        var y = msgs[1];
        console.log(x, y);
    });

// Is an array of promises really better than an array of values passed through a single promise? Syntactically, it's not much of an improvement.
// But this approach more closely embraces the Promise design theory. It's now easier in the future to refactor to split the calculation of  x and y into separate functions.
// It's cleaner and more flexible to let the calling code decide how to orchestrate the two promises -- using Promise.all([ .. ])

// Unwrap/Spread Arguments
// The var x = .. and var y = .. assignments are still awkward overhead. 

// ES6 offers new tricks
// The array destructuring assignment form looks like this:
Promise.all(
    foo(10, 20)
)
    .then(function (msgs) {
        var [x, y] = msgs;
        console.log(x, y);
    });

// the array parameter destructuring form:
Promise.all(
    foo(10, 20)
)
    .then(function ([x, y]) {
        console.log(x, y);
    });

// Inertia
// One concrete barrier to starting to use Promises in your own code is all the code that currently exists which is not already promise-aware. If you have lots of callback-based code, it's far easier to just keep coding in that same style.
// "A code base in motion (with callbacks) will remain in motion (with callbacks) unless acted upon by a smart, Promises-aware developer."
// Promises offer a different paradigm, and as such, the approach to the code can be anywhere from just a little different to, in some cases, radically different. You have to be intentional about it, because Promises will not just naturally shake out from the same ol' ways of doing code that have served you well thus far.


/*********************************************************************************************************** */
/*********************************************************************************************************** */
/*********************************************************************************************************** */
// Chapter 4: Generators
// Generators help expressing async flow control in a sequential, synchronous-looking fashion.
// A generator is a special kind of function that can start and stop one or more times, and doesn't necessarily ever have to finish.
// A generator function is a special function with the new processing model 
// Breaking Run-to-Completion
var x = 1;
function* foo() { // function* foo() can be used as well, the only difference being the stylistic positioning of the *
    x++;
    yield; // pause!
    console.log("x:", x);
}
function bar() {
    x++;
}


var it = foo(); // construct an iterator `it` to control the generator
it.next();// start `foo()` here!
x; //2
bar();
x;// 3
it.next();// x: 3



// 1. The it = foo() operation does not execute the *foo() generator yet, but it merely constructs an iterator that will control its execution. More on iterators in a bit.
// 2. The first it.next() starts the *foo() generator, and runs the x++ on the first line of *foo()
// 3. *foo() pauses at the yield statement, at which point that first it.next() call finishes. At the moment, *foo() is still running and active, but it's in a paused state.
// 4. We inspect the value of x , and it's now 2 .
// 5. We call bar() , which increments x again with x++ .
// 6. We inspect the value of x again, and it's now 3 .
// 7. The final it.next() call resumes the *foo() generator from where it was paused, and runs the console.log(..)statement, which uses the current value of x of 3 .

// Clearly, foo() started, but did not run-to-completion -- it paused at the yield . We resumed foo() later.Add
// Notice something very important but also easily confusing, there's a mismatch between the yield and the next(..) call. In general, you're going to have one more next(..) call than you have yield  statements -- the preceding  snippet has one yield and two  next(..) calls.


// Mssages can go in both directions --  yield ..  as an expression can send out messages in response to next(..) calls, and next(..) can send values to a paused yield expression. Consider this slightly adjusted code:

function* foo(x) {
    var y = x * (yield "Hello"); // <-- yield a value!
    return y;
}
var it = foo(6);
var res = it.next(); // first `next()`, don't pass anything
res.value; // "Hello"
res = it.next(7); // pass `7` to waiting `yield`
res.value; // 42


// Multiple Iterators

function* foo() {
    var x = yield 2;
    z++;
    var y = yield (x * z);
    console.log(x, y, z);
}
var z = 1;
var it1 = foo();
var it2 = foo();
var val1 = it1.next().value;   // 2 <-- yield 2
var val2 = it2.next().value;   // 2 <-- yield 2
val1 = it1.next(val2 * 10).value; // 40 <-- x:20, z:2
val2 = it2.next(val1 * 5).value;  // 600 <-- x:200, z:3
it1.next(val2 / 2); // 20 300 3    y:300
it2.next(val1 / 4); // 200 10 3    y:10


// Generator'ing Values

var something = (function () {
    var nextVal;
    return {
        // needed for `for..of` loops
        [Symbol.iterator]: function () { return this; },
        // standard iterator interface method
        next: function () {
            if (nextVal === undefined) {
                nextVal = 1;
            }
            else {
                nextVal = (3 * nextVal) + 6;
            }
        };
    }) ();
}
    return { done: false, value: nextVal };
something.next().value; // 1
something.next().value; // 9
something.next().value; // 33

//This standard iterator can automatically be consumed with native loop syntax
for (var v of something) {
    console.log(v);
    // don't let the loop run forever!
    // Because our something iterator always returns done:false , otherwise this for..of loop would run forever, 
    if (v > 500) {
        break;
    }
}
    // 1 9 33 105 321 969











/*********************************************************************************************************** */
/*********************************************************************************************************** */
/*********************************************************************************************************** */
