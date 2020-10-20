// https://docs.oracle.com/en/database/oracle/application-express/19.1/aexjs/apex.html

// This example refreshes the region with static id emp when any modal dialog page closes.
apex.gPageContext$.on("apexafterclosedialog", function (event, data) {
    apex.region("emp").refresh();
});

// This example disables the button with static id B1 while any refresh is in progress.
apex.jQuery("body").on("apexbeforerefresh", function () {
    apex.jQuery("#B1").prop("disabled", true);
}).on("apexafterrefresh", function () {
    apex.jQuery("#B1").prop("disabled", false);
});

// This example makes the page item P1_VALUE upper case before the page is submitted.
apex.jQuery(apex.gPageContext$).on("apexpagesubmit", function () {
    var item = apex.item("P1_VALUE");
    item.setValue(item.getValue().toUpperCase());
});

// Hides the page-level success message.
apex.message.hidePageSuccess();


// Displays a page-level success message ‘Changes saved!’.
apex.message.showPageSuccess("Changes saved!");

// This example demonstrates an Ajax call to an on-demand process called MY_PROCESS and sets the scalar value x01 to test (which can be accessed from PL/SQL using apex_application.g_x01) and sets the page item's P1_DEPTNO and P1_EMPNO values in session state (using jQuery selector syntax). The success callback is stubbed out so that developers can add their own code that fires when the call successfully returns. The data parameter to the success callback contains the response returned from on-demand process.
apex.server.process("MY_PROCESS", {
    x01: "test",
    pageItems: "#P1_DEPTNO,#P1_EMPNO"
}, {
    success: function (data) {
        // do something here
    },
    error: function (jqXHR, textStatus, errorThrown) {
        // handle error
    }
});

// The following code checks if the Oracle Application Express item P1_OPTIONAL_ITEM exists before setting its value. Use code similar to this if there is a possibility of the item not existing.
var item = apex.item( "P1_OPTIONAL_ITEM" );
if ( item.node ) {
    item.setValue( newValue );
}

// In this example, the page item named P1_ITEM will be disabled and unavailable for editing.
apex.item( "P1_ITEM" ).disable();

// In this example, the page item called P1_ITEM will be enabled and available for edit.
apex.item( "P1_ITEM" ).enable();

// In this example, the current value of the page item called P1_ITEM will be shown in an alert.
apex.message.alert( "P1_ITEM value = " + apex.item( "P1_ITEM" ).getValue() );

// This example gets the value of an item, but only if it is not disabled.
var value = null;
if ( !apex.item( "P1_ITEM" ).isDisabled() ) {
    value = apex.item( "P1_ITEM" ).getValue();
}

// The following example will cause the P1_ITEM select list page item to fetch its options from the server.
apex.item( "P1_ITEM" ).refresh();

// In this example, the page item called P1_ITEM will have the value 100 removed from the current list of values.
apex.item( "P1_ITEM" ).removeValue( "100" );

// In this example, user focus is set to the page item named P1_ITEM.
apex.item( "P1_ITEM" ).setFocus();

// In this example, the value of the page item called P1_ITEM will be set to 10. As pSuppressChangeEvent has not been passed, the default behavior of the change event triggering for P1_ITEM will occur.
apex.item( "P1_ITEM" ).setValue( "10" );


// The following example will focus the region with Static ID "myRegion".
var region = apex.region( "myRegion" );
region.focus();

