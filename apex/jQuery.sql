jQuery

How jQuery works with your Web page

At its most basic, a Web page contains a <script> tag that includes the jQuery library and a <script> block of JavaScript code that contains calls to functions from the jQuery library.

Using JavaScript code to call jQuery functions is a bit confusing at first, but don’t worry. The important point is to get a sense of how the code you used in this chapter works and what all the pieces mean. In this section, I take you through test.html line by line so it will be clearer:


? <!doctype...>: This long element tells the Web browser which version of HTML is used in the code that follows. You should always include it at the beginning of any HTML pages you create.
? <html>: This element begins the HTML page.
? <head>: This element designates the beginning of the head section. This section usually contains the title and any script element.
? <title>My Test Page</title>: This line displays the title of the page.
? <script src=”js/jquery-1.4.min.js”></script>: This line provides the location of the jQuery library.
? <script type=”text/java script”>: This script tag tells the browser that everything inside is JavaScript code.
? $(document).ready(function(){: The dollar sign is an alias for the jQuery function. The ready function waits for the Web page to load, and then the code contained inside it is executed.
? a l e r t ( j Q u e r y ( ‘ i m g ’ ) . attr(‘height’));: The alert function opens a pop-up alert box. The dollar sign that follows is calling the jQuery attr function. This function returns the value of whatever attribute is in quotes, in this case, the height. Notice that img precedes the attr function. In short, this function means, “look for all img elements you find in the HTML code, and return the value of the height attribute of the first one.”
? });: This punctuation is closing the braceand parenthesis started in the $(document).ready(function(){ line.
? </script>: This tag closes the <script> tag and ends the JavaScript code block.
? </head>: This tag closes the head section of the HTML.
? <body>: This tag begins the body section, where the main content consisting of HTML code, text, and images is written.
? <p>This is my test page.<p>: This line is a line of text that appears in the page.
? <img src= “images/home.gif” height=”28” width=”28” alt=”This is a test image.”>: This img element displays on the Web page an image with several attributes.
? </body>: This tag ends the content section of the page.
? </html>: This tag ends the HTML page.

You can use single or double quotes around elements and text in jQuery functions, but the best practices is to always use single quotes. Double quotes are best used in HTML code. For example, this is a jQuery function with single quotes:
alert($(‘img’).attr(‘width’));
and this is HTML code with double quotes: <img src= “images/home.gif” height=”28” width=”28” alt=”This is a test image.”>

jQuery allows you to interact with and manipulate elements on your Web pages. HTML elements make up HTML pages and are denoted by tags, which are letters or words in angle brackets, < and >. For example, <img> is an image element.


Common HTML elements
You may already be familiar with HTML. If not, here’s a closer look at a few of most common HTML elements you should know:
? <html></html>: Tells the Web browser that everything inside the tags should be considered a Web page.
? <head></head>: Contains information that controls how the page is displayed. Elements responsible for JavaScript and CSS code and calls to other files are generally placed between these tags.
? <title></title>: Contains the title of the Web page, displayed on the title bar at the top of the browser.
? <body></body>: Holds all the content of the page. 
? <style></style>: Controls the appearance and behavior of elements on your Web page.
? <script></script>: Makes JavaScript and other specified code available, either by calling a file or code placed between these tags. jQuery is included on the page with this tag.
? <strong></strong>: Boldfaces any text within the tag. 
? <h1></h1>: Creates header text.
? <div></div>: Creates a container of content.
? <p></p>: Creates a paragraph.
? <a></a>: Creates a hyperlink.
? <img />: Displays an image. Note that this tag doesn’t have a matching end tag, so a slash character is used inside the tag to denote the end of the tag.
? <form></form>: Creates a Web form that can send user-submitted information to another Web page or code that can process this information.
? <input></input>: Creates a form element, such as a radio button, text input box, or a Submit button. Used as a child element inside <form> </form>.
? <br />: Inserts a line break. No matching end tag is needed.
? <table></table>: Creates a table, along with child tags <tr></tr> and <td></td>.

Getting and Setting Element Values
<img src= “images/home.gif” height=”28” width=”28” alt=”Little house” />

img element has four attributes: src, height, width, alt. Values for these attributes are inside double quotes and aftre the equal sign.

var imageSource = $(‘img’).attr(‘src’);
The $ function tells the browser to use the jQuery function and specifies which element you are interested in. This code stores the value of the src attribute from an <img> element into the imageSource variable.

Variable names can contain only letters, numbers, $, and underscores; no spaces or other special characters are allowed.

Getting element content
Some HTML elements have text elements between their opening and closing tags that you can manipulate using jQuery. Consider this code: <p>This is some text.</p>
var pContent = $('p').text();
alert (pContent);

Setting element attribute values : 
    $(‘img’).attr({src: ‘images/cover2.jpg’, alt: ‘cover2’});
    var strongContent = $('strong').html();
    var pContent = $('p').html();

    $('strong').html(pContent);
    $('p').html(strongContent);
        
Removing element attribute values : 
    $(‘img’).removeAttr(‘height’);

Changing Text Content : (replace html by text)
        $('strong').text(pContent);
        $('p').text(strongContent);

Selecting all elements : You can select every element on a page by using the * character.
$(‘*’).attr({id: ‘myNewID’});
You shouldn’t use the * character with some jQuery functions. Consider this line of code: $(‘*’)text(‘Not a good idea.’);
When this line of code executes, it first replaces the outermost element’s text. Because the outermost parent element of any HTML page is the <html> element, you end up with this HTML code on your page: <html>Not a good idea.</html>

Selecting an id : 

Several rules govern id attributes. An id
? An id must be unique. You can use an id only once per HTML page.
? An id can contain only letters, numbers, hyphens, underscores, colons, and periods.
? An id must begin with a letter.
? An id is case-sensitive. The id you use in the HTML tag must match the one you use in your selector.
? An id is used in jQuery with a pound sign (#) in front of the id name. In my HTML code, for example, I use id = ‘myidname’. But when I use the id with a selector in the jQuery code, I place a pound sign in front of the id name, that is, ‘#myidname’.

<body>
<p id='someTxt'>Some text<p>
<p id='moreTxt'>More text<p>
</body>

alert ($('#moreTxt').text());

Selecting classes
Using ids to select specific elements gives you a lot of control over the elements on your page. But because ids are unique, you have to select each element by id. If you want to select four elements on your page, for example, you have to use all four ids in your code.

If you use a special attribute known as a class, you can select all elements with that attribute with a single line of code, such as: $(‘.someClass’).attr(‘src’) = ‘images/newImage.gif’;

? A class may be used by more than one element. You can use an id only once per HTML page.
? An element may contain more than one class. If you want to give an element multiple class attributes, use a space between class names. For example, here are three class attributes assigned to a single <p> element: <p attribute=”firstclass anotherclass dogclass catclass”>
? A class attribute is used in jQuery with a period (.) in front of the class name. In HTML code, for example, I use class = “myclass”. But when I use the class with a selector in the jQuery code, I place a period in front of the class name, that is, ‘.myclass’.


<body>
<strong class=”changemytext”>some name</strong>
<p class=”changemytext”>Some text<p>
<strong>another name</strong>
<p>More text<p>
<strong>another name</strong>
<p>Even more text<p>
<strong class=”changemytext”>your name</strong>
<p class=”changemytext”>Last bit of text<p>
</body>

$(‘.changemytext’).text(‘This is new text.’);

Selecting by order : If you have multiple elements of same type
? :first: Selects the first matching element. This code returns the value of the src attribute of the first <img>, which is images/cover1.jpg. $(‘img:first’).attr(‘src’);
? :last: Selects the last matching element. This code returns the value of the src attribute of the last <img>, which is images/cover2.jpg. $(‘img:last’).attr(‘src’);
? :even: Matches even elements, starting with 0. This code changes the text of the first and third <strong> elements. $(‘strong:even’).text(‘Changed this text.’);
? :odd: Matches odd elements, starting with 1. This code changes the text of the second and fourth <strong> elements. $(‘strong:odd’).text(‘Changed this text.’);
? :eq(index): Matches a specific element by counting from the first element to the index value. Suppose that you want to choose the third <strong> element on the page. Because the count starts with 0, to select the third <strong> element, do the following: $(‘strong:eq(2)’).text(‘Changed this text.’);
? :gt(index): Selects all elements with an index value greater than the index. Selected elements are elements below the selected element on the page.
? :lt(index): Selects all elements with an index value less than the index. Selected elements are above the selected element on the page. 

Selecting from Forms :

? :input: Selects all form elements including <input />, <select>, <textarea>, and <button>. This code shows the number of input elements in my form in an alert box:
alert( $(':input').length);

When a selector selects more than one element, the result is a list of values known as an array. When I select all the inputs on my page, I get back an array of all the elements. The length keyword tells me how many elements are in my array.

? :text: Selects all elements with the type attribute set to text. The following code returns the count text boxes in an alert box: alert( $(‘:text’).length);
? :radio: Selects all elements with the type attribute set to radio. alert( $(‘:radio’).length);
? :checkbox: Selects all elements with type attribute set to radio. $(‘:checkbox’).attr({checked:’true’});
? :checked: Selects all check boxes and radio buttons that are checked.

Selecting Attributes :
Page 48

Chapter - 4 : Managing Events
////////// Double Click Event
$('.clickme').dblclick(function() 
{
    alert("You double clicked on Click Me.");
}
);
////////// Click Event
$('.clickme').click(function() 
{
    alert("You clicked on Click Me.");
}
);
////////// Focus event
$('#textboxyourname').focus(function() {
alert("textboxyourname has focus");
});
///////// Detecting a keyboard event, below example triggered only when pressed during input type item selecetd
$('input').keypress(function (e) {
if (e.which == 97) alert ("a was typed.");
});
///////// Detecting a mouse event
/*
$('#mouseoverme').mouseover(function() {
$('#outputdiv').text('You mousedover the image.'); 
});

$('#mouseoverme').mouseout(function() {
$('#outputdiv').text('You mousedout of the image.'); });

    }
);
*/
$('#mouseoverme').hover(
function() {$('#outputdiv').text('You moused over the image.');},
function() {$('#outputdiv').text('You moused out of the image.');}
);


Chapter 5 Playing Hide-and-Seek with Web Page Elements

Hiding an element by type with a button

$(':submit').click(function () {
$('div').hide();
});
