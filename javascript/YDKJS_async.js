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


































/************************************************************************************************************************** */
/************************************************************************************************************************** */
/************************************************************************************************************************** */

