// prints 6 five times because i is global scope shared by each iteration

// for (var i = 1; i <= 5; i++) {
//     (function () {
//         setTimeout(function timer() {
//             console.log(i);
//         }, i * 100);
//     })();
// }



// creates a local scope for each iteration

// for (var i = 1; i <= 5; i++) {
//     (function (j) {
//         setTimeout(function timer() {
//             console.log(j);
//         }, j * 100);
//     })(i);
// }

// There’s a special behavior defined for let declarations used in the head of a for loop. This behavior says that the variable will be declared not just once for the loop, but each iteration. And, it will, helpfully, be initialized at each subsequent iteration with the value from the end of the previous iteration.

for (let i = 1; i <= 5; i++) {
    setTimeout(function timer() {
        console.log(i);
    }, i * 100);
}