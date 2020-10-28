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


That's the first major deficiency to articulate about callbacks. There's something much deeper to be concerned about.
