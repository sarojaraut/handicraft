// variable created using var are not block scoped
for (var i = 0; i <= 3; i++) {
    console.log(i);
}

console.log('Outside Loop', i);

// variable created using var are not block scoped
for (let j = 0; j <= 3; j++) {
    console.log(j);
}


console.log( a );
var a = 2;