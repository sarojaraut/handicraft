/*
Filter : items.filter((item) => { return item.price >= 100 });

*/

//Filter

const items = [
    { name: "Bike", price: 1000 },
    { name: "Book", price: 10 },
    { name: "TV", price: 300 },
    { name: "Rack", price: 150 },
    { name: "phone", price: 300 },
    { name: "watch", price: 300 }
];

// const costlyItems = items.filter((item) => { return item.price >= 100 });
// console.log(costlyItems);

// const itemNames = items.map((item,index,itemNames) => {
//     return item.name + index
// });

//offering 10% discount on all items
const discountedPrice = items.map((item) => {
    return { name: item.name, price: item.price, promoPrice: item.price * 0.9 }
});
console.log(discountedPrice);