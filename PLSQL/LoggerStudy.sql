EXCEPTION
    WHEN OTHERS
    THEN
        logger.log_warn (
            p_text   => 'Create Store Order - package initialization WARN',
            p_scope  => 'TEST_SSOPE',
            p_extra  => SQLERRM
            );
            
        logger.log_warning (
            p_text   => 'Create Store Order - package initialization WARNING',
            p_scope  => 'TEST_SSOPE',
            p_extra  => SQLERRM
            );
            
        logger.log_error (
            p_text   => 'Create Store Order - package initialization failure',
            p_scope  => 'TEST_SSOPE',
            p_extra  => SQLERRM
            );

        RAISE;
END;
/

dbms_application_info.set_client_info('names_data');
dbms_session.set_identifier('names_data');

-- At package intialisation section we can set like this which will be automatically
-- picked up by logger
dbms_application_info.set_client_info('package_name');
dbms_session.set_identifier('web_random');
-- And at each individual function level we can set module and action

  dbms_application_info.set_action('r_bem'); -- at begning
  dbms_application_info.set_action(null); -- at end

  dbms_application_info.set_module('TestModule','TestAction');
  dbms_application_info.set_action('TestAction-1');

  dbms_application_info.set_module('',''); --Set both null at the end before the next module

exception
  when others then
  dbms_application_info.set_action(null);
raise;

DBMS_APPLICATION_INFO.SET_MODULE ( 
module_name IN VARCHAR2, 
action_name IN VARCHAR2); 

DBMS_APPLICATION_INFO.SET_CLIENT_INFO (
client_info IN VARCHAR2
); -- Visible in v$session and client_info of logger_logs, module and action 

begin
  dbms_application_info.set_client_info('SarojTest');
  dbms_application_info.set_module('TestModule','TestAction');
  dbms_application_info.set_action('TestAction-1');
  dbms_session.set_identifier('TestProcess');
end;
/

exec logger.log('Text Message','Start');



Logger is a Open Source PL/SQL logging and debugging framework developed by group of Oracle Experts. 
Its open source and source code is available to us if we need to customize.

Why do we need a new logging framework

Existing loging frame work has been doing a pretty good job but this might not be sufficient when we think about complex miltitier architecture (TCPL, AWS, TOMCAT, ORDS, DB, METAPACK).
Most of information flowing through these tiers will be either JSON or XML.
Tracking down the bottleneck/source of the problem can be extremely hard, if we dont capture additional details.
Existing logging framework s_info and s_error which writes into tables S_info_log and s_err_log, is seems to be in-adequete for OMS database and thats why we already have another layer of extension logging tables OMS_ERROR_LOG, OMS_METAPCK_XML_LOG, OMS_ACTIVITY_LOG. The list of extensions tables will grow further we dont find a generic frame work like logger.
We have started using automated testing, continious integration, think of a situation we have started a automated integration testing suite containing 100 test cases and the tool gave us the final result 20 test cases failed out of 100. After investigation we thought that its database problem, which usually people thinks. When the application is spread of multiple tiers and without proper instrumentation, without knowing what are the parametrs passed in to database, without knowng the xmls or JSONs its difficlut to pin point the exact problm with confdence. We can make a educated guess without extra information but still that will be guess. Why guess when we can know.
With new logging framwrok in place When something goes wrong and you are under pressure to track down the cause you can find the solution far quicker with code that is telling you what is going on exactly inside the system.

Advantages of New framework
Consistent Parameter logging : Regardless of the datatype of the parameter ( Number, character, Date, Boolean) we need to call the same api add_param.
Debugging: Particularly useful in multi-tier application, TCPL, AWS, .Net, ORDS and Oracle application express. logger.log (Anything developers need for Debuging) or logger.log_info (Anything Developers/Business need for tracability), logger.log_permanent(Anything needed to be retained permanently unless purged manually, e.g major app upgrade details)
Error Logging: Easy for developers to log and raise errors in a nice and persistent way, logger.log_warn (Anything actionable without abrupting processing) or logger.log_error(Anything actionable abrupting processing). this gives the precise line number of the code throwing the excetpion.
Timing: Simple timing framework built-in that makes it easy to benchmark sections of code.
Instrumentation: Its easy to "turn-off" or "turn-on" with "flip of switch" and change the logging lavel.

Logger Usage Text
https://github.com/OraOpenSource/Logger/blob/master/docs/Best%20Practices.md

 I am thinking of installing  new PL/SQL logging and debugging framework in all our database(http://www.oraopensource.com/logger/). I think this is very simple and powerfull framework and covers some of the limitations of our existing framework (s_info and s_error). 

Limitations of Existing Framewark (S_info, s_error) which can be addressed in new framework.
Tracking of input parameters is not very efficient using s_info.p_track_process : logger.append_param logs all params in a single record in database.
Tracking of client environment settings - not sure if supported : logger.log_userenv('USER') also can be used for ALL, NLS, USER, INSTANCE. (will be usefull for application express and ORDS)
Current framework logs into multiple tables s_info_log and s_error_log : Everything logged into the same log table and have multiple views on the same table like LOGGER_LOGS_5_MIN, LOGGER_LOGS_60_MIN, LOGGER_LOGS_TERSE.
Enabling logging based on client id - not sure if possible in the existing frame work. Logging can be enabled only for a specific client using new framework.
Current framework does not back track to the exact line number in case of nested chain of events throws error. New framework will pin point the exact line of code raising exception.
Current framework does not allow store large data set(clob,XML, JSON).
Timing: Not sure how timed stastics can be used in current framework : built-in timed stastics makes it easy to benchmark sections of code.
Instrumentation - Not sure how logging can be turned on or off in current framework :  Its easy to "turn-off" or "turn-on" with "flip of switch" in the new framework.

Featurs of New framework:
Debugging: Particularly useful in multi-tier application, TCPL, AWS, .Net, ORDS and Oracle application express. logger.log (Anything developers need for Debuging) or logger.log_info (Anything Developers/Business need for tracability), logger.log_permanent(Anything needed to be retained permanently unless purged manually, e.g major app upgrade details)
Error Logging: Easy for developers to log and raise errors in a nice and persistent way, logger.log_warn (Anything actionable without abrupting processing) or logger.log_error(Anything actionable abrupting processing)
Timing: Simple timing framework built-in that makes it easy to benchmark sections of code.
Instrumentation: Its easy to "turn-off" or "turn-on" with "flip of switch".

For stateless applications 

#What is Logger?

Logger is a PL/SQL logging and debugging framework. The goal of logger is to be as simple as possible to install and use. The primary use cases for this utility include:

Debugging: Its often difficult to track down the source of an error without some form of debugging instrumentation. This is particularly true in multi-tier, stateless architectures such as Application Exp qress.
Error Logging: While most experts agree that it's important not to mask errors, it's also nice to have a persistent record of them.
Timing: Logger has a very simple timing framework built-in that makes it easy to benchmark sections of code.
Instrumentation: Because it's easy to "turn-off" logger globally with virtually no performance impact, it's easy to get in the habit of leaving debug calls in production code. Now, when something does go wrong, you simply flip the switch and logger is enabled making it much quicker to debug errors.

When the application is spread over 14 tiers of complexity, tracking down the bottleneck is grievously hard.  If you just whip together an application and throw it out there without any thought to monitoring it over time, be prepared to have poor performance and no clue as to why or where.

No network, no application time, just the database.

End users want to know, is the system going slower over time, if so, by how much.  Management wants to know, what are my transaction response times, how many transactions do we do, when is the busiest time, and so on.

Without code instrumentation, you cannot answer any of those questions – not a single one.  Not accurately anyway.

Undoubtedly  – not.  It would run many times slower, perhaps hundreds of times slower.  Why?  Because you would have no clue where to look to find performance related issues.  You would have nothing to go on.  Without this “overhead” (air quotes intentionally used to denote sarcasm there)

You’ll find your code easier to maintain over time.  Also, make this instrumentation part of the production code, don’t leave it out!  Why?  Because, funny thing about production – you are not allowed to drop in “debug” code at the drop of a hat, but you are allowed to update a row in a configuration table, or in a configuration file! 

 it's soooo frustrating trying to guess what's going on inside
 
 There is no silver bullet, but instrumentation at least qualifies as a bronze bullet.
 
 Upgrade process: Can upgrade Logger rather than having to uninstall the old version and install the new version.
Log parameters: Standardize the logging of parameters when entering a procedure or function. You won’t need to convert the data format as the procedure is overloaded to handle many different object types.
Logger level by Client Identifier: This is by far one of the features I think most people wanted in Logger. You can now set the logging level based on a Client Identifier.

When bad things happen and you are under pressure to track down the cause you will find the problem far quicker with code that is telling you what exactly is happening.

##Demo

exec logger.log('hello world');

select * from logger_logs;

supports multiple logging levels

, , , 

logger.log_apex_items

##Install into an existing schema:

If possible, connect as a privileged user and issue the following grants to your "existing_user":

grant connect,create view, create job, create table, create sequence, 
create trigger, create procedure, create any context to existing_user;

@logger_install.sql

##Uninstall To uninstall Logger simple run the following script in the schema that Logger was installed in:

@drop_logger.sql

run as logger_user

@scripts/grant_logger_to_user.sql public

@scripts/create_logger_synonyms.sql <from_username>

create or replace public synonym logger for logger_user.logger;
create or replace public synonym logger_logs for logger_user.logger_logs;
create or replace public synonym logger_logs_apex_items for logger_user.logger_logs_apex_items;
create or replace public synonym logger_prefs for logger_user.logger_prefs;
create or replace public synonym logger_prefs_by_client_id for logger_user.logger_prefs_by_client_id;
create or replace public synonym logger_logs_5_min for logger_user.logger_logs_5_min;
create or replace public synonym logger_logs_60_min for logger_user.logger_logs_60_min;
create or replace public synonym logger_logs_terse for logger_user.logger_logs_terse;

SELECT * FROM LOGGER_LOGS
SELECT * FROM LOGGER_PREFS_BY_CLIENT_ID
SELECT * FROM LOGGER_PREFS
SELECT * FROM LOGGER_LOGS_APEX_ITEMS
SELECT * FROM LOGGER_LOGS_5_MIN
SELECT * FROM LOGGER_LOGS_60_MIN
SELECT * FROM LOGGER_LOGS_TERSE

##NO-OP Option for Production Environments To make sure there is no fear of leaving debug statements in production code, Logger comes with a NO-OP (No Operation) installation file (logger_no_op.sql). This installs only a shell of the Logger package. All procedures are essentially NO-OPs. It does not even create the tables so there is absolutely no chance it is doing any logging. It is recommended that you leave the full version installed and simply [set the Logger level](Logger API.md#procedure-set_level) to ERROR as the performance hit is exceptionally small.

##Objects The following database objects are installed with Logger:

OBJECT_TYPE         OBJECT_NAME
------------------- ------------------------------
JOB                 LOGGER_PURGE_JOB
                    LOGGER_UNSET_PREFS_BY_CLIENT
PACKAGE             LOGGER
PROCEDURE           LOGGER_CONFIGURE
SEQUENCE            LOGGER_APX_ITEMS_SEQ
                    LOGGER_LOGS_SEQ
TABLE               LOGGER_LOGS
                    LOGGER_LOGS_APEX_ITEMS
                    LOGGER_PREFS
                    LOGGER_PREFS_BY_CLIENT_ID
VIEW                LOGGER_LOGS_5_MIN
                    LOGGER_LOGS_60_MIN
                    LOGGER_LOGS_TERSE
LOGGER_GLOBAL_CTX   CONTEXT -- Global Application Contexts are owned by SYS

#Configuration

###Logger Levels They re various logger levels. To see the complete list, go to the [Constants](Logger API.md#constants) section in the Logger API.

###Enable To enable logging for the entire schema:

exec logger.set_level(logger.g_debug);

###Disable To disable logging:

exec logger.set_level(logger.g_off);
Instead of disabling all logging, setting the level to "ERROR" might be a better approach:

exec logger.set_level(logger.g_error);

set serveroutput on
exec logger.status

####APEX This option allows you to call logger.log_apex_items which grabs the names and values of all APEX items from the current session and stores them in the logger_logs_apex_items table. This is extremely useful in debugging APEX issues. This option is enabled automatically by logger_configure if APEX is installed in the database.


My Local Installation
sqlplus sys/oracle@xe as sysdba

@create_user.sql

sqlplus logger_user/logger_user@xe

logger.log should be used for all developer related content. This can really be anything and everything except for items that require additional investigation. In those situations use the other logging options. By default, Logger is configured to delete all debug level calls after 7 days.

logger.log_info[rmation] should be used for messages that need to be retained at a higher level than debug but are not actionable issues.

Information logging will vary in each organization but should fall between the rules for debug and warning. An example is to use it for a long running process to highlight some of the following items:

When did the process start
Major steps/milestones in the process
Number of rows processed
When did the process end

logger.log_warn[ing] should be used for non-critical system level / business logic issues that are actionable. If it is a critical issue than an error should be raised and logger.log_error should be called.

logger.log_error should be used when a PL/SQL error has occurred. In most cases this is in an exception block. Regardless of any other configuration, log_error will store the callstack. Errors are considered actionalble items as an error has occurred and something (code, configuration, server down, etc) needs attention.

logger.log_permanent should be used for messages that need to be permanently retained. logger.purge and logger.purge_all will not delete these messages regardless of the PURGE_MIN_LEVEL configuration option. Only an implicit delete to logger_logs will delete these messages.

create or replace package body pkg_example
as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  /**
   * TODO_Comments
   *
   * Notes:
   *  -
   *
   * Related Tickets:
   *  -
   *
   * @author TODO
   * @created TODO
   * @param TODO
   * @return TODO
   */
  procedure todo_proc_name(
    p_param1_todo in varchar2)
  as
    l_scope logger_logs.scope%type := gc_scope_prefix || 'todo_proc_name';
    l_params logger.tab_param;

  begin
    logger.append_param(l_params, 'p_param1_todo', p_param1_todo);
    logger.log('START', l_scope, null, l_params);

    ...
    -- All calls to logger should pass in the scope
    ...

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end todo_proc_name;

...

end pkg_example;


create or replace package demo_pkg 
is

procedure test (p_arg1   in      VARCHAR2
               ,p_arg2   in out  VARCHAR2
               ,p_arg3   out     VARCHAR2
              );

end demo_pkg;
/

create or replace package body demo_pkg
is

procedure test (p_arg1  in      varchar2
              ,p_arg2  in out  varchar2
              ,p_arg3  out     varchar2
              )
is
begin
    null;
end;

end demo_pkg;
/

https://github.com/tmuth/Logger---A-PL-SQL-Logging-Utility/blob/master/docs/Logger%20API.md

p_text maps to the TEXT column in LOGGER_LOGS. It can handle up to 32767 characters. If p_text exceeds 4000 characters its content will be moved appended to the EXTRA column. If you need to store large blocks of text (i.e. clobs) you can use the p_extra parameter.

p_scope is optional but highly recommend. The idea behind scope is to give some context to the log message, such as the application, package.procedure where it was called from. Logger captures the call stack, as well as module and action which are great for APEX logging as they are app number / page number. However, none of these options gives you a clean, consistent way to group messages. The p_scope parameter performs a lower() on the input and stores it in the SCOPE column.

When logging large (over 4000 characters) blocks of text, use the third parameter: p_extra. p_extra is a clob field and thus isnt restricted to the 4000 character limit.

p_params is for storing the parameters object. The goal of this parameter is to allow for a simple and consistent method to log the parameters to a given function. The values are explicitly converted to a string so there is no need to convert them when appending a parameter. The data from the parameters array will be appended to the EXTRA column. Since most production instances set the logging level to error, it is highly recommended that you leverage this 4th parameter when calling logger.log_error so that developers know the input that triggered the error.

logger.log_userenv(
  p_detail_level  in varchar2 default 'USER',-- ALL, NLS, USER, INSTANCE
  p_show_null     in boolean  default false,
  p_scope         in varchar2 default null)

exec logger.log_userenv('NLS');

exec logger.log_userenv('USER');

exec logger.log_cgi_env;

select extra from logger_logs where text like '%CGI%';

###LOG_APEX_ITEMS This feature is useful in debugging issues in an APEX application that are related session state. The developers toolbar in APEX provides a place to view session state, but it wont tell you the value of items midway through page rendering or right before and after an AJAX call to an application process.

logger.log_apex_items(
  p_text    in varchar2 default 'Log APEX Items',
  p_scope   in varchar2 default null);

select id,logger_level,text,module,action,client_identifier 
from logger_logs 
where logger_level = 128;
 
 ID     LOGGER_LEVEL TEXT                 MODULE                 ACTION    CLIENT_IDENTIFIER
------- ------------ -------------------- ---------------------- --------- --------------------
     47          128 Debug Edit Customer  APEX:APPLICATION 100   PAGE 7    ADMIN:45588554040361

select * 
from logger_logs_apex_items 
where log_id = 47; --log_id relates to logger_logs.id

logger.purge_all;

-- In Oracle Session-2 (i.e. a different session)
exec dbms_session.set_identifier('my_identifier');

-- This sets the logger level for current identifier
exec logger.set_level(logger.g_debug_name, sys_context('userenv','client_identifier'));

In APEX the client_identifier is

:APP_USER || ':' || :APP_SESSION 

declare
    l_number number;
begin
    logger.time_reset;
    logger.time_start('foo');
    logger.time_start('bar');
    for i in 1..500000 loop
        l_number := power(i,15);
        l_number := sqrt(1333);
    end loop; --i
    logger.time_stop('bar');
    for i in 1..500000 loop
        l_number := power(i,15);
        l_number := sqrt(1333);
    end loop; --i
    logger.time_stop('foo');
end;
/

select text from logger_logs_5_min;

TEXT
---------------------------------
START: foo
>  START: bar
>  STOP : bar - 1.000843 seconds
STOP : foo - 2.015953 seconds

##Logger Levels

Name	Description
g_off	Logger level off (0).
g_permanent	Logger level permanent (1).
g_error	Logger level error (2).
g_warning	Logger level warning (4).
g_information	Logger level information (8).
g_debug	Logger level debug (16).
g_timing	Logger level timing (32).
g_sys_context	Logger level sys context (64). This is applicable for logging system variables.
g_apex	Logger level apex (128).
g_off_name	Logger level name: OFF
g_permanent_name	Logger level name: PERMANENT
g_error_name	Logger level name: ERROR
g_warning_name	Logger level name: WARNING
g_information_name	Logger level name: INFORMATION
g_debug_name	Logger level name: DEBUG
g_timing_name	Logger level name: TIMING
g_sys_context_name	Logger level name: SYS_CONTEXT
g_apex_name	Logger level name: APEX

select
    sys_context('userenv','module'), 
    sys_context('userenv','action'),
    sys_context('userenv','client_identifier'),
    to_number(sys_context('userenv','sid')),
    sys_context('userenv','client_info')
from dual

exec DBMS_SESSION.set_identifier('MySession');

PLUG-IN

create or replace procedure log_test_plugin(
  p_rec in logger.rec_logger_log)
as
  l_text logger_logs.text%type;
begin
  dbms_output.put_line('In Plugin');
  dbms_output.put_line('p_rec.id: ' || p_rec.id);

  select text
  into l_text
  from logger_logs_5_min
  where id = p_rec.id;

  dbms_output.put_line('Text: ' || l_text);

end;
/

-- Register new plugin procedure for errors

update logger_prefs
set pref_value = 'log_test_plugin'
where 1=1
and pref_type = logger.g_pref_type_logger
and pref_name = 'PLUGIN_FN_ERROR';

-- Configure with Logger
exec logger_user.logger_configure;

set serveroutput on

exec logger.log_error('hello');

In Plugin
p_rec.id: 811
Text: hello

To deregister a plugin, set the appropriate logger_prefs.pref_value to null and re-run the logger_configure procedure. Note: since pref_value is not a nullable column, null values will be automatically converted to "NONE".

#Plugin Interface Plugins can either be standalone procedures or a procedure in a package. Plugins must implement the following interface:

procedure <name_of_procedure>(
  p_rec in logger.rec_logger_log)

insert into s_char_codes(code_type,code, active_ind) values ('ERROR_ALERT_MOBILE','07424333121','Y')

insert into s_char_codes(code_type,code, active_ind) values ('ERROR_ALERT_MOBILE','07424333121','Y')

commit;  

create or replace procedure send_sms_alert(
    p_rec in logger.rec_logger_log)
is
    l_text        logger_logs.text%type;
    l_unit_name   logger_logs.unit_name%type;
    l_scope       logger_logs.scope%type;

    l_clob        clob;
    l_str_sep     varchar2(5)  := '^^';
    l_dest_num    varchar2(15) :='0447424333121';
    l_orig_num    varchar2(15) :='RI Test';
    l_sms_text    varchar2(4000):='';
    l_pass        varchar2(15) :='dmbb0oz';
    l_uid        varchar2(15)  :='myapi';
    l_validity   varchar2(15)  :='1';
    l_rest_param varchar2(4000);
    l_rest_val   varchar2(4000);
begin

    select 
        text,
        unit_name,
        scope
    into 
        l_text,
        l_unit_name,
        l_scope
    from logger_logs_5_min
    where id = p_rec.id;

    l_sms_text   := substr('Failure::unit_name=' || l_unit_name ||', text='|| l_text ||',scope='||l_scope,1,160);
    l_rest_param := 'dest^^orig^^msg^^pass^^uid^^validity';
    l_rest_val   := l_dest_num || l_str_sep  ||
                    l_orig_num || l_str_sep  ||
                    l_sms_text || l_str_sep  ||
                    l_pass     || l_str_sep  ||
                    l_uid      || l_str_sep  ||
                    l_validity;
    
    l_clob := APEX_WEB_SERVICE.make_rest_request(
        p_url         => 'http://www.voodooSMS.com/vapi/server/sendSMS',
        p_http_method => 'GET',
        p_parm_name   => APEX_UTIL.string_to_table(l_rest_param, l_str_sep),
        p_parm_value  => APEX_UTIL.string_to_table(replace(replace(l_rest_val,chr(13)),chr(10)),   l_str_sep )
    );
    
    dbms_output.put_line(l_clob);
    
    /*
        l_clob := APEX_WEB_SERVICE.make_rest_request(
        p_url         => 'http://www.voodooSMS.com/vapi/server/sendSMS',
        p_http_method => 'GET',
        p_parm_name   => APEX_UTIL.string_to_table('dest:orig:msg:pass:uid:validity'),
        p_parm_value  => APEX_UTIL.string_to_table('0447424333121:Saroj Raut:Testing SMS API:dmbb0oz:myapi:1' )
        );
        dbms_output.put_line(l_clob);
    */
    
exception
    when others then
    dbms_output.put_line(sqlerrm);
end;
/

grant all on send_sms_alert to logger_user;

update logger_prefs
set pref_value = 'itsr.send_sms_alert'
where 1=1
and pref_type = 'LOGGER' --logger.g_pref_type_logger
and pref_name = 'PLUGIN_FN_ERROR';

-- Configure with Logger
exec logger_user.logger_configure;

set serveroutput on

exec logger.log_error('hello');

begin
    logger.log_error (
        p_text   => 'Error scenario created for testing',
        p_scope  => 'TESTING SCOPE',
        p_extra  => 'TEST'
        );
end;
/

set serveroutput on;
DECLARE
    l_vc_arr2    APEX_APPLICATION_GLOBAL.VC_ARR2;
    l_str_sep     varchar2(5)  := '^^';
    l_dest_num    varchar2(15) :='04474243331';
    l_orig_num    varchar2(15) :='RI Test';
    l_sms_text    varchar2(4000);
    l_pass        varchar2(15) :='dmbb0oz';
    l_uid        varchar2(15)  :='myapi';
    l_validity   varchar2(15)  :='1';
BEGIN
    l_sms_text := substr('Failure::unit_name=' || 'Test Unit' ||', text='|| 'Test Text' ||',scope='||'Test Scope',1,160);
    l_vc_arr2 := APEX_UTIL.string_to_table(l_dest_num  || l_str_sep  ||
                                                l_orig_num || l_str_sep  ||
                                                l_sms_text || l_str_sep  ||
                                                l_pass     || l_str_sep  ||
                                                l_uid      || l_str_sep  ||
                                                l_validity || l_str_sep,
                                                l_str_sep );
    FOR z IN 1..l_vc_arr2.count LOOP
        dbms_output.put_line(l_vc_arr2(z));
    END LOOP;
END;
/

declare
    l_text        logger_logs.text%type;
    l_unit_name   logger_logs.unit_name%type;
    l_scope       logger_logs.scope%type;
begin

  select 
    text,
    unit_name,
    scope
  into 
    l_text,
    l_unit_name,
    l_scope
  from logger_logs_5_min
  where id = p_rec.id;

  dbms_output.put_line('Text: ' || l_text);

end;
/

<?xml version="1.0" encoding="utf-8"?> <xml><result>200</result><resultText>200 OK</resultText><reference_id><item>ZY408R33PN16262705171</item></reference_id></xml>

%0A

It supports third party plug in.
You can define a custom procedure which can 

fa-exclamation-triangle

#F50C0C,#F50C0C,#F58C0C,#F58C0C

font-size:14px;

http://rlcmstd:8080/apex/f?p=expdiag

BEGIN

RAISE NO_DATA_FOUND;

EXCEPTION
    WHEN OTHERS
    THEN
        logger.log_warn (
            p_text   => 'Create Store Order - package initialization WARN',
            p_scope  => 'TEST_SSOPE',
            p_extra  => SQLERRM
            );
            
        logger.log_warning (
            p_text   => 'Create Store Order - package initialization WARNING',
            p_scope  => 'TEST_SSOPE',
            p_extra  => SQLERRM
            );
            
        logger.log_error (
            p_text   => 'Create Store Order - package initialization failure',
            p_scope  => 'TEST_SSOPE',
            p_extra  => SQLERRM
            );

        RAISE;
END;
/

Logger_logs Column Description

Line number shows line number from where message has been logged.
Call Stack : Shows the actual call stack, in case of error show error stack.
Scope : is the input value.
Unit_name : is the schema and object name from where message has been logged.
Extra : is the extra value is from p_params plus p_extra
sid : is the sid number
Module : is toad or sqlplus or java.exe for ORDS/APEX
Text : is from p_text plus sqlerrm if log_error.


Log an entry into the LOGGER_LOGS table when the logger_level is set to at least to g_debug
This procedure will log an entry into the LOGGER_LOGS table when the logger_level is set to information.
This procedure will log an entry into the LOGGER_LOGS table when the logger_level is set to warning.
This procedure will log an entry into the LOGGER_LOGS table when the logger_level is set to error.
This procedure will log an entry into the LOGGER_LOGS table when the logger_level is set to permanent.

exec tckt_request.p_tckt_extract();

select * from s_info_log;
select * from s_err_log;

select * from logger_logs;
select * from logger_logs_5_min;

UPDATE logger_prefs set pref_value='15' where pref_name='PURGE_AFTER_DAYS' -- Purges after PURGE_AFTER_DAYS. e.g with PURGE_AFTER_DAYS=1 purge job deletes all records where time_stamp < SYSDATE - 1

UPDATE logger_prefs set pref_value='ERROR' where pref_name='PURGE_MIN_LEVEL'

UPDATE logger_prefs set pref_value='FALSE' where pref_name='PROTECT_ADMIN_PROCS'

SELECT TRUNC(time_stamp), count(*) from logger_logs where logger_level <> 1 group by trunc(time_stamp) order by 1 

begin 
logger.purge; 
end; 
/

UPDATE logger_prefs set pref_value='FALSE' where pref_name='PROTECT_ADMIN_PROCS'

UPDATE logger_prefs set pref_value='ERROR' where pref_name='PURGE_MIN_LEVEL'

UPDATE logger_prefs set pref_value='15' where pref_name='PURGE_AFTER_DAYS'

UPDATE logger_prefs set pref_value='TRUE' where pref_name='PROTECT_ADMIN_PROCS'

SELECT * FROM LOGGER_PREFS

COMMIT

UPDATE logger_prefs set pref_value='ERROR' where pref_name='PURGE_MIN_LEVEL'

exec logger.set_level(logger.g_information);

