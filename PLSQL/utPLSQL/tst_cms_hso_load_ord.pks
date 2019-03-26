CREATE OR REPLACE PACKAGE tst_cms_hso_load_ord
IS
    -- %suite(ORDS Demo Rest End Point)

    -- %beforeall
    PROCEDURE global_setup;

    -- %test(Previous error record(s) retry check)
    PROCEDURE error_record_retry;

    -- %test(Successful XML generation check)
    PROCEDURE valid_xml_generation;
    
    -- %test(Un-successful XML generation check)
    PROCEDURE invalid_xml_generation;

    -- %test(Successful TCPL WEB service invocation check)
    PROCEDURE valid_tcpl_web_call;
    
    -- %test(Un-successful TCPL WEB service invocation check)
    PROCEDURE invalid_tcpl_web_call;

    -- %test(Failed order email Check)
    PROCEDURE failed_order_email;
    
    -- %test(Success order no-email Check)
    PROCEDURE success_order_no_email;

    -- %test(Correct Sequence Update)
    PROCEDURE correct_sequence_update;
    
    -- %test(No memory leak)
    PROCEDURE memory_leak_check;

    -- %afterall
    PROCEDURE global_cleanup;

END;
/

/*

min key and max key
Mark records in error tables to be processed
Open cursor and process ne by one
Failed to generate XML
TCPL service call failure
Email Failed Orders
Update the Sequence Key Values
No memory leak(Temp CLOB)
No Boundary Condition Failures
Delete the dummy orders

*/


