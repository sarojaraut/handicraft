// vs code extension quokka .js to run js in local machine
//object


var o = {
    "doSomething": function () { }
};

// you can skip the quotes
var o = {
    doSomething: function () { }
};

// you can skip the colon and function keyword
var o = {
    doSomething() { }
};


// https://skillbuilders.com/course/discovering-javascript-part-2/lessons/lesson-2-how-can-objects-be-used-in-applications/

king = {
    empno: 7879,
    sal: 5000,
    [Symbol.toPrimitive](hint) {
        console.log(hint);
        return hint == "string" ? `empno is ${this.empno}` : this.sal;
    },
    equals(employee) {
        return this.empno === employee.empno
    }
};

console.log(king + 100);
alert(king);

// How to Register a Listner

// Jquery : $('#P2_NAME').on('change',function(event){console.log('Name changed');})
// Vanila JS :  
// var myItem = document.getElementById('P2_NAME');
// myItem.addEventListner('change',function(event){console.log('Name changed');})

// Where to add your js code 
// File URL : external file 
// Function and global veriable declaration
// Executes when page loads

// If in your js code you are using one page item like above then use execure when page loads

// Event bubbling 

const allElements = document.querySelectAll('*');
for (const element of allElements) {
    element.addEventListner('click', function (event) { console.log(this); })
}

// you can run this script in the console section of any apex page and then click and see the html section it should show at least one element for each element.
// once you click on any element see the console log and observe how the event bubbles up and ends with html element

// target and currentTarget


// Event Delegation

// creating a button in a report with specific action

// use apex.oracle.com/ut reference button builder and copy the html markup. then add a custom attribute data-empno='#EMPNO#' and add a class only specific for java script js-btn-raise

// dynamic action 
// name = give raise btn clicked (good practice to name DA based on what's being selected and the event not necessarily what's going to happen when clicked)
// when selected type = jqueryselector and jqueryselector = .js-btn-raise  the custom class we added in the html markup

// change event scope to dynamic else only one click will work after refresh.


// debouncing events :
// when there is a liklyhood of flood of events and you want to supress so the server is not overwhelmed

var searchItem = document.getElementById('P2_SEARCH');
function handleSearch(event) {
    apex.region('employeeReport').refresh();
}
searchItem.addEventListner('keyup', apex.util.debounce(handleSearch, 200)); //supress all keyup events within 200 mili seconds

//keydown may give weird result     

// usually I start with DA and if too many DA then I tend to normalise the code and build my own js code for that page
// multiple items hide and show : apex.item('P2_NAME')'.hide(); apex.item('P2_NAME')'.show(); instead of $('#P2_NAME')'.hide(); because apex item handles complx items like shuttle and list etc
// you can add condition if $v('P2_NAME') === 'some val'
//$('td').closet('thead') instead of parent.parent etc