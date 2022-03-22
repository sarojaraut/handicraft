Techniques 
return el.toLowerCase().indexOf(query.toLowerCase()) !== -1 // returrns true if el contains string query
Number.isFinite(item.id) && item.id !== 0 // returns if ite.id is neither null nor undefined nor NaN nor 0

/*
Filter : array.filter(function(currentValue, index, arr), thisValue)
Map : array.map(function(currentValue, index, arr), thisValue)
Find : array.find(function(currentValue, index, arr),thisValue)
forEach : array.forEach(function(currentValue, index, arr), thisValue)
some : array.some(function(currentValue, index, arr), thisValue)
every : array.every(function(currentValue, index, arr), thisValue)
reduce : array.reduce(function(total, currentValue, currentIndex, arr), initialValue)
includes : array.includes(element, start)



The filter() method returns an array filled with all array elements that pass a test (provided as a function).
The map() method returns a new array with the results of calling a function for every array element.
The find() method returns the value of the first element in an array that pass a test (provided as a function).
The forEach() method calls a function once for each element in an array, in order.
The some() method executes the function once for each element present in the array:
    If it finds an array element where the function returns a true value, some() returns true (and does not check the remaining values)
    Otherwise it returns false
The every() method executes the function once for each element present in the array:
    If it finds an array element where the function returns a false value, every() returns false (and does not check the remaining values)
    If no false occur, every() returns true
The reduce() method reduces the array to a single value. The reduce() method executes a provided function for each value of the array (from left-to-right). The return value of the function is stored in an accumulator (result/total).
The includes() method determines whether an array contains a specified element. This method returns true if the array contains the element, and false if not.

Argument Description
function(currentValue, index,arr) 	Required. A function to be run for each element in the array.
Function arguments:
currentValue 	Required. The value of the current element
index 	Optional. The array index of the current element
arr 	Optional. The array object the current element belongs to
thisValue 	Optional. A value to be passed to the function to be used as its "this" value.

Arguments for includes
element 	Required. The element to search for
start 	Optional. Default 0. At which position in the array to start the search

Examples
items.filter((item) => { return item.price >= 100 });
items.map((item) => { return { name: item.name, price: item.price, promoPrice: item.price * 0.9 } });

*/

//Filter

const items = [
    { name: "Bike", price: 1000 },
    { name: "Book", price: 10 },
    { name: "TV", price: 300 },
    { name: "car", price: 30000 },
    { name: "Rack", price: 150 },
    { name: "phone", price: 300 },
    { name: "watch", price: 300 }
];


// Filter Example
const costlyItems = items.filter((item) => { return item.price >= 100 });
// const costlyItems = items.filter(item => item.price >= 100); short hand for above line
// we can remove the bracket around item because it has only one argument
// we can remove curly brace around function becase it has only one stmt
console.log(costlyItems);

const a1 = [1, 4, 9, 16];

sqrta1 = a1.map(val => Math.sqrt(val) )



/*

//offering 10% discount on all items
const discountedPrice = items.map((item) => { return { name: item.name, price: item.price, promoPrice: item.price * 0.9 } });
console.log(discountedPrice);

*/

/*
//Find
const bookItem = items.find((item) => {return item.name === 'Book'});
console.log(bookItem);
*/

/*

// forEach
let total = 0;
items.forEach((item) => {console.log(item.name); total += item.price;});
console.log(total);

//increase price by 10%
total=0;
items.forEach((item, index, arr) => { arr[index].price = item.price * 1.1; total += arr[index].price;});
*/


/*
// if any item has price over 
// exits as soon as it find one item
hasExpensiveItem = items.some((item) => { console.log(item);return item.price >=30000 });
console.log(hasExpensiveItem);

*/

/*
//reduce
//increase price by 10%
// observe how it's different from other methods, passing current total as first argument and an initial value as last argument 
total = items.reduce((currentTotal, item,) => { return currentTotal + item.price}, 0);
console.log(total);
*/

// let book = { name: "Book", price: 10 };
let book = items[1];
// const hasBook = items.includes({ name: "Book", price: 10 });
const hasBook = items.includes(book);
console.log(hasBook);

--- MDN 



// Java Script Array Methods : push, pop, shift, unshift 
let fruits = ['Apple', 'Banana']
console.log(fruits.length) // 2
let last = fruits[fruits.length - 1] // Banana
fruits.forEach(function(item, index, array) {
  console.log(item, index)
}) // Apple 0, Banana 1

let first = fruits.shift() // remove Apple from the front
// ["Banana"]
let newLength = fruits.unshift('Strawberry') // add to the front
// ["Strawberry", "Banana"]
let pos = fruits.indexOf('Banana') // 1

let removedItem = fruits.splice(pos, 1) //Remove an item by index position
// ["Strawberry", "Mango"]

let vegetables = ['Cabbage', 'Turnip', 'Radish', 'Carrot']
let pos = 1
let n = 2
let removedItems = vegetables.splice(pos, n)
// this is how to remove items, n defines the number of items to be removed,
// starting at the index position specified by pos and progressing toward the end of array.
console.log(vegetables)
// ["Cabbage", "Carrot"] (the original array is changed)
console.log(removedItems)
// ["Turnip", "Radish"]


// Using an array to tabulate a set of values
values = []
for (let x = 0; x < 10; x++){
 values.push([
  2 ** x,
  2 * x ** 2
 ])
}
console.table(values)


let words = ['spray', 'limit', 'exuberant', 'destruction', 'elite', 'present']

const modifiedWords = words.filter( (word, index, arr) => {
  arr[index+1] +=' extra'
  return word.length < 6
})

console.log(modifiedWords)


Finding unique values in an array or remove duplicates: [...new Set([1,2,3,4,3,2,1])] // [1, 2, 3, 4]

a = [1,2,3,4,3,2,1]
a.filter((v,i) => a.indexOf(v) === i) //  [1, 2, 3, 4]
a.filter((v,i) => a.indexOf(v) !== i) // [3, 2, 1] 

a.reduce((arr,i) => arr.includes(i) ? arr : [...arr, i],[]) //[1, 2, 3, 4] second argument of reduce method is must