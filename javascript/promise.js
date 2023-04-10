

/*
function promiseTimeout(ms){
    return new Promise((resolve, reject)=>{
        setTimeout(resolve, ms);
    })
}

promiseTimeout(1000)
    .then(()=>{
        console.log('Done');
    }).then(()=>{
        console.log('Also Done');
    })
    .catch(()=>{
        console.log('Error');
    })
*/
function promiseTimeout(ms) {
    return new Promise((resolve, reject) => {
        setTimeout(resolve, ms);
    })
}

promiseTimeout(2000)
    .then(() => {
        console.log('Done');
        return promiseTimeout(1000);
    }).then(() => {
        console.log('Also Done');
        return Promise.resolve(42);
    }).then((result) => {
        console.log(result);
    }).catch(() => {
        console.log('Error');
    })

// new Promise(executor)
// executor : A function to be executed by the constructor. It receives two functions as parameters: resolveFunc and rejectFunc.
// Any errors thrown in the executor will cause the promise to be rejected
// resolveFunc and rejectFunc are also functions, and you can give them whatever actual names you want. Their signatures are simple: they accept a single parameter of any type.
// If resolver function called with a non-thenable value (a primitive, or an object whose then property is not callable, including when the property is not present), the promise is immediately fulfilled with that value.
// If resolver function  called with a thenable value (including another Promise instance), then the thenable's then method is saved and called in the future (it's always called asynchronously). The then method will be called with two callbacks, which are two new functions with the exact same behaviors as the resolveFunc and rejectFunc passed to the executor function. If calling the then method throws, then the current promise is rejected with the thrown error.


myPromise
    .then(handleFulfilledA, handleRejectedA)
    .then(handleFulfilledB, handleRejectedB)
    .then(handleFulfilledC, handleRejectedC);

myPromise
    .then((value) => `${value} and bar`)
    .then((value) => `${value} and bar again`)
    .then((value) => `${value} and again`)
    .then((value) => `${value} and again`)
    .then((value) => {
        console.log(value);
    })
    .catch((err) => {
        console.error(err);
    });