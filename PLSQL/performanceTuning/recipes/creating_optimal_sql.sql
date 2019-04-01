SQL/PLSQL is like any other programming language in that it can be coded well, coded poorly, and everywhere in between. Most database performance issues are
caused by poorly written SQL statements. Basic SQL coding fundamentals and some techniques to improve performance of
your SQL statements.

select SYS_CONTEXT('USERENV','sessionid') audsid,  sys_context('USERENV','SID') sid   from dual; --850269	401

select * from v$session where username='MYDBA'; --audsid=850269 and sid=401

select * from dba_sequences where sequence_name='AUDSES$'; --audsid comes from this sequence hence unique to some extent until wrapped around

alter session set sql_trace=true;

SELECT dbms_debug_jdwp.current_session_id sid, dbms_debug_jdwp.current_session_serial serial# -- Java Debug Wire Protocol
from dual;

exec dbms_monitor.session_trace_enable(session_id=>64,serial_num=>21713);


--* Avoid hard parsing
BEGIN
FOR i IN 100..206
LOOP
execute immediate 'UPDATE employees SET salary=salary*1.03 WHERE employee_id = ' || i;
END LOOP;
COMMIT;
END;

--Instead of using like above use like below, using cluas avoid hard parsing

BEGIN
FOR i IN 100..206
LOOP
execute immediate 'UPDATE employees SET salary=salary*1.03 WHERE employee_id = :empno' USING i;
END LOOP;
COMMIT;
END;


Inline subqueries and sub query factoring (with clause) uses PGA memory and temp tablespace for storing results. Be judicious in using these as these can potentially cause problem to the other comunity users.

--* Avoiding the NOT Clause, (not in, not like, !=)

department_id NOT IN(20,30) , this looks simple but if we convert this to an in clause mostlikely it will use the index and run faster

-- Monitor and analyze existing queries to help show why they may be underperforming, as well as show some steps to improve queries.

Was the query performance acceptable in the past?
Are there any metrics on how long the query has run when successful?
How much data is typically returned from the query?
When was the last time statistics were gathered on the objects referenced in the query?

At times, poorly running SQL can expose database configuration issues, but normally, poorly performing SQL queries occur due to poorly written SQL statements.
Over time, database characteristics change, more historical data may be stored for an application, and a query that performed well on initial install simply doesn’t scale as an application matures.

-- * Tracing
set autot on --set AUTOT[RACE] ON - Query executed, plan shown and stats shown
set autot on exp --same as set AUTOT[RACE] ON EXP[LAIN]- Query executed and only plan shown (and stats not shown)
set autot on stat--same as set AUTOT[RACE] ON STAT[ISTICS] Query executed and only stats shown (and plan not shown)
set autot trace -- same as set autot[race] trace[only], query executed but result suppressed, plan and stats shown
set autot trace exp -- same as set autot[race] trace[only] exp[lain], only plan shown without executing and without stats

SELECT * FROM table(dbms_xplan.display); -- same as SELECT * FROM table(dbms_xplan.display(null,null,'TYPICAL'));
SELECT * FROM table(dbms_xplan.display(null,null,'BASIC')); -- only shows id operation and object
SELECT * FROM table(dbms_xplan.display(null,null,'ALL')); -- includes alias, projection and remote 
SELECT * FROM table(dbms_xplan.display(null,null,'TYPICAL -BYTES -ROWS'));

-- Reading an Execution Plan
innermost or most indented steps are executed first and are executed from the inside out, in top-down order

when determining if you have an efficient plan:
• What is the access path for the query (is the query performing a full table scan or is the query using an index)?
• What is the join method for the query (if a join condition is present)?
• Look at the columns within the filtering criteria found within the WHERE clause of the query. What is the cardinality of these columns? Are the columns indexed?
• Get the volume or number of rows for each table in the query. Are the tables small, medium-sized, or large? This may help you determine the most appropriate join method.
• When were statistics last gathered for the objects involved in the query?
• Look at the COST column of the explain plan to get a starting cost.

Hash : Most appropriate if at least one table involved in the query returns a large result set
Nested loop : Appropriate for smaller tables
Sort merge : Appropriate for pre-sorted data
Cartesian Signifies either no join condition or a missing join condition; usually signifies an unwanted condition and query needs to be scrutinized to ensure there is a join condition for each and every table in the query

--* Monitoring Long-Running SQL Statements
SELECT 
    username, 
    target, 
    sofar blocks_read, 
    totalwork total_blocks,
round(time_remaining/60) minutes
FROM v$session_longops
WHERE sofar <> totalwork
and username = 'HR';

--* Identifying Resource-Consuming SQL Statements That Are Currently Executing

SELECT 
    sql_text, 
    buffer_gets, 
    disk_reads, 
    sorts,
    cpu_time/1000000 cpu, 
    rows_processed, 
    elapsed_time
FROM v$sqlstats
--ORDER BY disk_reads or elapsed_time DESC

--* Seeing Execution Statistics for Currently Running SQL
SELECT 
    sid, 
    buffer_gets, 
    disk_reads, 
    round(cpu_time/1000000,1) cpu_seconds
FROM v$sql_monitor
WHERE SID=100
AND status = 'EXECUTING';

SQL statements are monitored in V$SQL_MONITOR under the following conditions:
• Automatically for any parallelized statements
• Automatically for any DML or DDL statements
• Automatically if a particular SQL statement has consumed at least 5 seconds of CPU or I/O time
• Monitored for any SQL statement that has monitoring set at the statement level

Keep in mind that if a statement is running in parallel, one row will appear for each parallel thread for the query, including one for the query coordinator. However, they will share the same SQL_ID, SQL_EXEC_START, and SQL_EXEC_ID values.

-- *Monitoring Progress of a SQL Execution Plan
select name,value from v$diag_info where name='Diag Trace'

alter session set events 'sql_trace level 12';
alter session set events 'sql_trace off';

alter session set events 'sql_trace [sql:fb2yu0p1kgvhr] level 12';
alter session set events 'sql_trace[sql:fb2yu0p1kgvhr] off';


-- *Enabling Tracing in Your Own Session

execute dbms_session.session_trace_enable(waits=>true, binds=> false);
execute dbms_session.session_trace_disable();

alter session set tracefile_identifier='MyTune1';

select value from v$diag_info where name = 'Default Trace File';

tkprof user_sql_001.trc user1.prf explain=hr/hr table=hr.temp_plan_table_a sys=no sort=exeela,prsela,fchela

input file is user_sql_001.trc and output file is user1.prf, sort: By default, TKPROF lists the SQL statements in the trace file in the order they were executed. You can specify various options with the sort argument to control the order

• prscpu: CPU time spent parsing
• prsela: Elapsed time spent parsing
• execpu: CPU time spent executing
• exeela: Elapsed time spent executing
• fchela: Elapsed time spent fetching

explain: Writes execution plans to the output file; TKPROF connects to the database and issues explain plan statements using the username and password you provide with this parameter.

table: By default, TKPROF uses a table named PLAN_TABLE in the schema of the user specified by the explain parameter, to store the execution plans. You can specify an alternate table with the table parameter.

--* Analyzing TKPROF Output
********************************************************************************
count    = number of times OCI procedure was executed
cpu      = cpu time in seconds executing 
elapsed  = elapsed time in seconds executing
disk     = number of physical reads of buffers from disk
query    = number of buffers gotten for consistent read
current  = number of buffers gotten in current mode (usually for update)
rows     = number of rows processed by the fetch or execute call
********************************************************************************

 SELECT COUNT(*)
 FROM   dual

call    count    cpu elapsed    disk   query current     rows
------- -----  ----- ------- ------- ------- -------  -------
Parse       1   0.02    0.02       0       0       0        0
Execute     1   0.00    0.00       0       0       0        0
Fetch       2   0.00    0.00       0       1       4        1
------- -----  ----- ------- ------- ------- -------  -------
total       4   0.02    0.02       0       1       4        1

count: The number of times the database parsed, executed, or fetched this statement
cpu: The CPU time used for the parse/execute/fetch phases elapsed: Total elapsed time (in seconds) for the parse/execute/fetch phases
disk: Number of physical block reads for the parse/execute/fetch phases
query: Number of data blocks read with logical reads from the buffer cache in consistent mode for the parse/fetch/execute phases (for a select statement)
current: Number of data blocks read and retrieved with logical reads from the buffer cache in current mode (for insert, update, delete, and merge statements)
rows: Number of fetched rows for a select statement or the number of rows inserted, deleted, or updated, respectively, for an insert, delete, update, or merge statement

--* Tracing a SQL Session
execute dbms_monitor.session_trace_enable(session_id=>138,serial_num=>242, waits=>true,binds=>false);
execute dbms_monitor.session_trace_disable(138,242);

To trace the current user session, use the following pair of commands:
execute dbms_monitor.session_trace_enable();
execute dbms_monitor.session_trace_disable();

alter session set events '10046 trace name context forever, level 12' and execute dbms_monitor.session_trace_enable(session_id=>99,serial_num=>88,waits=>true,binds=>true); , both does the same thing generate identical tracing information, called extended tracing because the trace includes wait and bind variable data.


-- * HInts
SELECT /*+ ordered */ ename, dname FROM emp JOIN dept USING(deptno);

As with the example using the ORDERED hint, you have the same control to specify the join order of the query. The difference with the LEADING hint is that you specify the join order from within the hint itself, while with the ORDERED hint, it is specified in the FROM clause of the query. Here’s an example:
SELECT /*+ leading(emp dept) */ ename, dname FROM emp JOIN dept USING(deptno);
SELECT /*+ use_nl(emp dept) */ ename, dname FROM emp JOIN dept USING (deptno);
SELECT /*+ use_hash(emp_all dept) */ ename, dname FROM emp_all JOIN dept USING (deptno);