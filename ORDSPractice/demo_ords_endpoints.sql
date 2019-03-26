oms_web_order.pkb,1.4,F,OMS

begin
  ORDS.ENABLE_SCHEMA(
      p_enabled             => TRUE,
      p_schema              => 'ITSR',
      p_url_mapping_type    => 'BASE_PATH',
      p_url_mapping_pattern => 'itsr-api',
      p_auto_rest_auth      => FALSE);

    ORDS.DEFINE_MODULE(
       p_module_name    => 'Demo.v1',
       p_base_path      => 'demo/v1',
       p_items_per_page => 10,
       p_status         => 'PUBLISHED',
       p_comments       => 'Demo Date Module' );

    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'Demo.v1',
        p_pattern        => 'datetrial/');

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'Demo.v1',
        p_pattern        => 'datetrial/',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_query,
        p_source         => 
                        q'[
                        SELECT *
                        FROM demo_date
                        ]'
        );

    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'Demo.v1',
        p_pattern        => 'dbsession/');

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'Demo.v1',
        p_pattern        => 'dbsession/',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_query,
        p_source         => 
                        q'[
select * 
from
    (
    select 'SESSION' SCOPE,nsp.* from nls_session_parameters nsp
    union
    select 'DATABASE' SCOPE,ndp.* from nls_database_parameters ndp
    union
    select 'INSTANCE' SCOPE,nip.* from nls_instance_parameters nip
    ) a
    pivot  
        (LISTAGG(VALUE) WITHIN GROUP (ORDER BY SCOPE)
    FOR SCOPE
    in (
    'SESSION' as "SESSION",
    'DATABASE' as DATABASE,
    'INSTANCE' as INSTANCE)
    )
                        ]'
        );

    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'Demo.v1',
        p_pattern        => 'timezone/');

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'Demo.v1',
        p_pattern        => 'timezone/',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_query,
        p_source         => 
                        q'[
                        select dbtimezone, sessiontimezone from dual
                        ]'
        );

    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'Demo.v1',
        p_pattern        => 'timestamp/');

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'Demo.v1',
        p_pattern        => 'timestamp/',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_query,
        p_source         => 
                        q'[
                        select
                            sysdate                 "sysdate",
                            systimestamp            "systimestamp",
                            current_date            "current_date",
                            current_timestamp       "current_timestamp",
                            localtimestamp          "localtimestamp",
                            sysdate + 90            sysdate_after_90days,
                            systimestamp + 90       systimestamp_after_90days,
                            current_date + 90       current_date_after_90days,
                            current_timestamp + 90  current_timestamp_after_90days,
                            localtimestamp + 90     localtimestamp_after_90days
                        from 
                        dual
                        ]'
        );

    COMMIT;

end;
/

declare

  l_sys_d     date;
  l_sys_tswtz timestamp with time zone;
  l_cur_d     date;
  l_cur_tswtz timestamp with time zone;
 
begin
 
  execute immediate 'alter session set time_zone = ''Europe/London''';

  l_sys_d     := sysdate +90;
  l_sys_tswtz := systimestamp +90;
  l_cur_d     := current_date +90;
  l_cur_tswtz := current_timestamp +90;
  
  dbms_output.put_line(to_char(l_sys_d, 'dd-mon-yyyy hh24:mi:ss'));
  dbms_output.put_line(to_char(l_sys_tswtz, 'dd-mon-yyyy hh24:mi:ss.ff tzr')); 
  dbms_output.put_line(to_char(l_cur_d, 'dd-mon-yyyy hh24:mi:ss'));
  dbms_output.put_line(to_char(l_cur_tswtz, 'dd-mon-yyyy hh24:mi:ss.ff tzr'));
  
  execute immediate 'alter session set time_zone = ''Europe/Copenhagen''';
  
  l_sys_d     := sysdate +90;
  l_sys_tswtz := systimestamp +90;
  l_cur_d     := current_date +90;
  l_cur_tswtz := current_timestamp +90;
  
  dbms_output.put_line(to_char(l_sys_d, 'dd-mon-yyyy hh24:mi:ss'));
  dbms_output.put_line(to_char(l_sys_tswtz, 'dd-mon-yyyy hh24:mi:ss.ff tzr'));
  dbms_output.put_line(to_char(l_cur_d, 'dd-mon-yyyy hh24:mi:ss'));
  dbms_output.put_line(to_char(l_cur_tswtz, 'dd-mon-yyyy hh24:mi:ss.ff tzr'));
 
end;
/

The focus here will be on tracking a date from the browser to the database and then back from the database to the browser.

Some clients may even use the session time zone to perform time zone conversions when storing or fetching values (examples can be seen with node-oracledb and ORDS).

---- My ritox settings

lrwxrwxrwx 1 root root 25 Dec 22 14:30 /etc/localtime -> ../usr/share/zoneinfo/UTC

unlink /etc/localtime

unlink /etc/timezone

ln -s /usr/share/zoneinfo/Etc/GMT+2 /etc/localtime

ln -s /usr/share/zoneinfo/Etc/GMT+2 /etc/timezone

/usr/share/zoneinfo/Europe/Paris

ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

ln -s /usr/share/zoneinfo/Europe/Paris /etc/timezone

select dbtimezone, sessiontimezone from dual;

----
sudo ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

order date fpr store orders

Etc/UTC

sudo ln -s /usr/share/zoneinfo/Etc/GMT+6 /etc/localtime

sudo unlink /etc/localtime

sudo ln -s /usr/share/zoneinfo/Etc/GMT+6 /etc/localtime

/etc/timezone

/etc/localtime -> /usr/share/zoneinfo/Etc/UTC

ln -s /usr/share/zoneinfo/Etc/GMT+1 /etc/timezone

unlink /etc/localtime

ln -s /usr/share/zoneinfo/Etc/GMT+1 /etc/localtime

unlink /etc/localtime

ln -s /usr/share/zoneinfo/Etc/GMT /etc/localtime

unlink /etc/localtime

ln -s /usr/share/zoneinfo/Etc/GMT-1 /etc/localtime

unlink /etc/localtime

ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime


alter session set time_zone= '-6:00';

select 
   current_timestamp,
   systimestamp, 
   localtimestamp 
from 
   dual;

CREATE OR REPLACE TRIGGER session_TZ AFTER logon ON database
begin
if ora_login_user = 'AUSER' then
execute immediate 'Alter session set time_zone=''UTC''';
end if;
end;
/

"The database time zone is relevant only for TIMESTAMP WITH LOCAL TIME ZONE columns. 

Oracle normalizes all TIMESTAMP WITH LOCAL TIME ZONE data to the time zone of the database when the data is stored on disk. 

If you do not specify the SET TIME_ZONE clause, then Oracle uses the time zone of the operating system of the server. 

If the operating system's time zone is not a valid Oracle time zone, then the database time zone defaults to UTC."

setenv TZ America/Winnipeg

select systimestamp from dual;

alter session set NLS_TERRITORY='AMERICA';
alter session set NLS_DATE_FORMAT='dd/mm/yyyy hh24:mi:ss';
set sqlformat ansiconsole;

select * from demo_date;

what do you mean "it would not work for other parts of the world" -- am I missing something? 

If you have only a date column, you'll be converting ALL dates to some timezone -- a single timezone. 

If you have people accessing from all over the world -- you don't want to convert into EST/EDT at all. 

Can you elaborate? 

----------------
--
-- NAME:  demo_ords_endpoints.sql
-- TYPE:  Anonymous PL/SQL Block
-- TITLE: This block creates DEMO ORDS Module/Template/Handler
-- NOTES: This rest end point can be accessed using following url pattern
--        http://<host:port>/ords/<database_name>/<schema_name>/demo-api/dbdetails/
--
--$Revision:   1.0  $
--------------------------------------------------------------------------------------------
-- Version | Date      | Author          | Reason
-- 1.0     |06/06/2017 | S Raut          | Initial Revision
---------------------------------------------------------------------------------------------
DECLARE
    L_count     NUMBER;
BEGIN

    SELECT COUNT(1) 
    INTO   L_count
    FROM  USER_ORDS_SCHEMAS;
    
    IF L_count = 0 THEN
        ORDS.ENABLE_SCHEMA(
            p_enabled             => TRUE,
            p_schema              => USER,
            p_url_mapping_type    => 'BASE_PATH',
            p_url_mapping_pattern => LOWER(user),
            p_auto_rest_auth      => FALSE);
    END IF;
    
    ORDS.DEFINE_MODULE(
       p_module_name    => 'DEMO-API',
       p_base_path      => 'demo-api/',
       p_items_per_page => 10,
       p_status         => 'PUBLISHED',
       p_comments       => 'Demo Module' );

    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'DEMO-API',
        p_pattern        => 'dbdetails/');

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'DEMO-API',
        p_pattern        => 'dbdetails/',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_query,
        p_source         => 
                        q'[
                        SELECT
                            sys_context ('userenv','CURRENT_SCHEMA')    CURRENT_SCHEMA,
                            sys_context ('userenv','CURRENT_USER')      CURRENT_USER,
                            sys_context ('userenv','DB_DOMAIN')         DB_DOMAIN,
                            sys_context ('userenv','DB_NAME')           DB_NAME,
                            sys_context ('userenv','HOST')              HOST,
                            sys_context ('userenv','INSTANCE')          INSTANCE,
                            sys_context ('userenv','INSTANCE_NAME')     INSTANCE_NAME,
                            sys_context ('userenv','IP_ADDRESS')        IP_ADDRESS,
                            sys_context ('userenv','LANGUAGE')          LANGUAGE,
                            sys_context ('userenv','MODULE')            MODULE,
                            sys_context ('userenv','NETWORK_PROTOCOL')  NETWORK_PROTOCOL,
                            sys_context ('userenv','OS_USER')           OS_USER,
                            sys_context ('userenv','SERVER_HOST')       SERVER_HOST,
                            sys_context ('userenv','SERVICE_NAME')      SERVICE_NAME,
                            sys_context ('userenv','SESSION_USER')      SESSION_USER,
                            sys_context ('userenv','SESSION_USERID')    SESSION_USERID,
                            sys_context ('userenv','SESSIONID')         SESSIONID,
                            sys_context ('userenv','SID')               SID,
                            sys_context ('userenv','STATEMENTID')       STATEMENTID,
                            sys_context ('userenv','TERMINAL')          TERMINAL
                        FROM DUAL
                        ]'
        );

    COMMIT;

END;
/
