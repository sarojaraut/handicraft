/***** Chapter 2 - Data Types and Variables ****/
var age = 12;
var numberOfSiblings = 1 + 3;
var numberOfCandies = 24, numberOfKids = 6;
var secondsInAMinute = 60;
var minutesInAnHour = 60;
var secondsInAnHour = secondsInAMinute * minutesInAnHour;

var highFives = 0;
++highFives;//1  first increment then use
highFives++; //1 first use then increment

var score = 10;
score += 7; // short hand for score = score + 7;

var myAwesomeString = "Something REALLY awesome!!!";

var numberNine = 9;
var stringNine = "9";
numberNine + numberNine; //18
stringNine + stringNine; //"99"

var java = "Java";
java.length; //4

var myName = "Saroj";
myName[0]; // "S"

var longString = "My long string is long";
longString.slice(3, 14); //"long string"
longString.slice(0, 2); // "My"
longString.slice(8);//"string is long"

myName.toUpperCase();//"SAROJ"

var javascriptIsCool = true;

var hadShower = true;
var hasBackpack = false;
hadShower && hasBackpack; //false
|| (or)
! (not)

Double Equals “equal-ish.” 

var stringNumber = "5";
var actualNumber = 5;
stringNumber === actualNumber; // false
stringNumber == actualNumber; // true

0 == false; //true
"false" == false; //false

//This is because when JavaScript tries to compare two values with double equals, it first tries to make them the same type. In this case, it converts the Boolean into a number. If you convert Booleans to numbers, false becomes 0 , and true becomes 1 .

undefined and null

They’re both used to mean “nothing,” but in slightly different ways. undefined is the value JavaScript uses when it doesn’t have a value for something. For example, when you create a new variable, if you don’t set its value to anything using the = operator, its value will be set to undefined.Double
The null value is usually used when you want to deliberately say “This is empty.”

/***** Chapter 3 - Arrays ****/


var daysOfWeek = ["Sun","Mon","Tue","Thu","Fri","Sat"]

daysOfWeek[0]; //"Sun"

var daysOfWeek=[];
daysOfWeek[0]="Sun";
daysOfWeek[1]="Mon";
daysOfWeek[2]="Tue";
daysOfWeek[3]="Wed";
daysOfWeek[4]="Thu";
daysOfWeek[5]="Fri";
daysOfWeek[6]="Sat";

// Mixing Data Types in an Array

var mixedData = ["Test",1.5,true];

// Properties and methods help you work with arrays
mixedData.length;

mixedData[mixedData.length-1];//last item of the array

mixedData.push(10); // after adding the item to the end of array returns the length of the array
mixedData.unshift("begining"); // after adding as first item of the array returns the length of the array
mixedData.pop(); //remove the last element and returns it
mixedData.shift()//remove and return the first element of an array

// Adding Arrays
var furryAnimals = ["Alpaca", "Ring-tailed Lemur", "Yeti"];
var scalyAnimals = ["Boa Constrictor", "Godzilla"];
var furryAndScalyAnimals = furryAnimals.concat(scalyAnimals);
// Joining Multiple Arrays
var furryAnimals = ["Alpaca", "Ring-tailed Lemur", "Yeti"];
var scalyAnimals = ["Boa Constrictor", "Godzilla"];
var featheredAnimals = ["Macaw", "Dodo"];
var allAnimals = furryAnimals.concat(scalyAnimals, featheredAnimals);
allAnimals;

// Finding the Index of an Element in an Array

var colors = ["red", "green", "blue"];
colors.indexOf("blue"); //2
colors.indexOf("purple");//-1

// Turning an Array into a String

colors.join()//"red,green,blue"
colors.join(" ")//"red,green,blue"
colors.join("")//"redgreenblue"
colors.reverse();//["blue", "green", "red"]

var randomBodyParts = ["Face", "Nose", "Hair"];
var randomAdjectives = ["Smelly", "Boring", "Stupid"];
var randomWords = ["Fly", "Marmot", "Stick", "Monkey", "Rat"];

var randomBodyPart = randomBodyParts[Math.floor(Math.random() * randomBodyParts.length)];
var randomAdjective = randomAdjectives[Math.floor(Math.random() * randomAdjectives.length)];
var randomWord = randomWords[Math.floor(Math.random() * randomWords.length)];


var randomInsult = "Your " + randomBodyPart + " is like a " + randomAdjective + " " + randomWord + "!!!";
randomInsult;

/* A smarter way to learn JS - Books

var pets=["dog", "cat", "fly", "bug", "ox"]

Use the splice method to insert one or more elements anywhere in an array
pets.splice(2, 2, "pig", "duck", "emu");

The first arg is the index of the position where you want to start adding if you're adding and deleting if you're deleting. 
The second arg is the number of existing elements to remove, starting with the first element
in this example we are going to inert three new items starting with second index i.e pig will be inerted as index=2 and then next two elements(fly and bug) will be replaced by three new items


Output : Array [ "fly", "bug" ]
Final array pets becomes : [ "dog", "cat", "pig", "duck", "emu", "ox" ]

You can make additions without removing any elements by stating second argument as 0
You can also remove elements without adding any by not mentioning any arguments as third argument.

Use the slice method to copy one or more consecutive elements in any position and put them into a new array. The original arrey remain unchanged

The first digit inside the parentheses is the index of the first element to be copied. The second digit is the index of the element after the last element to be copied. You must assigned the sliced array to an array it could be the same array and in that case the original array will get reduced.

var pets=["dog", "cat", "fly", "bug", "ox"]
var fewPets = pets.slice(2, 4); // ["fly", "bug"]

*/

/***** Chapter 4 - Objects ****/


var cat = {
    "legs": 3,
    "name": "Harmony",
    "color": "Tortoiseshell"
    };

var cat = {
    legs: 3,
    "full name": "Harmony Philomena Snuggly-Pants Morgan",
    color: "Tortoiseshell"
    };
        
// while a key is always a string (with or without quotes), the value for that key can be any kind of value, or even a variable containing a value.
cat["name"];
cat.name;

var cat = {};
cat["legs"] = 3;
cat["name"] = "Harmony";
cat["color"] = "Tortoiseshell";
cat;

var cat = {};
cat.legs = 3;
cat.name = "Harmony";
cat.color = "Tortoiseshell";
cat.isAwesome = true;

cat.isBrown;//undefined

// If you ask for a property that JavaScript doesn’t know about, it returns the special value undefined . undefined just means “There’s nothing here!”

// Combining Arrays and Objects

var dinosaurs = [
{name: "Tyrannosaurus Rex", period: "Late Cretaceous" },
{name: "Stegosaurus", period: "Late Jurassic" },
{name: "Plateosaurus", period: "Triassic" }
];

dinosaurs[0];
dinosaurs[1].period;

var movies = {
    "Finding Nemo": {
    releaseDate: 2003,
    duration: 100,
    actors: ["Albert Brooks", "Ellen DeGeneres", "Alexander Gould"],
    format: "DVD"
    },
    "Star Wars: Episode VI - Return of the Jedi": {
    releaseDate: 1983,
    duration: 134,
    actors: ["Mark Hamill", "Harrison Ford", "Carrie Fisher"],
    format: "DVD"
    },
    "Harry Potter and the Goblet of Fire": {
    releaseDate: 2005,
    duration: 157,
    actors: ["Daniel Radcliffe", "Emma Watson", "Rupert Grint"],
    format: "Blu-ray"
    }
};

var cars = {
        releaseDate: 2006,
        duration: 117,
        actors: ["Owen Wilson", "Bonnie Hunt", "Paul Newman"],
        format: "Blu-ray"
    };
movies["Cars"] = cars;

/***** Chapter 5 - The Basics of HTML ****/

<!DOCTYPE html>
<html>
    <head>
        <title>My first proper HTML page</title>
    </head>
    <body>
        <h1>Hello world!</h1>
        <p>My <em>first</em> <strong>web page</strong>.</p>
        <p>Let's add another <strong><em>paragraph</em></strong>.</p>
        <p><a href="http://xkcd.com">Click here</a> to read some excellent comics.</p>
    </body>
</html>

<a href="http://xkcd.com" title="xkcd: Land of geeky comics!">Click here</a>
When you hover your cursor over the link, you should see the text “xkcd: Land of geeky comics!”

/***** Chapter 6 - Conditionals and Loops ****/

var name = "Nicholas";
console.log("Hello " + name);
if (name.length > 7) {
    console.log("Wow, you have a REALLY long name!");
} else {
    console.log("Your name isn't very long.");
}

var lemonChicken = false;
var beefWithBlackBean = true;
var sweetAndSourPork = true;
if (lemonChicken) {
    console.log("Great! I'm having lemon chicken!");
} else if (beefWithBlackBean) {
    console.log("I'm having the beef.");
} else if (sweetAndSourPork) {
    console.log("OK, I'll have the pork.");
} else {
    console.log("Well, I guess I'll have rice then.");
}

var sheepCounted = 0;
while (sheepCounted < 10) {
    console.log("I have counted " + sheepCounted + " sheep!");
    sheepCounted++;
}

for (setup; condition; increment) {
    console.log("Do something");
    }
    
// The setup ( var sheepCounted = 0 ) is run before the loop s

var timesToSayHello = 3;
for (var i = 0; i < timesToSayHello; i++) {
    console.log("Hello :"+i);
}// 0 1 2

var timesToSayHello = 3;
for (var i = 0; i < timesToSayHello; ++i) {
    console.log("Hello :"+i);
}// 0 1 2

var timesToSayHello = 3;
for (var i = 0,j=0;   i < timesToSayHello; ++i,j++) {
    console.log("Hello :"+i+j);
}// 0 1 2

var animals = ["Lion", "Flamingo", "Polar Bear", "Boa Constrictor"];
for (var i = 0; i < animals.length; i++) {
console.log("This zoo contains a " + animals[i] + ".");
}

for (var x = 2; x < 10000; x = x * 2) {
    console.log(x);
}//print all the powers of 2 below the number 10,000

/***** Chapter 8 - Functions ****/
// Basic Anatomy of a Function
function () {
    console.log("Do something");
    }

var ourFirstFunction = function () {
    console.log("Hello world!");
    };

ourFirstFunction(); //Hello world!

var sayHelloTo = function (name) {
    console.log("Hello " + name + "!");
    };

var printMultipleTimes = function (howManyTimes, whatToDraw) {
    for (var i = 0; i < howManyTimes; i++) {
        console.log(i + " " + whatToDraw);
    }
};
//Returning Values from Functions
var double = function (number) {
    return number * 2;
};

var double = function (number) {
    return number * 2;
};
// The shorthand version looks like this:
function double(number) {
    return number * 2;
}

// The for...in loop
// The for...in loop iterates through the properties of an object, returning the names of the properties themselves. Here’s an example:
for (var myProp in myObject) {
alert(myProp + " = " + myObject[myProp]);
}

/***** Chapter 12 - Object-Oriented Programming ****/
// A Simple Object
var dog = {
    name: "Pancake",
    legs: 4,
    isAwesome: true
};
// Adding Methods to Objects
dog.bark = function () {
    console.log("Woof woof! My name is " + this.name + "!");
};
dog.bark(); //Woof woof! My name is Pancake!

// Sharing a Method Between Multiple Objects

var speak = function () {
    console.log(this.sound + "! My name is " + this.name + "!");
};

var pig = {
    sound: "Oink",
    name: "Charlie",
    speak: speak
};
var horse = {
    sound: "Neigh",
    name: "Marie",
    speak: speak
};
pig.speak(); //Oink! My name is Charlie!
horse.speak(); //Neigh! My name is Marie!
// if you have lots of methods or objects, adding the same methods to each object individually can become annoying

// Creating Objects Using Constructors
// Most JavaScript programmers start constructor names with a capital letter so it’s easy to see at a glance that they’re different from other functions.

var Car = function (x, y) {
    this.x = x;
    this.y = y;
};
var tesla = new Car(10, 20);

<!DOCTYPE html>
<html>
    <head>
        <title>Cars</title>
    </head>
    <body>
        <script src="https://code.jquery.com/jquery-2.1.0.js"></script>
        <script>
            var Car = function (x, y) {
                this.x = x;
                this.y = y;
            };
            var drawCar = function (car) {
                var carHtml = '<img src="http://nostarch.com/images/car.png">';
                var carElement = $(carHtml); 
                // pass carHTML to the $ function converts it from a string to a jQuery element. 
                // and we can tweak this element before adding it to the page.
                carElement.css({
                    position: "absolute",
                    left: car.x,
                    top: car.y
                });
                $("body").append(carElement);
            };

            var tesla = new Car(20, 20);
            var nissan = new Car(100, 200);
            drawCar(tesla);
            drawCar(nissan);

        </script>
    </body>
</html>

// A more object-oriented way to draw our cars would be to give each car object a draw method. Then, instead of writing drawCar(tesla) , you’d write tesla.draw() .
// In this case, the drawCar function is always meant to be used on car objects, so instead of saving drawCar as a separate function, we should include it as part of each car object.

// JavaScript prototypes make it easy to share functionality (as methods) between different objects. All constructors have a prototype property, and we can add methods to it. Any method that we add to a constructor’s prototype property will be available as a method to all objects created by that constructor.

var Car = function (x, y) {
    this.x = x;
    this.y = y;
};
Car.prototype.draw = function () {
    var carHtml = '<img src="http://nostarch.com/images/car.png">';
    this.carElement = $(carHtml); // this time we save it as a property of the object</img>/
    this.carElement.css({
        position: "absolute",
        left: this.x,
        top: this.y
    });
    $("body").append(this.carElement);
};
var tesla = new Car(20, 20);
var nissan = new Car(100, 200);
tesla.draw();
nissan.draw();

Car.prototype.moveRight = function () {
    this.x += 5;
    this.carElement.css({
        left: this.x,
        top: this.y
    });
};

Car.prototype.moveLeft = function () {
this.x -= 5;
this.carElement.css({
    left: this.x,
    top: this.y
});
};
Car.prototype.moveUp = function () {
this.y -= 5;
this.carElement.css({
    left: this.x,
    top: this.y
});
};
Car.prototype.moveDown = function () {
this.y += 5;
this.carElement.css({
    left: this.x,
    top: this.y
});
};

// In JavaScript, variables are either a complex type (e.g., Object, Array) or a primitive type (e.g., String, Integer). When a complex object is supplied as an argument, it is passed by reference to the function body. Instead of sending a copy of the variable, JavaScript sends a pointer to its location in the memory heap. Conversely, when passing a primitive type to a function, JavaScript passes by value.


/***** Chapter 9 - The DOM and jQuery ****/

// Replacing the Heading Text Using the DOM

<!DOCTYPE html>
<html>
    <head>
        <title>Playing with the DOM</title>
    </head>
    <body>
        <h1 id="main-heading">Hello world!</h1>
        <script>

        var headingElement = document.getElementById("main-heading");

        console.log(headingElement.innerHTML);

        var newHeadingText = prompt("Please provide a new heading:");

        headingElement.innerHTML = newHeadingText;

        </script>
    </body>
</html>

// document.getElementById to get the h1 element (with the id of "main-heading" ) and save it into the variable headingElement .
// we print the string returned by headingElement.innerHTML , which prints Hello world! to the console.
// we set the innerHTML property of headingElement to the text saved in newHeadingText .


// Using jQuery to Work with the DOM Tree

// Loading jQuery on Your HTML Page

<script src="https://code.jquery.com/jquery-2.1.0.js"></script>

// Replacing the Heading Text Using jQuery

<script src="https://code.jquery.com/jquery-2.1.0.js"></script>
<script>
var newHeadingText = prompt("Please provide a new heading:");
$("#main-heading").text(newHeadingText);
</script>

// Creating New Elements with jQuery
$("body").append("<p>This is a new paragraph</p>");

for (var i = 0; i < 3; i++) {
    var hobby = prompt("Tell me one of your hobbies!");
    $("body").append("<p>" + hobby + "</p>");
}
Animating Elements with jQuery
$("h1").fadeOut(3000);
// To change the text of the h1 element and fade it out, you could enter:
$("h1").text("This will fade out").fadeOut(3000);
$("h1").fadeOut(3000).fadeIn(2000);
$("h1").slideUp(1000).slideDown(1000);




/***** Chapter 2 - Data Types and Variables ****/
/***** Chapter 2 - Data Types and Variables ****/
/***** Chapter 2 - Data Types and Variables ****/
/***** Chapter 2 - Data Types and Variables ****/


/* A smarter way to learn JS - Books





*/</html>