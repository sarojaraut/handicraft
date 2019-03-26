CREATE OR REPLACE PACKAGE tst_ords_demoapi 
AS

    -- %suite(ORDS Demo Rest End Point)

    -- %beforeall
    PROCEDURE global_setup;

    -- %test(... Server Availability Check)
    PROCEDURE server_listening;

    -- %test(... REST End Point Availability Check)
    PROCEDURE end_url_available;

    -- %test(... Target DB Environment Correctness Check)
    PROCEDURE check_db_env;

    -- %test(... HOST name Correctness Check)
    PROCEDURE valid_host;

    -- %test(... APP Module Correctness Check)
    PROCEDURE check_module;

    -- %test(... Session Correctness Check)
    PROCEDURE valid_session;

    -- %afterall
    PROCEDURE global_cleanup;

    --Global Variables
    G_clob              CLOB;
    G_db_name           VARCHAR2(100);
    G_module            VARCHAR2(100);
    G_current_user      VARCHAR2(100);
    G_sessionid         VARCHAR2(100);
    G_host              VARCHAR2(100);
    G_rest_end_url      VARCHAR2(32767) 
        := 'http://wwisdlap002.hq.river-island.com/ords/cmsdev/itsr/demo-api/dbdetails';
    l_item_count        NUMBER;

END tst_ords_demoapi;
/

/*

set serveroutput on;
begin ut.run('tst_ords_demoapi'); end;
/

*/


