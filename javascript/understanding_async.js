console.log("start");
for (i = 0; i <= 3; i++) {
    setTimeout(() => {
        console.log(i);
    }, 100);
}
// above block is going to print 4 four times
console.log("End");

var startDate = new Date();
var endDate;

setTimeout(() => {
    endDate = new Date();
    console.log("Elapsed time :", endDate - startDate);
    // elapsed time will be printed as at least 1000 because of while loop
}, 500);

while (new Date - startDate <= 1000) { }
// When we call setTimeout , a timeout event is queued. Then execution continues: the line after the setTimeout call runs, and then the line after that, and so on, until there are no lines left. Only then does the JavaScript virtual machine ask, “What’s on the queue?”