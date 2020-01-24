An application context is a set of name-value pairs that Oracle Database stores in memory.
The context has a label called a namespace (for example, empno_ctx for an application context that retrieves employee IDs).
Inside the context are the name-value pairs (an associative array): the name points to a location in memory that holds the value. An application can use the application context to access session information about a user, such as the user ID or other user-specific information, or a client ID, and then securely pass this data to the database.

There are three general categories of application contexts.
Database session-based application contexts.
Client session-based application contexts.
Global application contexts. - A global application context is useful if the session context must be shared across sessions. You can use a global application context to access application values across database sessions. Oracle Database initializes the global application context once, rather than for each user session. This improves performance, because connections are reused from a connection pool.
You can clear a global application context value by running the ALTER SYSTEM FLUSH GLOBAL_CONTEXT SQL statement.

Components of a Global Application Context
The global application context : You use the CREATE CONTEXT SQL statement to create the global application context, and include the ACCESSED GLOBALLY clause in the statement. This statement names the application context and associates it with a PL/SQL procedure that is designed to set the application data context data. 
A PL/SQL package to set the attributes : The package must contain a procedure that uses the DBMS_SESSION.SET_CONTEXT procedure to set the global application context. 
A middle-tier application to get and set the client session ID. 

create or replace context global_test_context using test_package accessed globally;

create or replace package test_package 
as  
    procedure set_test_context(
        i_attribute_name   in varchar2
        ,l_attribute_value in varchar2); 
        
    procedure clear_test_context(
        i_attribute_name   in varchar2
        ,l_attribute_value in varchar2);
end;  
/

create or replace package body test_package 
as                                            
    procedure set_test_context(
        i_attribute_name   in varchar2
        ,l_attribute_value in varchar2)      
    as   
    begin  
        dbms_session.set_context(  
            namespace  => 'global_test_context', 
            attribute  => i_attribute_name, 
            value      => l_attribute_value);
    end set_test_context;
    
    procedure clear_test_context(  
        i_attribute_name   in varchar2
        ,l_attribute_value in varchar2) 
    as
    begin  
        dbms_session.clear_context(i_attribute_name, l_attribute_value); 
    end clear_test_context;  
end test_package; 
/

begin
    test_package.set_test_context('auth_id','Sample ID');
    test_package.set_test_context('auth_token','Sample Token');
end;
/

--
-- Following block will throw error ORA-01031: insufficient privileges 
--
begin
    dbms_session.set_context(  
        namespace  => 'global_test_context', 
        attribute  => 'Sample ID', 
        value      => 'Sample Token');
end;
/


--
-- Fetching the context from the same session is not working 
-- working from all other sessions don't know why
-- Log out/in is not needed for other sessions
-- works fine from active sessions
--

select 
    sys_context('global_test_context', 'auth_id')     auth_id 
    ,sys_context('global_test_context', 'auth_token') auth_token
from dual;

--
-- Atribute names are case insensitive
--
select 
    sys_context('global_test_context', 'AUTH_ID')     auth_id 
    ,sys_context('global_test_context', 'AUTH_TOKEN') auth_token
from dual;


TYPE AppCtxRecTyp IS RECORD ( 
   namespace VARCHAR2(30), 
   attribute VARCHAR2(30),
   value     VARCHAR2(256)); 

TYPE AppCtxTabTyp IS TABLE OF AppCtxRecTyp INDEX BY BINARY_INTEGER; 

DBMS_SESSION.LIST_CONTEXT ( 
   list OUT AppCtxTabTyp, 
   size OUT NUMBER);

set serveroutput on;
declare
    l_AppCtxTab DBMS_SESSION.AppCtxTabTyp;
    l_size      number;
begin
    DBMS_SESSION.LIST_CONTEXT( l_AppCtxTab, l_size);
    dbms_output.put_line(nvl(l_AppCtxTab.count,0));
    for i in 1..l_size loop
        dbms_output.put_line(l_AppCtxTab(i).namespace||'--'||l_AppCtxTab(i).attribute||'--'||l_AppCtxTab(i).value);
    end loop;
end;
/
