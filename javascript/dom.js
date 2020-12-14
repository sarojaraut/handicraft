
// Dom properties
document.body 
document.title 
document.URL
// DOM Methods
document.getElementById("some-ID");
document.getElementsByClassName("classame");
document.getElementByTagname("htmlTag");
// These methods are fine but often too clunky to work with specially if you are looking for node inside a node 
document.querySelector(".main-nav a");//get the first element matching the specified selector
document.querySelectorAll(".post-content p");//get all elements matching the specified selector, one or more selectors

document.querySelector("h1.clamp-1").innerHTML
document.querySelector("h1.clamp-1").outerHTML

document.querySelector("h1.clamp-1").innerHTML = "Test"
document.querySelector("h1.clamp-1").className 
document.querySelector("h1.clamp-1").classList

// Adding new DOM Element
// create the Element : .createElement
// create the text node that goes inside it : .CreateTextNode
// add the text node to the element 
// add the element to : .appendChild

document.querySelector("h1.clamp-1").style.color = "blue"

document.querySelector("h1.clamp-1").style.cssText= ""
document.querySelector("h1.clamp-1").setAttribute

// Browser level events : load, Error, Online OfflineAudioCompletionEvent, resize, scroll. 
// Dom level events : focus(clicked tabbed), blur(leaving from field), reset/submit, mouse event

// e.preventDefault() : if the button has link to # and prevent on click the page scrolls to top


