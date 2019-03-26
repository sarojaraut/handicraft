CREATE OR REPLACE PACKAGE tst_ords_demoapi_all_envs 
AS
    -- %suite(ri.ords.it.hso)
    -- %beforeall
    PROCEDURE global_setup;

    -- %test(CMSDEV Server Availability Check)
    -- %disabled
    PROCEDURE cmsdev_server_listening;
    -- %test(CMSDEV REST End Point Availability Check)
    -- %disabled
    PROCEDURE cmsdev_end_url_available;
    -- %test(CMSDEV Target DB Environment Correctness Check)
    -- %disabled
    PROCEDURE cmsdev_check_db_env;
    -- %test(CMSDEV APP Module Correctness Check)
    -- %disabled
    PROCEDURE cmsdev_check_module;
    -- %test(CMSDEV Session Correctness Check)
    -- %disabled
    PROCEDURE cmsdev_valid_session;

    -- %test(CMSTST Server Availability Check)
    -- %disabled
    PROCEDURE cmstst_server_listening;
    -- %test(CMSTST REST End Point Availability Check)
    -- %disabled
    PROCEDURE cmstst_end_url_available;
    -- %test(CMSTST Target DB Environment Correctness Check)
    -- %disabled
    PROCEDURE cmstst_check_db_env;
    -- %test(CMSTST APP Module Correctness Check)
    -- %disabled
    PROCEDURE cmstst_check_module;
    -- %test(CMSTST Session Correctness Check)
    -- %disabled
    PROCEDURE cmstst_valid_session;

    -- %test(CMSTS2 Server Availability Check)
    PROCEDURE cmsts2_server_listening;
    -- %test(CMSTS2 REST End Point Availability Check)
    PROCEDURE cmsts2_end_url_available;
    -- %test(CMSTS2 Target DB Environment Correctness Check)
    PROCEDURE cmsts2_check_db_env;
    -- %test(CMSTS2 APP Module Correctness Check)
    PROCEDURE cmsts2_check_module;
    -- %test(CMSTS2 Session Correctness Check)
    PROCEDURE cmsts2_valid_session;


    -- %test(CMSTS3 Server Availability Check)
    PROCEDURE cmsts3_server_listening;
    -- %test(CMSTS3 REST End Point Availability Check)
    PROCEDURE cmsts3_end_url_available;
    -- %test(CMSTS3 Target DB Environment Correctness Check)
    PROCEDURE cmsts3_check_db_env;
    -- %test(CMSTS3 APP Module Correctness Check)
    PROCEDURE cmsts3_check_module;
    -- %test(CMSTS3 Session Correctness Check)
    PROCEDURE cmsts3_valid_session;


    -- %test(CMSTS4 Server Availability Check)
    PROCEDURE cmsts4_server_listening;
    -- %test(CMSTS4 REST End Point Availability Check)
    PROCEDURE cmsts4_end_url_available;
    -- %test(CMSTS4 Target DB Environment Correctness Check)
    PROCEDURE cmsts4_check_db_env;
    -- %test(CMSTS4 APP Module Correctness Check)
    PROCEDURE cmsts4_check_module;
    -- %test(CMSTS4 Session Correctness Check)
    PROCEDURE cmsts4_valid_session;

    -- %test(CMSSP1 Server Availability Check)
    PROCEDURE cmssp1_server_listening;
    -- %test(CMSSP1 REST End Point Availability Check)
    PROCEDURE cmssp1_end_url_available;
    -- %test(CMSSP1 Target DB Environment Correctness Check)
    PROCEDURE cmssp1_check_db_env;
    -- %test(CMSSP1 APP Module Correctness Check)
    PROCEDURE cmssp1_check_module;
    -- %test(CMSSP1 Session Correctness Check)
    PROCEDURE cmssp1_valid_session;

    -- %afterall
    PROCEDURE global_cleanup;
    
    -- Supporting procedures
    PROCEDURE init_global_collection(i_end_url in varchar2);

    --Global Variables
    G_clob              CLOB;
    G_db_name           VARCHAR2(100);
    G_module            VARCHAR2(100);
    G_current_user      VARCHAR2(100);
    G_sessionid         VARCHAR2(100);
    G_host              VARCHAR2(100);
    G_rest_end_url      VARCHAR2(32767) 
        := 'http://ords-alb.dev.transit.ri-tech.io/ords/cmsts3/cms/demo-api/dbdetails/';
    l_item_count        NUMBER;
    
    G_dev_url_base           VARCHAR2(100) := 'http://ords-alb.dev.transit.ri-tech.io/ords/';
    G_stg_url_base           VARCHAR2(100) := 'http://ords-alb.dev.transit.ri-tech.io/ords/';
    G_prd_url_base           VARCHAR2(100) := 'http://ords-alb.dev.transit.ri-tech.io/ords/';
    
    G_ords_url_cmsdev   VARCHAR2(100) := G_dev_url_base||'cmsdev/cms/demo-api/dbdetails/';
    G_ords_url_cmstst   VARCHAR2(100) := G_dev_url_base||'cmstst/cms/demo-api/dbdetails/';
    G_ords_url_cmsts2   VARCHAR2(100) := G_dev_url_base||'cmsts2/cms/demo-api/dbdetails/';
    G_ords_url_cmsts3   VARCHAR2(100) := G_dev_url_base||'cmsts3/cms/demo-api/dbdetails/';
    G_ords_url_cmsts4   VARCHAR2(100) := G_dev_url_base||'cmsts4/cms/demo-api/dbdetails/';
    G_ords_url_cmssp1   VARCHAR2(100) := G_dev_url_base||'cmssp1/cms/demo-api/dbdetails/';
    
    G_ords_url_omsdev   VARCHAR2(100) := G_dev_url_base||'omsdev/orderactive/demo-api/dbdetails/';
    G_ords_url_omstst   VARCHAR2(100) := G_dev_url_base||'omstst/orderactive/demo-api/dbdetails/';
    G_ords_url_omsts2   VARCHAR2(100) := G_dev_url_base||'omsts2/orderactive/demo-api/dbdetails/';
    G_ords_url_omsts3   VARCHAR2(100) := G_dev_url_base||'omsts3/orderactive/demo-api/dbdetails/';
    G_ords_url_omsts4   VARCHAR2(100) := G_dev_url_base||'omsts4/orderactive/demo-api/dbdetails/';
    G_ords_url_omssp1   VARCHAR2(100) := G_dev_url_base||'omssp1/orderactive/demo-api/dbdetails/';
    
    G_ords_url_wmsdev   VARCHAR2(100) := G_dev_url_base||'wmsdev/rwm/demo-api/dbdetails/';
    G_ords_url_wmstst   VARCHAR2(100) := G_dev_url_base||'wmstst/rwm/demo-api/dbdetails/';
    G_ords_url_wmsts2   VARCHAR2(100) := G_dev_url_base||'wmsts2/rwm/demo-api/dbdetails/';
    G_ords_url_wmsts3   VARCHAR2(100) := G_dev_url_base||'wmsts3/rwm/demo-api/dbdetails/';
    G_ords_url_wmsts4   VARCHAR2(100) := G_dev_url_base||'wmsts4/rwm/demo-api/dbdetails/';
    G_ords_url_wmssp1   VARCHAR2(100) := G_dev_url_base||'wmssp1/rwm/demo-api/dbdetails/';

    -- Collections
    TYPE db_details_rec IS RECORD ( 
        db_name           VARCHAR2(100),
        module            VARCHAR2(100),
        current_user      VARCHAR2(100),
        sessionid         VARCHAR2(100),
        host              VARCHAR2(100),
        rest_end_url      VARCHAR2(500),
        response_json     CLOB
    );
    
    TYPE db_details_tab IS TABLE OF db_details_rec index by varchar2(30);
    G_rec_tab           db_details_tab;     

END tst_ords_demoapi_all_envs;
/

/*
%disabled

ansicon.exe -i

 set serveroutput on;
 begin
 dbms_output.put_line(tst_ords_demoapi_all_envs.G_ords_url_cmsts2);
 end;
 /

 set serveroutput on;
 begin
     tst_ords_demoapi_all_envs.init_global_collection(tst_ords_demoapi_all_envs.G_ords_url_cmsts2);
     tst_ords_demoapi_all_envs.init_global_collection(tst_ords_demoapi_all_envs.G_ords_url_cmsts3);
     tst_ords_demoapi_all_envs.init_global_collection(tst_ords_demoapi_all_envs.G_ords_url_cmsts4);
     dbms_output.put_line(tst_ords_demoapi_all_envs.G_rec_tab('cmsts2').db_name);
     dbms_output.put_line(tst_ords_demoapi_all_envs.G_rec_tab('cmsts3').db_name);
     dbms_output.put_line(tst_ords_demoapi_all_envs.G_rec_tab('cmsts4').db_name);
 end;
 /
 
 exec ut.run(a_color_console=>true);

exec ut.run(ut_documentation_reporter(), a_color_console=>true);
 
set serveroutput on;
exec ut_documentation_reporter.set_color_enabled(true);
begin ut.run('tst_ords_demoapi_all_envs',ut_documentation_reporter(), a_color_console=>true); end;
/

select * from table(ut.run('tst_ords_demoapi_all_envs', ut_xunit_reporter()));

alter session set current_schema=itsr;
begin
  ut.run();
end;
/

Executes all tests in current schema (ITSR).

begin
  ut.run('itsr:com.my_org.my_project');
end;

Executes all tests from all packages that are on the com.my_org.my_project suitepath.

/

*/


begin
  ut.run('ri.ords.it.hso');
end;
