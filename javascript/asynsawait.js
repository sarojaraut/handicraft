function promiseTimeout(ms){
    return new Promise((resolve, reject)=>{
        setTimeout(resolve, ms);
    });
}

async function run(){
    // await can be used for calling a function returning promise
    console.log('start');
    promiseTimeout(2000); // code executiom will appear to halt here before going to the next line
    // without await both start and end would have been printed instantly
    console.log('End');
}   

run();