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
The setup ( var sheepCounted = 0 ) is run before the loop starts.
The condition ( sheepCounted < 10 ) is checked before each run of the loop body.
The increment ( sheepCounted++ ) is run after every execution of the loop body.


var timesToSayHello = 3;
for (var i = 0; i < timesToSayHello; i++) {
    console.log("Hello :"+i);
}// 0 1 2

var timesToSayHello = 3;
for (var i = 0; i < timesToSayHello; ++i) {
    console.log("Hello :"+i);
}// 0 1 2

var timesToSayHello = 3;
for (var i = 0;  ++i; i < timesToSayHello;) {
    console.log("Hello :"+i);
}// 0 1 2

/***** Chapter 2 - Data Types and Variables ****/
/***** Chapter 2 - Data Types and Variables ****/
/***** Chapter 2 - Data Types and Variables ****/
/***** Chapter 2 - Data Types and Variables ****/
/***** Chapter 2 - Data Types and Variables ****/
/***** Chapter 2 - Data Types and Variables ****/