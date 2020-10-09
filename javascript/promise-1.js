function one() {
    return "from one";
}

function two() {
    return new Promise((resolve,reject)=>{
        setTimeout(()=>{
            console.log("Called Two");
            resolve ("from Two");
        },3000); 
    });

}

// function two() {
//         setTimeout(()=>{
//             console.log("Called Two");
//             return ("from Two");
//         },3000); 

// }

function three() {
    return "from three";
}

const callMe =  async () => { // async function is needed as await can only be called within an sync function
    let oneOutput = one();
    console.log(oneOutput);
    let twoOutput = await two(); // await can be used only within one async function
    console.log(twoOutput);
    let threeOutput = three();
    console.log(threeOutput);
}

callMe();
// without async await and unpromised version of function two this program would return like below
/*
from one
undefined
from three
Called Two

*/