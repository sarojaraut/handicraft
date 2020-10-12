// factory function way of creating objects
function createCircle(radius){
    circle={
        radius, // if parameter name is same as attribute name then only specifying attribute name is enough
        draw : function(){
            console.log("createCircle - draw circle");
        }
    };
    return circle;
    // or we could have used return { ... } on line number 2
}
let circle1 = createCircle(1);

//constructor function way of creating objects
function Circle(radius){
    // console.log('this :',this);
    this.radius = radius;
    this.draw = () => {
        console.log("Circle - draw circle");
    };
}
let circle2 = new Circle(2);
//console.log in Circle class prints Circle with new keyword
//but same console.log in Circle class prints window without new keyword
// new keyword kind of creates a empy object and associates all this attributes to the empty object
// console.log(circle1);
// console.log(circle2);

console.log(circle1.constructor); 
//index.js:29 ƒ Object() { [native code] }
// let x = {} is transalated something as let x = new object and thats why the object native code as constructor
console.log(circle2.constructor); 
/*
index.js:30 ƒ Circle(radius){
    // console.log('this :',this);
    this.radius = radius;
    this.draw = () => {
        console.log("Circle - draw circle");
    };
}
*/