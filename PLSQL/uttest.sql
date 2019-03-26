create or replace package test_cms_payment_notification as

  -- %suite(CMS Payment Notification)

  -- %test(Success status)
  --%beforetest(post_json_via_rest)
  procedure success_status;

  -- %test(Unauthorised status)
  procedure unauth_status;

  -- %test(Transaction count)
  procedure pmt_transaction_count;

  -- %test(Payment event existance)
  procedure pmt_event_exists;

  -- %test(Invalid JSON)
  procedure invalid_json;

  PROCEDURE post_json_via_rest(
        I_token    varchar2 default NULL
    );

end;
/

create or replace package body test_cms_payment_notification as
    C_scope_prefix    CONSTANT    s_datatype.unit_name  := LOWER($$plsql_unit) || '.';
    g_oauth_url          varchar2(1000) := 'http://ords-alb.dev.transit.ri-tech.io/ords/cmsdev/api/oauth/token';
    g_end_url            varchar2(1000) := 'http://ords-alb.dev.transit.ri-tech.io/ords/cmsdev/api/ordermanagement/v1/paymentnotifications';
    g_token_valid_upto   timestamp;
    g_oauth_token        varchar2(1000);
    g_client_id          varchar2(1000) := 'HW_6ZhR3U49he-iRxPUVqQ..';
    g_wrong_client_id    varchar2(1000) := 'HW_6ZhR3U49he-iRxPUVqQ..';
    g_client_secret      varchar2(1000) := 'LhA7xjx8tRtTwdAcn7rCUg..';
    G_start_ordernumber  number     := 900000000;
    G_status_code        number;

    procedure success_status is
    begin
        ut.expect( G_status_code ).to_equal( 200 );
    end;

    procedure unauth_status is
    begin
        null;
    end;

    procedure pmt_transaction_count is
    begin
        null;
    end;

    procedure pmt_event_exists is
    begin
        null;
    end;

    procedure invalid_json is
    begin
        null;
    end;

--
-- Helper Function Section
--
    FUNCTION generate_notif_json(
        i_invalid   IN varchar2 default 'F'
    )
    RETURN VARCHAR2
    IS
        l_json   VARCHAR2(32767);
        L_scope  VARCHAR2(100) := C_scope_prefix||'generate_notif_json';
    BEGIN
        l_json :=
q'[
{
    "amount": 6799,
    "id": "f2a45815-ce1e-4cde-8ec3-00a5822a4a8f",
    "order": {
        "externalIds": [
            {
                "externalId": "1925132139",
                "systemId": "TCPL"
            }
        ],
        "orderId": "c7b1f0de-2bc0-42c2-b745-690f353878b2",
        "payments": [
            {
                "amount": 20,
                "paymentId": "331ddf3d-8208-403c-99ad-1c96d39838cf",
                "paymentProvider": "GA",
                "paymentReference": "20180925132142670",
                "prepaid": true,
                "transactionPaymentTotal": {},
                "transactions": [
                    {
                        "amount": 20,
                        "code": "200",
                        "dateTime": "2018-09-26T09:29:44.654Z",
                        "id": "f2a45815-ce1e-4cde-8ec3-00a5822a4a8f",
                        "message": "capture-giftcard",
                        "reference": "CAPTURE-1537954184654145500",
                        "status": "COMPLETE",
                        "type": "CAPTURE"
                    }
                ]
            },
            {
                "amount": 3400,
                "paymentId": "739752ab-0792-4964-acd8-77d6eba4e894",
                "paymentProvider": "AC",
                "paymentReference": "20180925132142123",
                "type": "VISA CARD",
                "transactionPaymentTotal": {},
                "transactions": [
                    {
                        "amount": 3400,
                        "code": "167",
                        "dateTime": "2018-09-26T09:29:56.195Z",
                        "id": "f2a45815-ce1e-4cde-8ec3-00a5822a4a8f",
                        "message": "Original pspReference required for this operation",
                        "reference": "ERROR-1537954196195873500",
                        "status": "REJECTED",
                        "type": "CAPTURE"
                    }
                ]
            }
        ]
    }
}
]';
    if i_invalid ='T' then 
        l_json := replace(l_json,'}','');
    end if;

        return l_json;

    exception 
        when others then 
        logger.log_error (
            p_text   => 'order generate error',
            p_scope  => l_scope
        );
    end generate_notif_json;
    --
    PROCEDURE refresh_oauth_token
    IS 
        l_response_clob   clob;
        l_expires_in      number;
        L_scope           varchar2(100) := C_scope_prefix||'refresh_oauth_token';
    BEGIN 
        apex_web_service.g_request_headers.delete;
        apex_web_service.g_request_headers(1).name := 'Content-Type';
        apex_web_service.g_request_headers(1).value := 'application/x-www-form-urlencoded';

        l_response_clob := APEX_WEB_SERVICE.make_rest_request(
            p_url          => g_oauth_url,
            p_http_method  => 'POST',
            p_username     => g_client_id,
            p_password     => g_client_secret,
            p_body         => 'grant_type=client_credentials'
            );

            APEX_JSON.parse(l_response_clob);

            g_oauth_token := apex_json.get_varchar2(p_path => 'access_token');
            l_expires_in  := apex_json.get_number(p_path => 'expires_in') ;
            g_token_valid_upto := sysdate + (l_expires_in - 60)/(24*3600);

        logger.log_info (
            p_text   => 'OAUTH token obtained : '||g_oauth_token||', valid upto : '||
                        to_char(G_token_valid_upto, 'dd/mm/yyyy hh24:mi:ss'),
            p_scope  => L_scope
        );

    EXCEPTION 
        WHEN OTHERS THEN 
        logger.log_error (
            p_text   => 'OAUTH token Error',
            p_scope  => L_scope,
            p_extra  => l_response_clob
        );
    END refresh_oauth_token;
    --
    PROCEDURE post_json_via_rest(
        I_token    varchar2 default NULL
    )
    IS 
        l_response_clob    clob;
        l_expires_in       number;
        L_scope           varchar2(100) := C_scope_prefix||'post_json_via_rest';
    BEGIN 
        refresh_oauth_token;
        
        apex_web_service.g_request_headers.delete;
        apex_web_service.g_request_headers(1).name  := 'Authorization';
        apex_web_service.g_request_headers(1).value := 'Bearer '||NVL(I_token,g_oauth_token);


            l_response_clob := APEX_WEB_SERVICE.make_rest_request(
                p_url          => g_end_url,
                p_http_method  => 'POST',
                p_body_blob    => UTL_RAW.CAST_TO_RAW(generate_notif_json())
                );

            G_status_code := apex_web_service.g_status_code;

    EXCEPTION 
        WHEN OTHERS THEN 
        logger.log_error (
            p_text   => 'JSON poster Error',
            p_scope  => L_scope
        );
    END post_json_via_rest;
end;
/

show err;

exec TEST_CMS_PAYMENT_NOTIFICATION.post_json_via_rest;

create or replace package test_between_string as

  -- %suite(Between string function)

  -- %test(Returns substring from start position to end position)
  procedure normal_case;

  -- %test(Returns substring when start position is zero)
  procedure zero_start_position;

  -- %test(Returns string until end if end position is greater than string length)
  procedure big_end_position;

  -- %test(Returns null for null input string value)
  procedure null_string;
end;
/

show err;

create or replace package body test_between_string as

  procedure normal_case is
  begin
    ut.expect( betwnstr( '1234567', 2, 5 ) ).to_( equal('2345') );
  end;

  procedure zero_start_position is
  begin
    ut.expect( betwnstr( '1234567', 0, 5 ) ).to_( equal('12345') );
  end;

  procedure big_end_position is
  begin
    ut.expect( betwnstr( '1234567', 0, 500 ) ).to_( equal('1234567') );
  end;

  procedure null_string is
  begin
    ut.expect( betwnstr( null, 2, 5 ) ).to_( be_null );
  end;

end;
/

  --%aftereach
  --%beforetest

show err;

set serveroutput on;

exec ut.run('test_between_string');

/*

  --%test(Description of another behavior)
  --%disabled
  procedure other_test;

  --%beforeall
  --%afterall
  --%beforeeach
  --%aftereach
  --%beforetest

  --%test(Description of tesed behavior)
  --%beforetest(setup_for_a_test)
  --%beforetest(another_setup_for_a_test)
  procedure some_test;

If --%throws(-20001,-20002) is specified and no exception is raised or the exception raised is not on the list of provided exception numbers, the test is marked as failed.

ut.expect( 3 ).to_be_between( 1, 3 );

open l_cursor for select * from dual where 1 = 0;
ut.expect( l_cursor ).to_be_empty();

ut.expect( ( 1 = 0 ) ).to_be_false();

ut.expect( sysdate ).to_be_greater_or_equal( sysdate - 1 );

ut.expect( 2 ).to_be_greater_than( 1 );

ut.expect( 3 ).to_be_less_or_equal( 3 );

ut.expect( 'Lorem_impsum' ).to_be_like( a_mask => '%rem#_%', a_escape_char => '#' );
ut.expect( 'Lorem_impsum' ).to_be_like( '%rem#_%', '#' );

ut.expect( to_clob('ABC') ).to_be_not_null();

ut.expect( cast(null as varchar2(100)) ).to_be_null();

ut.expect( ( 1 = 1 ) ).to_be_true();

open l_cursor for select * from dual connect by level <=10;
ut.expect( l_cursor ).to_have_count(10);

ut.expect( a_actual => '123-456-ABcd' ).to_match( a_pattern => '\d{3}-\d{3}-[a-z]', a_modifiers => 'i' );
ut.expect( 'some value' ).to_match( '^some.*' );

ut.expect( l_actual ).to_equal( l_expected );

--Act / Assert
ut.expect( get_animal() ).to_equal( 'a dog' );

Hints

tests small and focused on one task.

serviceok -> returns http status code 200
getspecific attribute
Returncount
Norecordreturned
MissingMandatoryelement

despatch_event : Posts despatch event successfully : response is not null and http status code is 200
cancel_event : Posts cancel event successfully : 
return_event : Posts despatch event successfully :
uuid is of proper format
environment flag is properly populated.

be_like

procedure test_if_cursor_is_empty is
  l_cursor sys_refcursor;
begin
  open l_cursor for select * from dual connect by level <=10;
  ut.expect( l_cursor ).to_have_count(10);
  --or
  ut.expect( l_cursor ).to_( have_count(10) );
end;


*/
select * from table(apex_string.split_numbers('1:2:3',':'));

create table temp(c1 number, c2 number);

declare 
    l_val APEX_050100.WWV_FLOW_T_NUMBER;
    type t_temp is table of temp%rowtype index by pls_integer;
    l_temp_tab t_temp;
begin
    select rownum, rownum
    bulk collect into l_temp_tab
    from dual
    connect by rownum <=10;
    forall i in l_temp_tab.first..l_temp_tab.last 
    insert into temp values l_temp_tab(i)
    returning c1 bulk collect into l_val;
    for i in (select * from table(l_val))
    loop
      dbms_output.put_line( 'Text');
    end loop;
end;

create_event(event_count, event_type) return event_id;

--
--
--

create or replace package test_service_demo as

    -- %suite(Sample ORDS Service)

    -- %test(Service returns http status 200)
    procedure service_ok;

    -- %test(Service returns expected number of objects)
    procedure object_count;

    -- %test(Service returns nothing for specific case)
    procedure no_object;

    -- %test(Service returns mandatory element)
    procedure valid_element;
end;
/

show err;

create or replace package body test_service_demo as
    g_base_url         varchar2(100) 
    := 'http://localhost:8080/ords/api/demo/v1/data';
     -- := 'http://ords-alb.dev.transit.ri-tech.io/ords/omsdev/api/sample/data';

    procedure service_ok is
        l_returnvalue                  clob;
    begin
        l_returnvalue := apex_web_service.make_rest_request(g_base_url,'GET');
        ut.expect( apex_web_service.g_status_code ).to_equal(200);
    end;

    procedure object_count is
        l_returnvalue                  clob;
    begin
        l_returnvalue := apex_web_service.make_rest_request(g_base_url,'GET');
        apex_json.parse(l_returnvalue);
        ut.expect( apex_json.get_count(p_path=>'items')).to_equal(1) ;
    end;

    procedure no_object is
    begin
        ut.expect((1)).to_equal(1);
    end;

    procedure valid_element is
    begin
        ut.expect( apex_json.does_exist(p_path => 'items[%d].dummy', p0 => 1) ).to_be_true();
    end;

end;
/

show err;

exec ut.run('test_service_demo');

/*
create or replace package test_service_demo as

    -- %suite(Sample ORDS Service)

    -- %test(Service returns http status 200)
    procedure service_ok;

    -- %test(Service returns expected number of objects)
    procedure object_count;

    -- %test(Service returns nothing for specific case)
    procedure no_object;

    -- %test(Service returns mandatory element)
    procedure valid_element;
end;
/

show err;

create or replace package body test_service_demo as
    g_base_url         varchar2(100) 
    := 'http://localhost:8080/ords/api/demo/v1/data';
     -- := 'http://ords-alb.dev.transit.ri-tech.io/ords/omsdev/api/sample/data';

    procedure service_ok is
        l_returnvalue                  clob;
    begin
        l_returnvalue := apex_web_service.make_rest_request(g_base_url,'GET');
        ut.expect( apex_web_service.g_status_code ).to_equal(200);
    end;

    procedure object_count is
        l_returnvalue                  clob;
    begin
        l_returnvalue := apex_web_service.make_rest_request(g_base_url,'GET');
        apex_json.parse(l_returnvalue);
        ut.expect( apex_json.get_count(p_path=>'items')).to_equal(1) ;
    end;

    procedure no_object is
    begin
        ut.expect((1)).to_equal(1);
    end;

    procedure valid_element is
    begin
        ut.expect( apex_json.does_exist(p_path => 'items[%d].dummy', p0 => 1) ).to_be_true();
    end;

end;
/

show err;

exec ut.run('test_service_demo');

*/

--
-- NAME:  create_ords_rest_service_aps.sql
-- TYPE:  SQL Script
-- TITLE: Create Restful Service - aps
-- NOTES:
--
--$Revision:   1.0  $
-------------------------------------------------------------------------------
-- Version | Date      | Author             | Reason
-- 1.0     |25/06/2018 | S. Raut            | Initial Revision
-------------------------------------------------------------------------------
DECLARE
    l_scope               s_datatype.unit_name   := 'create_ords_rest_service_aps.sql';
    l_module_name         s_datatype.unit_name   := 'aps.v1';
    L_module_base_path    s_datatype.unit_name   := 'aps/v1/';
    l_template_pattern    s_datatype.unit_name   := 'alexa';
    l_handler_source      s_datatype.long_string :=
    q'[
    SELECT * 
    FROM DUAL
    ]';
BEGIN
    logger.log_info (
        p_text   => s_const.C_begin,
        p_scope  => L_scope
    );

    ords.define_module(
        p_module_name    => l_module_name,
        p_base_path      => l_module_base_path,
        p_status         => 'PUBLISHED',
        p_comments       => 'API Module for restful service : aps'
    );

    logger.log_info (
        p_text   => 'Module Created',
        p_scope  => L_scope
    );

    ords.define_template(
        p_module_name => l_module_name,
        p_pattern     => l_template_pattern,
        p_comments    => 'Resource Template for restful service: aps'
    );

    logger.log_info (
        p_text   => 'Template Created',
        p_scope  => L_scope
    );

    ords.define_handler(
        p_module_name    => l_module_name,
        p_pattern        => l_template_pattern,
        p_method         => 'GET',
        p_source_type    => ords.source_type_collection_feed,
        p_source         => l_handler_source,
        p_comments       => 'Handler for restful service : aps'
    );

    logger.log_info (
        p_text   => 'Handler Created',
        p_scope  => L_scope
    );
END;
/

SHOW ERR;
