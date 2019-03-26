// global variables
var errorClass = "valError";

// bind validations on page load
$(function() {

  $('[required]').blur(function(event) {
    if (isEmpty(this.value)) {
      showErrorField(this, "required field");
      event.stopImmediatePropagation();
    } else {
      hideErrorField(this);
    }
  });

  $('input.number_field').blur(function(event) {
    if (!isEmpty(this.value) && isNaN(this.value)) {
      showErrorField(this, "not a numeric value");
      event.stopImmediatePropagation();
    } else {
      hideErrorField(this);
    }
  });

  $('input.valPositiveInteger').blur(function(event) {
    if (!isEmpty(this.value) && !isPositiveInteger(this.value)) {
      showErrorField(this, "not a positive integer value");
      event.stopImmediatePropagation();
    } else {
      hideErrorField(this);
    }
  });

  $('input.datepicker').blur(function(event) {
    if (!isEmpty(this.value) && !isValidDate(this.value)) {
      showErrorField(this, "Invalid date (DD/MM/YYYY)");
      event.stopImmediatePropagation();
    } else {
      hideErrorField(this);
    }
  });
  
    $('input.masked_text_field').blur(function(event) {
    if (!isEmpty(this.value.replace(/_|:/g,'')) && !isValidTime(this.value)) {
      showErrorField(this, "Invalid time");
    } else {
      hideErrorField(this);
    }
  });
  

});

// error message manipulation
function showErrorField(pInputElement, pMessage) {
  var inputElement = $(pInputElement);

  if (!inputElement.hasClass(errorClass)) {
    inputElement.addClass(errorClass);
    inputElement.after("<span class=\"" + errorClass + "\">" + pMessage + "</span>");
  } else {
    inputElement.next().text(pMessage);
  }
}

function hideErrorField(pInputElement) {
  var inputElement = $(pInputElement);

  if (inputElement.hasClass(errorClass)) {
    inputElement.removeClass(errorClass);
    inputElement.next().remove();
  }
}

// before form submit
function formHasErrors(pForm) {
  var errorsExist = false;
  var formElement = $(pForm);

  formElement.find('input, textarea, select').trigger('blur');

  if (formElement.find('.' + errorClass).length > 0) {
    errorsExist = true;
  }

  return errorsExist;
}

function validateFormBeforeSubmit(pForm, pFiringElement) {
  var firingElement = $(pFiringElement);
  var originalOnclickEvent = firingElement.attr('onclick');

  firingElement.data('origOnclickEvent', originalOnclickEvent);
  firingElement.removeAttr('onclick');

  firingElement.on('click', function() {
    if (!formHasErrors(pForm)) {
      eval(firingElement.data('origOnclickEvent'));
    } else {
      alert("Please fix all errors before continuing");
    }
  });
}

// single value validations
function isEmpty(pValue) {
  var isEmpty = false;

  if ($.trim(pValue) === "") {
    isEmpty = true;
  }

  return isEmpty;
}

function isPositiveInteger(pValue) {
  // an integer is a number that can be written without a fractional or decimal component
  var isPositiveInteger = false;
  var positiveIntegerRegex = /^\d+$/;

  if (pValue.match(positiveIntegerRegex)) {
    isPositiveInteger = true;
  }

  return isPositiveInteger;
}

function isValidDate(pValue) {
  var isValidDate = false;
  // date format is DD/MM/YYYY
  var dateFormatRegex = new RegExp("^(3[01]|[12][0-9]|0?[1-9])/(1[0-2]|0?[1-9])/(?:[0-9]{2})?[0-9]{2}$");

  if (pValue.match(dateFormatRegex)) {
    // seems that the date format is correct, but can we parse the date to a date object?
    var dateArray = pValue.split("/");
    var year = parseInt(dateArray[2]);
    var month = parseInt(dateArray[1], 10);
    var day = parseInt(dateArray[0], 10);
    var date = new Date(year, month - 1, day);

    if (((date.getMonth() + 1) === month) && (date.getDate() === day) && (date.getFullYear() === year)) {
      isValidDate = true;
    }
  }

  return isValidDate;
}

function isValidEmailAddress(pValue) {
  // source : http://stackoverflow.com/questions/7786058/find-the-regex-used-by-html5-forms-for-validation
  var isValidEmailAddress = false;
  var emailAddressRegex = /^[A-Za-z0-9!#$%&'*+-/=?^_`{|}~]+@[A-Za-z0-9-]+(.[A-Za-z0-9-]+)*$/;

  if (pValue.match(emailAddressRegex)) {
    isValidEmailAddress = true;
  }

  return isValidEmailAddress;
}

function containsWhitespace(pValue) {
  var trimmedLength = pValue.replace(/ /g, '').length;
  var containsWhitespace = false;

  if (pValue.length !== trimmedLength) {
    containsWhitespace = true;
  }

  return containsWhitespace;
}

function containsWhitespaceInString(pValue) {
  var originalLength = pValue.trim().length;
  var trimmedLength = pValue.replace(/ /g, '').length;
  var containsWhitespace = false;

  if (originalLength !== trimmedLength) {
    containsWhitespace = true;
  }

  return containsWhitespace;
}
//
// My addition
//
function isValidTime(pValue) {
  var isValidTime = false;
  // Time format is hh24:mi
  var timeFormatRegex = new RegExp("^([01]?[0-9]|2[0-3]):([0-5]?[0-9])?$");
 
  if (pValue.match(timeFormatRegex)) {
    isValidTime = true;
    //alert("Matched");
  }
  //alert("Match check done");
 
  return isValidTime;
}