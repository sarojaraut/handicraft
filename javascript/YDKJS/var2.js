// Block scoping is very usefulfor managing your variable scopes in a more fine-grained fashion,
let l1 = 10;
var v1 = 100
const c1 = 1000

function f1() {
    let l2 = 20;
    var v2 = 200
    const c2 = 2000;

    if (true) {
        let l3 = 30;
        var v3 = 300;
        const c3 = 3000;

        console.log(`All let Variables : Within fun and if block l1=${l1} l2=${l2} l3=${l3}`);
    }
    console.log(`All let Variables : Within fun but outside if block l1=${l1} l2=${l2}`); // l3 not accessible
    console.log(`All var Variables : Within fun and if block v1=${v1} v2=${v2} v3=${v3}`); // all vars accessible
    console.log(`All var Variables : Within fun and if block c1=${c1} c2=${c2}`); // c3 not accessible
}

f1();

console.log(`All let Variables : outside fun l1=${l1}`); // l2, l3 not accessible
console.log(`All var Variables : outside fun v1=${v1}`); // v2, v3 not accessible
console.log(`All var Variables : outside fun c1=${c1}`); // c2, c3 not accessible