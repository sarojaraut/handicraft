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

let king = {
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
// alert(king); // without the toPrimitive function this would displayed cryptic object representation

let anotherUser = {
    empno: 7879,
    sal: 5000
}

console.log(king === anotherUser);
console.log(king.equals(anotherUser));


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

// sample code for updating database record
// we will create a new object and add functions to that for various operations
// this way we will not polute the global namespace
// use alias for apex.server and apex.message , this is for dependency injection, if later we want to use similar compatible utility then most of our code remains the same and also useful for testing.

var ourjs = {};

ourjs.empUtil = {};
(function (empUtil, message, server) {
    "use strict"
    // the wrapper showSuccess is needed just to in case we want to modify how the message is displayed
    // so later instead of hunt down the code and finding all places where message.showPageSuccess is used 
    // and chnage those we just need to make the changes in one place
    empUtil.showSuccess = function (successMessage) {
        message.showPageSuccess(successMessage);
    }

    empUtil.showError = function (errorMessage) {
        message.clearErrors();
        message.showErrors([{
            type: "error",
            location: ["page"],
            message: errorMessage,
            unsafe: false
        }]);
    }
    empUtil.giveRise = function (empno, amount) {
        return server.process('GIVE_RISE', {
            X01: empno,
            X02: amount
        });
    }
})(sb.empUtil, apex.message, apex.server)

//IEFE : Immediately invoked function expression : variables declared inside this can be never be accessed outside
// add all the code in function and global variable declaration of apex page

// now we need to create a plsql page process
/*
declare
    l_empno            number;
    l_amount           number;
begin
    l_empno := :APP_AJAX_X01;
    l_amount:= :APP_AJAX_X02;
    update emp
    set sal = sal+ l_amount
    where empno = l_empno;
    apex_json.create_object;
    apex_json.write('success', true);
    apex_json.write('message', 'Emp Updated');
    apex_json.close_all;

exception
    apex_json.create_object;
    apex_json.write('success', false);
    apex_json.write('message', 'Error during Emp Update');
    apex_json.write('devMessage', sqlerrm);
    apex_json.close_all;

end;
*/
// dynamic action on butto click
ourjs.empUtil.giveRise(
    $v('P2_EMPNO'),
    $v('P2_AMOUNT')
).then(function (response) {
    if (response.success) {
        ourjs.empUtil.showSuccess(response.message);
    } else {
        ourjs.empUtil.showError(response.message);
    }
});

// Module pattern
// this way we just need to include one js file e.g main js
// and main.js in turn has import {method} from './method.js'; and it can go on like spider web

// AJAX calls using apex.server.process

apex.server.process('AJAX_PROCESS_NAME_CASE_SENSITIVE',
    {
        x01 : "test",
        f01 : jsarray,
        pageItems : "#P1_NAME","#P1_SAL"
        // you can use any of the x01-x20, f01-f50 or pageItems if it's a page level process
        // you can check how these variables can be access in your plsql block in package apex_application
    },
    {
        loadingIndicator : "#P1_COMM,#P1_OTHER"
        success : function(data){
            //do success action
            $s("P1_COMM", data.comm);
        },
        error : function(data){
            //do error action
        }
    })

// you can use apex_util.pause to inject slowness in your plsql code. 
// AJAX process would be a plsql block using the page items passed or gx01 of gf0x variablles compute the output
//apex_application.g_f01 or g_x01 etc
// return the data in json object using apex_json under the hood  apex_json write to the http buffer you can achieve similar effect using htp.p as well
// if you are not returning json then your ajsx response handling section you need to specify that dataType : "text" default is json
//style="display:none" to hide one item when page loads
//$("#COMM").show(200) or hide() the number 200 will just create a slide effect while showing

// setTimeout( function(){$wp = apex.widget.waitPopup();},1} and remove the $wp in the .always section
//referring documents : apex.oracle.com/api and apex.oracle.com/jsapi

// $s sets an item value, $v retrieves it and $x determines whether an item with the given name exists on the current page.
apex.item >
    getValue()
    setValue()
    isChanged()
    displayValueFor()
    hide()
    show()
    enable()
    disable()
    setStyle({"background-color":"yellow", "font-weight":"bold"})


$v( "P1_ENAME" )
apex.item( "P1_ENAME" ).getValue()

$s( "P1_ENAME", "SAROJ")
apex.item( "P1_ENAME" ).setValue("SAROJ")

apex.item( "P1_DEPTNO" ).getValue()
apex.item( "P1_DEPTNO" ).displayValueFor("2")
apex.item( "P1_DEPTNO" ).displayValueFor(apex.item( "P1_DEPTNO" ).getValue())
$s( "P1_DEPTNO", "5")
$v( "P1_DEPTNO" )
apex.item( "P1_DEPTNO" ).hide()
apex.item( "P1_DEPTNO" ).show()
apex.item( "P1_DEPTNO" ).disable()
$("#P1_DEPTNO" ).show()
$("#P1_DEPTNO" ).hide()
$( "#P1_DEPTNO" ).prop( "disabled", true );
$( "#P1_DEPTNO" ).prop( "disabled", false );
$( "#P1_DEPTNO" ).prop( "display", "inline" );
$("#P1_ENAME" ).show()
apex.item( "P1_DEPTNO" ).setStyle({"background-color":"yellow", "font-weight":"bold"})
// to hide item when page loads : style="display=none" but this seems adding attribute at the outer most div
// alternate option is add the java script to execute when page loads apex.item( "P1_DEPTNO" ).hide()
// to supress da being fired on value change : apex.item( "P1_DEPTNO" ).setValue(4,null,true)