You can control the behavior of the server query cache by setting three initialization parameters: RESULT_CACHE_MAX_SIZE, RESULT_CACHE_MAX_RESULT, and RESULT_CACHE_REMOTE_EXPIRATION. For example, you can use the following set of values for the three server result cache–related initialization parameters:
RESULT_CACHE_MAX_SIZE=500M           /* Megabytes , maximum SGA memory that the cache can use*/
RESULT_CACHE_MAX_RESULT=20           /* Percentage, maximum percentage of the cache a single result can use*/
RESULT_CACHE_REMOTE_EXPIRATION=3600  /* Minutes*/

alter session set result_cache_mode=force; -- By setting this atabase caches all query results unless you specify the /*+ NO_RESULT_CACHE */ hint to exclude a query’s results from the cache. The default (and the recommended) value of this parameter is MANUAL,
select name, value from v$parameter where name='result_cache_mode';

execute dbms_result_cache.flush

select dbms_result_cache.status() from dual; -- check the status of the server result cache by using the DBMS_RESULT_CACHE package.

--You can view a query’s explain plan to check whether a query is indeed using the SQL query cache,
select /*+ RESULT_CACHE */ department_id, AVG(salary)
from hr.employees
group by department_id;

-- you can also view the report
set serveroutput on
execute dbms_result_cache.memory_report

-- You can monitor the server result cache statistics by executing the following query:
select name, value from V$RESULT_CACHE_STATISTICS;

Here are the rules that Oracle uses for deciding what percentage of the shared pool it allocates to the server result cache:
• If you’re using automatic memory management by setting the MEMORY_TARGET parameter, Oracle allocates 0.25 percent of the MEMORY_TARGET parameter’s value to the server result cache.
• If you’re using automatic shared memory management with the SGA_TARGET parameter, the allocation is 0.5 percent of the SGA_TARGET parameter.
• If you’re using manual memory management by setting the SHARED_POOL_SIZE parameter, the allocation is 1 percent of the SHARED_POOL_SIZE parameter.

SQL> create table stores (...) RESULT_CACHE (MODE DEFAULT);
SQL> alter table stores RESULT_CACHE (MODE FORCE);

In addition to the read consistency requirements for result caching, the following objects or functions, when present in a query, make that query ineligible for caching:
• CURRVAL and NEXTVAL pseudocolumns
• CURRENT_DATE, CURRENT_TIMESTAMP, USERENV_CONTEXT, SYS_CONTEXT (with nonconstant variables), SYSDATE, and SYS_TIMESTAMP
• Temporary tables
• Tables owned by SYS and SYSTEM

-- * Caching PL/SQL Function Results
--You must specify the RESULT_CACHE clause inside a function to make the database cache the function’s results in the PL/SQL function  result cache.

create or replace package store_pkg is
type store_sales_record is record (
    store_name  stores.store_name%TYPE,
    mgr_name    employees.last_name%type,
    store_size  PLS_INTEGER
    );
function get_store_info (store_id PLS_INTEGER)
RETURN store_info_record
RESULT_CACHE;
END store_pkg;
/

create or replace package body store_pkg is
FUNCTION get_store_sales (store_id PLS_INTEGER)
RETURN store_sales_record
RESULT_CACHE RELIES_ON (stores, employees)
IS
..
-- RESULT_CACHE RELIES ON clause in the function body is optional, What this means is that whenever these tables change, the database invalidates all the cached results for the get_store_info function.


--when you hot-patch (recompile) the package store_pkg, Oracle technically must flush the cached results associated with the get_store_info function. However, Oracle doesn’t automatically flush the cached results associated with the result cache function, so you must manually flush them.

1.Place the result cache in the bypass mode: SQL> execute DBMS_RESULT_CACHE.bypass(true);
2.Clear the cache with the flush procedure: SQL> execute DBMS_RESULT_CACHE.flush;
3.Recompile the package that contains the cache-enabled function: SQL> alter package store_pkg compile;
4.Reenable the result cache with the bypass procedure: SQL> execute DBMS_RESULT_CACHE.bypass(false);

-- While a PL/SQL function cache gets you results much faster than repetitive execution of a function, PL/SQL collections (arrays)–based processing could be even faster because the PL/SQL runtime engine gets the results from the collection cache based in the PGA rather than the SGA. However, since this requires additional PGA memory for each session, you’ll have problems with the collections approach as the number of sessions grows large.

Restrictions on the PL/SQL Function Cache
For its results to be cached, a function must satisfy the following requirements:
• The function doesn’t use an OUT or IN OUT parameter.
• No IN parameter of a function has one of these types: BLOB, CLOB, NCLOB, REF CURSOR, Collection Object, and Record.
• The function isn’t a pipelined table function.
• The function isn’t part of an anonymous block.
• The function isn’t part of any module that uses invoker’s rights as opposed to definer’s rights.
• The function’s return type doesn’t include the following types: BLOB, CLOB, NCLOB, REF CURSOR, Object, Record, or a PL/SQL collection that contains one of the preceding unsupported return types.

