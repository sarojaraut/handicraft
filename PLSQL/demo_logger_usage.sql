Logger Usage Text
https://github.com/OraOpenSource/Logger/blob/master/docs/Best%20Practices.md

/*

exec logger.set_level(logger.g_debug);

exec logger.set_level(logger.g_off);

exec logger.set_level(logger.g_error);

ok_to_log(logger.g_debug) then logger.log
ok_to_log(logger.g_information) then logger.log_information
ok_to_log(logger.g_information) then logger.log_info
There is a diff between log_information and log_info  and log_warning and log_warn
The unit name is one label up from call stack if called log_information
ok_to_log(logger.g_warning) then logger.log_warn
ok_to_log(logger.g_warning) then logger.log_warning
ok_to_log(logger.g_error) then logger.log_error

*/


create or replace package logger_demo 
is

gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

procedure logging_test (
     i_arg1   in      varchar2
    ,io_arg2  in out  varchar2
    ,o_arg3   out     varchar2
    );

end logger_demo;
/

create or replace package body logger_demo
is

    procedure logging_test (
         i_arg1   in      varchar2
        ,io_arg2  in out  varchar2
        ,o_arg3   out     varchar2
        )
    is
        l_scope  logger_logs.scope%type := gc_scope_prefix || 'logging_test';
        l_params logger.tab_param;
    begin
        --
        -- Sample Param Tracking
        --
        logger.append_param (
            p_params =>  l_params, 
            p_name   =>  'i_arg1', 
            p_val    =>  i_arg1
            );
        logger.append_param (
            p_params =>  l_params, 
            p_name   =>  'io_arg2', 
            p_val    =>  io_arg2
            );
        logger.append_param (
            p_params =>  l_params, 
            p_name   =>  'o_arg3', 
            p_val    =>  o_arg3
            );
        --
        -- Sample Start
        --
        logger.log_info (
            p_text    => 'Start'
            ,p_scope  => l_scope
            ,p_extra  => 'Info CLOB'
            ,p_params => l_params
            );
        --
        -- Sample Debug
        --
        logger.log (
            p_text    => 'Debug-1'
            ,p_scope  => l_scope
            ,p_extra  => 'Debug CLOB'
            ,p_params => l_params
            );
        --
        -- Sample Error
        --
        logger.log_error (
            p_text    => 'Error-1'
            ,p_scope  => l_scope
            ,p_extra  => 'Error CLOB'
            ,p_params => l_params
            );
        --
        -- Sample Warning
        --
        logger.log_warn (
            p_text    => 'Warning-1'
            ,p_scope  => l_scope
            ,p_extra  => 'Warning CLOB'
            ,p_params => l_params
            );
        --
        -- Sample Environment Details Logging
        --
        logger.log_userenv('USER'); -- Can be used for ALL, NLS, USER, INSTANCE
        --
        -- Sample Elapsed Time Tracking
        --
        logger.time_reset;
        
        logger.time_start('Elapsed Time for OuterBlock');
        dbms_lock.sleep(2);
        logger.time_start('Elapsed Time for InnerBlock');
        dbms_lock.sleep(3);
        logger.time_stop('Elapsed Time for InnerBlock');        
        logger.time_stop('Elapsed Time for OuterBlock');
        --
        -- Permanent Logging, will not be purged by purge schedule
        --
        logger.log_permanent (
            p_text    => 'Product Upgraded to x.x.x'
            ,p_scope  => l_scope
            );
        
        --
        -- Sample End
        --
        logger.log_info (
            p_text    => 'End'
            ,p_scope  => l_scope
            );
    exception
        when others then
            logger.log_error ();
            raise;
    end;

end logger_demo;
/

SET SERVEROUTPUT ON;
SET TIMING ON;

declare
    l_temp1 varchar2(10) := 'arg_val_1';
    l_temp2 varchar2(10) := 'arg_val_2';
    l_temp3 varchar2(10) := 'arg_val_3';
begin
    logger_demo.logging_test (
             i_arg1   => l_temp1
            ,io_arg2  => l_temp2
            ,o_arg3   => l_temp3
            );
end;
/


CREATE OR REPLACE PROCEDURE proc1
IS
BEGIN
   RAISE NO_DATA_FOUND;
END;
/

CREATE OR REPLACE PROCEDURE proc2 IS
BEGIN
   proc1;
EXCEPTION
   WHEN OTHERS THEN 
        logger.log_error (
            p_text    => 'Proc - 2 Error Text'
            ,p_scope  => 'proc2'
            );
   RAISE VALUE_ERROR;
END;
/
CREATE OR REPLACE PROCEDURE proc3 IS
BEGIN
   proc2;
EXCEPTION
   WHEN OTHERS THEN 
        logger.log_error (
            p_text    => 'Proc - 3 Error Text'
            ,p_scope  => 'proc3'
            );
   RAISE DUP_VAL_ON_INDEX;
END;
/

SET SERVEROUTPUT ON;
BEGIN /* Now execute the top-level procedure. */
   proc3;
EXCEPTION
   WHEN OTHERS
   THEN
        logger.log_error (
            p_text    => 'Anonymous Error Text'
            ,p_scope  => 'Ano Block'
            );
      DBMS_OUTPUT.PUT_LINE (DBMS_UTILITY.FORMAT_ERROR_STACK);
END;
/

DBMS_UTILITY.FORMAT_ERROR_STACK
DBMS_UTILITY.FORMAT_ERROR_BACKTRACE



SELECT * FROM LOGGER_LOGS

SELECT * FROM LOGGER_PREFS_BY_CLIENT_ID

SELECT * FROM LOGGER_PREFS

SELECT * FROM LOGGER_LOGS_APEX_ITEMS

SELECT * FROM LOGGER_LOGS_5_MIN

SELECT * FROM LOGGER_LOGS_60_MIN

SELECT * FROM LOGGER_LOGS_TERSE

SELECT * FROM logger_prefs where pref_name = 'LOGGER_VERSION';

SET SERVEROUTPUT ON FORMAT WRAP;

EXEC LOGGER.STATUS;

EXEC LOGGER.PURGE_ALL;

UPDATE LOGGER_PREFS SET PREF_VALUE='FALSE' WHERE PREF_NAME='PROTECT_ADMIN_PROCS' AND PREF_VALUE='TRUE'

UPDATE LOGGER_PREFS SET PREF_VALUE='TRUE' WHERE PREF_NAME='PROTECT_ADMIN_PROCS' AND PREF_VALUE='FALSE'

COMMIT -- TRUE means other schemas can't change the logging information , FALSE means any one can use the admin APIs.

EXEC LOGGER.PURGE(p_purge_min_level => 2); -- 

exec logger.set_level(logger.g_debug);

exec logger.set_level(logger.g_off);

exec logger.set_level(logger.g_error);

exec logger.set_level(logger.g_information); -- Timer not logged in info level

begin
  logger.log('This is a debug message. (level = DEBUG)');
  logger.log_information('This is an informational message. (level = INFORMATION)');
  logger.log_warning('This is a warning message. (level = WARNING)');
  logger.log_error('This is an error message (level = ERROR)');
  logger.log_permanent('This is a permanent message, good for upgrades and milestones. (level = PERMANENT)');
end;
/

Logger Open Source Project, available in github. Originally developed by Tyler Muth and now mantained by experts like 

APEX code instrumentation Using Logger Product
Easy and quick way of logging the debug information. 
Multiple overloaded APIs for ease of usage.
More flexible and rish in features compared to our s_info and s_err.
Ablity to capture all the parameters passed to a proc/function regardless of data type.
Supports different labels of logging (Debug, info, warn, Error, permanent, Apex, timing, sys_context, off)
Everything logged into the same table with in-built purge policy.
Most options are configurable and can be changed instantly using supplied APIs.
Ability to change cnfiguration settings specific to a client.
Easy to "Turn-off/Turn-on" logger globally/client specific with virtually no performance impact.
Provides alternate views of the logger data, last five minutes, last one hour and terse format.
APEX specific instrumentation, logging whole session details.
Logging item values for, specific to a page, all page items, all app items, all items.
Also captures details of APEX events.

ORDS
LOGGER
LDAP authentication
TAPI
Upgrading to 5.1.1

New framework is more flexible and feature rich compared to our s_info and s_err.


Error Logging
Timing: Logger has a very simple timing framework built-in that makes it easy to benchmark sections of code.
Instrumentation: Because it's easy to "turn-off" logger globally with virtually no performance impact, it's easy to get in the habit of leaving debug calls in production code. Now, when something does go wrong, you simply flip the switch and logger is enabled making it much quicker to debug errors.

exec dbms_session.set_identifier('my_identifier');
-- This sets the logger level for current identifier
exec logger.set_level('DEBUG', sys_context('userenv','client_identifier'));
exec logger.unset_client_level('my_client_id');

procedure set_level(
    p_level in varchar2 default 'DEBUG',
    p_client_id in varchar2 default null, -- You must specify this to enable client_specific logging
    p_include_call_stack in varchar2 default null, -- TRUE or FALSE. Default: TRUE
    p_client_id_expire_hours in number default null -- Number of hours after which the client_id specific logging will be expired. Default is stored in logger_prefs: PREF_BY_CLIENT_ID_EXPIRE_HOURS
)

Unset by specific client_id:

exec logger.unset_client_level('my_client_id');

Unset all expired client_ids. Note this run automatically each hour by the LOGGER_UNSET_PREFS_BY_CLIENT job.

exec logger.unset_client_level;

Unset all client configurations (regardless of expiry time):

exec logger.unset_client_level_all;

####View All Client Specific Configurations The following query shows all the current client specific log configurations:

select * from logger_prefs_by_client_id;

##Maintenance

By default, the DBMS_SCHEDULER job "LOGGER_PURGE_JOB" runs every night at 1:00am and deletes any logs older than 7 days that are of error level g_debug or higher which includes g_debug and g_timing. This means logs with any lower level such as g_error or g_permanent will never be purged. You can also manually purge all logs using logger.purge_all, but this will not delete logs of error level g_permanent.

Starting in 2.0.0 a new job was LOGGER_UNSET_PREFS_BY_CLIENT introduced to remove client specific logging. By default this job is run every hour on the hour.

exec logger.log('hello world');

select * from logger_logs;

The following example demonstrates how to use p_scope when called from an APEX application:

exec logger.log('Some text', 'apex.my_app.page4.some_process');

exec logger.log_cgi_env;

##Log Parameters Logger has wrapper functions to quickly and easily log parameters. All primary log procedures take in a fourth parameter to support logging a parameter array. The values are explicitly converted to strings so you dont need to convert them. The parameter values will be stored n the extra column.

##Log APEX Item Values This feature is useful in debugging issues in an APEX application that are related session state. The developers toolbar in APEX provides a place to view session state, but it wont tell you the value of items midway through page rendering or right before and after an AJAX call to an application process.

Before using this feature its important to note that it must be configured first. The next section discusses this configuration.

-- in an on-submit page process
begin
  logger.log_apex_items('Debug Store Location Page');
end;

One entry in LOGGER_LOGS : Text = 'Debug Store Location Page', logger_level=128(default), Module=HR/APEX:APP 127:6, Action=Processes - point: ON_SUBMIT_BEF client_info=session:username and id=170

Set of entries (for all items of the app - default) in LOGGER_LOGS_APEX_ITEMS with log_id=170 ID of previous query

log_apex_items(
    p_text           => 'Debug Store Location Page',
    p_scope          =>'Trial Scope',
    p_item_type      => 6, -- any page number of the app or ALL, APP, PAGE
    p_log_null_items => FALSE, -- Don't log null values
    p_level          => logger.g_information) ;

One entry in LOGGER_LOGS : Text = 'Debug Store Location Page', logger_level=8(logger.g_information), Module=HR/APEX:APP 127:6, Action=Processes - point: ON_SUBMIT_BEF client_info=session:username and id=170

Set of entries for all items of page=6 (and are not null) in LOGGER_LOGS_APEX_ITEMS with log_id=170 ID of previous query

exec logger.log_cgi_env;

