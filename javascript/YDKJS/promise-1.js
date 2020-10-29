var p = Promise.resolve(21);
p
    .then(function (v) {
        console.log(v);
        // 21
        // fulfill the chained promise with value `42`
        // return v * 2;
        // setTimeout(function () { return v * 2; }, 100); 
        return new Promise(function (resolve, reject) { setTimeout(function () { resolve(v * 2); }, 100); });

    })
    // here's the chained promise
    .then(function (v) {
        console.log(v);
        // 42
    });

// But there's something missing here. What if we want step 2 to wait for step 1 to do something asynchronous? We're using an immediate return statement, which immediately fulfills the chained promise.
// so instead of setTimeout(function () { return v * 2; }, 100); we need to write return new Promise(function (resolve, reject) { setTimeout(function () { resolve (v * 2); }, 100);  });

