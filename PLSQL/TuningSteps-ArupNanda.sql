-------------Quick Notes
exec DBMS_SESSION.SET_IDENTIFIER('this is a test');
exec DBMS_MONITOR.CLIENT_ID_TRACE_ENABLE('this is a test',true,true);
select TRACE_TYPE,PRIMARY_ID,WAITS,BINDS,PLAN_STATS from dba_enabled_traces;
exec DBMS_MONITOR.CLIENT_ID_TRACE_DISABLE('this is a test');

begin
  dbms_monitor.session_trace_enable (
    session_id => <SID>, 
    serial_num => <serial#>, 
    waits      => true, 
    binds      => true
    plan_stat  => 'all_executions');
end;

ALTER SESSION SET sql_trace=TRUE;

set autotrace traceonly explain
autotrace on explain 


select
   r.value                                ||'\diag\rdbms\ '||
   sys_context('USERENV','DB_NAME')       ||'\ '||
   sys_context('USERENV','INSTANCE_NAME') ||'\trace\ '||
   sys_context('USERENV','DB_NAME')       ||'_ora_'||p.spid||'.trc'
   as tracefile_name
from v$session s, v$parameter r, v$process p
where r.name = 'diagnostic_dest'
and s.sid = &1
and p.addr = s.paddr;

--12
SELECT trace_filename
FROM   v$diag_trace_file
WHERE  con_id = 3;

SELECT p.tracefile
FROM   v$session s
       JOIN v$process p ON s.paddr = p.addr
WHERE  s.sid = 635;


tkprof ann1_ora_11408.trc ann1_ora_11408.out sys=no waits=yes  aggregate=no width=180

 v$active_session_history
 dba_hist_active_sess_history

exec dbms_stats.gather_table_stats( user, 'T' );

select * from table( dbms_xplan.display_cursor( format=> 'allstats last' ))

Standard Technique

ANALYZE INDEX index_name VALIDATE STRUCTURE;
SELECT HEIGHT, DEL_LF_ROWS, LF_ROWS, LF_BLKS FROM INDEX_STATS;
If the value for DEL_LF_ROWS/LF_ROWS is greater than 2, or LF_ROWS is lower than LF_BLKS, or HEIGHT is 4 then the index should be rebuilt.

Maximizing Data Loading Speeds > /*+ APPEND */ /*+ APPEND_VALUES */ CTAS - Direct path insert reduces redo and by passes buffer cache.
Efficiently Removing Table Data > truncate all space is deallocated expect minextent, you can retain the storage by using REUSE STORAGE clause.
If lots of data has been deleted from table then large amounts of unused space causes full table scan queries to perform poorly. This is because Oracle is scanning every block beneath the high-water mark, regardless of whether the blocks contain data.
alter table inv enable row movement;
alter table inv shrink space cascade;

Row chaining > analyze table emp list chained rows;

create table temp_emp
as select *
from emp
where rowid in
(select head_rowid from chained_rows where table_name = 'EMP');

delete from emp
where rowid in
(select head_rowid from chained_rows where table_name = 'EMP');

insert into emp select * from temp_emp;

alternate option is alter table emp move; and rebuild all the indexes.

Index rebuild because of deleted rows.

If any process is consuming majro portion of CPU or Memory find out the process details

consider the option  of reduce context switch using forall bulk binding, insertall instead of individual inserts, merge instead of separate insert update, doing it in sql way if possible, analytic queries, pivoting/unpivoting 

ps -aef|grep 5946

select sid
from v$session s, v$process p
where p.spid = 5946
and s.paddr = p.addr;

call     count   cpu elapsed disk      query    current         rows
------- ------  ------ ---------- -- ---------- ----------   --------
Parse        1  0.00   0.00   0          0          0            0
Execute      1  0.00   0.00   0          0          0            0
Fetch    17322  1.82   1.85   3        136          5       259806
------- ------  -------- -------- -- ---------- ---------- ----------
total    17324  1.82   1.85   3        136          5       259806

Various tools like EXPLAIN PLAN, Using Autotrace, TKPROF, TOP, VMSTAT, MEMSTAT, can give fair amount of indication about what could be the problem. Once you understand where the time is being spent then you can take remedy action.

-------------
First you have to understand that the database itself is never slow or fast�it has a constant speed. The sessions connected to the database, however, slow down when they hit a bump in the road. To resolve a session performance issue, you need to identify the bump and remove it.

In my experience, the vast majority of poorly performing execution plans can be because of two reasons >
1. Optimizer may not have sufficient information to correctly estimate cardinalities (estimated row counts) -> dbms_stats.create_extended_stats(null,'customers', '(cust_state_province,country_id)');
2. Optimiser does understand the data distribution. -> 
 By adding the FOR COLUMNS clause, you can have the database create the new column group as well as collect statistics for it, all in one step, as shown here:
exec dbms_Stats.gather_table_stats(
     ownname=>null,-
     tabname=>'customers',-
     method_opt=>'for all columns size skewonly,-
     for columns (cust_state_province,country_id) size skewonly');
     
exec dbms_stats.gather_table_stats(null,'customers',
     method_opt=>'for all columns size skewonly,
     for columns (lower(cust_state_province)) size skewonly');

Some are related to
Contention related to poorly written logic
Table locking
Unresonable Undo and Redo requirement
CPU overloaded
Memory Overloaded

Monitoring the session in v$session and getting more information about the problem

1. What is the query?
2. What is the execution plan.
3. What is the state of the session during most of the time of execution(idle, processing or waiting)
4. If the session is waiting then how long the session has been waiting(seconds_in_wait is curren wait and wait_time is last wait time, wait_time is in centi second), A very long wait usually indicates some sort of bottleneck. 
5. if it is waiting then retrive more information on the event it is waiting (event column of v$session) "enq: TX - row lock contention" or "db file sequential read" on DML lock identify the object name and row number. if you see event "db file sequential read" then you know that the session is waiting for I/O from the disk to complete. To make the session go faster, you have to reduce that waiting period. There are several ways to reduce the wait one of the simple option is moving the data object to a faster disk or tune the query to do reduce the I/O required. for finding the data object refer the P1 and P2 column which shows the object id and segment id.
If the wait event is "enq: TX - row lock contention" then find out the exact object and row (dbms_rowid.rowid_create) which is locked and by which session.
6. if session is idle then it is not a database problem, may be the application server or ETL server is causing the delay.
7. Is the number of block I/O required is higher compared to the number of rows fetched, then may be rows are chained and rebuilding the table or index might be the solution.
8. OS level CPU/Memory spike is observed during the query running? May be because of rapid switching of logs, 
9. Read consistency is causing the problem?
10. Is the index fragmented because of vast DML poeration? If the value for DEL_LF_ROWS/LF_ROWS is greater than 2, or LF_ROWS is lower than LF_BLKS, or HEIGHT is 4 then the index should be rebuilt.
12. Is the problem is with insert query during vast number of record inserttion, use of APEND hint direct path load, nologging might be the solution?
13. is the problem is during deleting major portion of rows from a table, then truncate and insert from tem table can be the solution? or partitioning to enble fast data purgning using partition drop might be the solution.
14. is it causing a full table scan and should we create a new index, what type of index, normal btree, bitmap, bitmap joined, reverse key, function based. 
15. Should we use a GTT or IOT


The various operations (for example, joins) to be performed during the query
The order in which the operations are performed
The algorithm to be used for performing each operation
The best way to retrieve data from disk or memory
The best way to pass data from one operation to another during the query


Various tools like EXPLAIN PLAN, Using Autotrace, TKPROF, TOP, VMSTAT, MEMSTAT, can give fair amount of indication about what could be the problem. Once you understand where the time is being spent then you can take remedy action.

Select best Joining mathod

Nested Loops
If you're joining small subsets of data, the nested loop (NL) method is ideal. If you're returning fewer than, say, 10,000 rows, the NL join may be the right join method. If the optimizer is using hash joins or full table scans, force it to use the NL join method by using the following hint:
SELECT /*+ USE_NL (TableA, TableB) */

Hash Join
If the join will produce large subsets of data or a substantial proportion of a table is going to be joined, use the hash join hint if the optimizer indicates it isnt going to use it:
SELECT /* USE_HASH */

Merge Join
If the tables in the join are being joined with an inequality condition (not an equi join), the merge join method is ideal:
SELECT /*+ USE_MERGE (TableA, TableB) */

Although wait events are great for helping with understanding the speed bumps the sessions experience, they do not show another important attribute of sessions: the use of resources such as CPU, I/O, and memory.  TOP command

Caching Small Tables in Memory

Histograms

call     count   cpu elapsed disk      query    current         rows
------- ------  ------ ---------- -- ---------- ----------   --------
Parse        1  0.00   0.00   0          0          0            0
Execute      1  0.00   0.00   0          0          0            0
Fetch    17322  1.82   1.85   3        136          5       259806
------- ------  -------- -------- -- ---------- ---------- ----------
total    17324  1.82   1.85   3        136          5       259806



If any process is consuming majro portion of CPU or Memory find out the process details

ps -aef|grep 5946

select sid
from v$session s, v$process p
where p.spid = 5946
and s.paddr = p.addr;

Redo Spike

Occasionally you may have a performance issue that will not appear as clearly at the OS level as CPU and memory consumption. One such case is redo generation by the database instance, which, in turn, increases both the rapid switching of redo logs and the creation rate and number of archived logs. This may cause an increase in overall I/O on file systems, causing a systemwide performance issue.

Looking at performance issues in old sessions is easy with an Oracle Database feature called Active Session History - V$ACTIVE_SESSION_HISTORY , You need to query this view based on user name and time period

Row chaining > analyze table emp list chained rows;

create table temp_emp
as select *
from emp
where rowid in
(select head_rowid from chained_rows where table_name = 'EMP');

delete from emp
where rowid in
(select head_rowid from chained_rows where table_name = 'EMP');

insert into emp select * from temp_emp;

alternate option is alter table emp move; and rebuild all the indexes.

Index rebuild because of deleted rows.

ANALYZE INDEX index_name VALIDATE STRUCTURE;
SELECT HEIGHT, DEL_LF_ROWS, LF_ROWS, LF_BLKS FROM INDEX_STATS;
If the value for DEL_LF_ROWS/LF_ROWS is greater than 2, or LF_ROWS is lower than LF_BLKS, or HEIGHT is 4 then the index should be rebuilt.

Maximizing Data Loading Speeds > /*+ APPEND */ /*+ APPEND_VALUES */ CTAS - Direct path insert reduces redo and by passes buffer cache.
Efficiently Removing Table Data > truncate all space is deallocated expect minextent, you can retain the storage by using REUSE STORAGE clause.
If lots of data has been deleted from table then large amounts of unused space causes full table scan queries to perform poorly. This is because Oracle is scanning every block beneath the high-water mark, regardless of whether the blocks contain data.
alter table inv enable row movement;
alter table inv shrink space cascade;

Avoiding Concentrated I/O for Index > reverse key index

VMSTAT > wa (waiting for IO), b(sleeping processes), SO(memory swapped to disk) are big numbers then IO/CPU/Memory contention respectively.
TOP > which process is consuming more CPU.
df -h > if any file system is full

Partitioning
Materialised View

Hints

Types of Hints : Hints can be of the following general types:

�Single-table : Single-table hints are specified on one table or view. INDEX and USE_NL are examples of single-table hints.
�Multi-table : LEADING is an example of a multi-table hint. Note that USE_NL(table1 table2) is not considered a multi-table hint because it is actually a shortcut for USE_NL(table1) and USE_NL(table2).
�Query block : Query block hints operate on single query blocks. STAR_TRANSFORMATION and UNNEST are examples of query block hints.
�Statement : Statement hints apply to the entire SQL statement. ALL_ROWS is an example of a statement hint.

Hints by Category : Optimizer hints are grouped into the following categories:

�Hints for Optimization Approaches and Goals : ALL_ROWS, FIRST_ROWS(N)
�Hints for Access Paths : FULL, HASH, INDEX, NO_INDEX, INDEX_FFS, NO_INDEX_FFS, 
�Hints for Query Transformations : �NO_QUERY_TRANSFORMATION, STAR_TRANSFORMATION, NO_STAR_TRANSFORMATION, FACT, NO_FACT, UNNEST
�Hints for Join Orders : LEADING, ORDERED, 
�Hints for Join Operations : USE_NL, NO_USE_NL, USE_HASH, NO_USE_HASH, USE_MERGE, NO_USE_MERGE
�Hints for Parallel Execution : PARALLEL, NO_PARALLEL
�Additional Hints : APPEND, PUSH_PRED, NO_PUSH_PRED, DRIVING_SITE

The ALL_ROWS hint instructs the optimizer to optimize a statement block with a goal of best throughput�that is, minimum total resource consumption.
The FIRST_ROWS hint instructs Oracle to optimize an individual SQL statement for fast response, choosing the plan that returns the first n rows most efficiently. For integer, specify the number of rows to return. /*+ FIRST_ROWS(10) */
The APPEND hint instructs the optimizer to use direct-path INSERT if your database is running in serial mode.
The CACHE hint instructs the optimizer to place the blocks retrieved for the table at the most recently used end of the LRU list in the buffer cache when a full table scan is performed. This hint is useful for small lookup tables.
The FULL hint instructs the optimizer to perform a full table scan for the specified table.  /*+ FULL(E) */
The INDEX hint instructs the optimizer to use an index scan for the specified table. /*+ INDEX (employees emp_department_ix)*/ /*+ NO_INDEX(employees emp_empid) */
Influencing the Optimizer with Initialization Parameters
The LEADING hint instructs the optimizer to use the specified set of tables as the prefix in the execution plan. This hint is more versatile than the ORDERED hint.
SELECT /*+ LEADING(e j) */ *
FROM employees e, departments d, job_history j
WHERE e.department_id = d.department_id
  AND e.hire_date = j.start_date;
If you specify the ORDERED hint, it overrides all LEADING hints.

The MERGE hint lets you merge views in a query. When the MERGE hint is used without an argument, it should be placed in the view query block. When MERGE is used with the view name as an argument, it should be placed in the surrounding query.

SELECT /*+ MERGE(v) */ e1.last_name, e1.salary, v.avg_salary
   FROM employees e1,
   (SELECT department_id, avg(salary) avg_salary 
      FROM employees e2
      GROUP BY department_id) v 
   WHERE e1.department_id = v.department_id AND e1.salary > v.avg_salary;
   
The NO_QUERY_TRANSFORMATION hint instructs the optimizer to skip all query transformations, including but not limited to OR-expansion, view merging, subquery unnesting, star transformation, and materialized view rewrite. For example:

The NO_USE_HASH hint instructs the optimizer to exclude hash joins when joining each specified table to another row source using the specified table as the inner table.  /*+ NO_USE_HASH(e d) */
The NO_USE_NL hint instructs the optimizer to exclude nested loops joins when joining each specified table to another row source using the specified table as the inner table. /*+ NO_USE_NL(l h) */ 
The ORDERED hint instructs Oracle to join tables in the order in which they appear in the FROM clause. Oracle recommends that you use the LEADING hint, which is more versatile than the ORDERED hint.
/*+ FULL(hr_emp) PARALLEL(hr_emp, 5) */
/*+ FULL(hr_emp) PARALLEL(hr_emp, DEFAULT) */ 
-- Specifying DEFAULT or no value signifies that the query coordinator should examine the settings of the initialization parameters to determine the default degree of parallelism.
The STAR_TRANSFORMATION hint instructs the optimizer to use the best plan in which the transformation has been used. /*+ STAR_TRANSFORMATION */


---- Blog POST
SELECT...
FROM    tab1, tab2, tab3, tab4
WHERE
        tab1.id = tab3.id
AND     tab3.id = tab2.id
AND     tab2.id = tab4.id
AND     {filter clauses};
;

How could I force the optimizer to first join TAB1 and TAB3 with a nested loop, then join this result to TAB2 using a hash etc etc. ??

For the general case I�m not sure if there is always a solution; but for this particular example, Oracle 10g makes it particularly easy to express:

/*+
        leading (tab1, tab3, tab2, tab4)
        use_nl(tab3)
        use_hash(tab2) swap_join_inputs(tab2)
        use_nl(tab4)
*/
 
The leading() hint allows you to specify the join order, and the use_nl(tab3) ensures we get a nested loop from tab1 to tab3. We then have to join to t2 because of the leading() hint, but the  swap_join_inputs() would make tab2 the build (first) table and the intermediate result the probe (second) table in the hash join. Finally we specify a nested loop for the join to tab4. (For 9i, just change the leading() hint to an ordered() hint, in this case, and swap the order of tab2 and tab3 in the from clause))

-----------------
First you have to understand that the database itself is never slow or fast�it has a constant speed. The sessions connected to the database, however, slow down when they hit a bump in the road. To resolve a session performance issue, you need to identify the bump and remove it.

An Oracle Database session is always in one of three states: 

Idle. Not doing anything�just waiting to be given some work.
Processing. Doing something useful�running on the CPU.
Waiting. Waiting for something, such as a block to come from disk or a lock to be released.

select sid, state, event
from v$session 
where username = 'XXX'; 

SID   STATE              EVENT
����� �����������������  ����������������������������
2832  WAITED KNOWN TIME  SQL*Net message from client
3346  WAITING            enq: TX - row lock contention

You must look at the STATE column first to determine whether the session is waiting or working and then inspect the EVENT column.

After you determine that a session is waiting for something, the next thing you need to find out is how long the session has been waiting. A very long wait usually indicates some sort of bottleneck. 

Query for displaying sessions, session state, and wait details
 
col "Description" format a50
select sid,
        decode(state, 'WAITING','Waiting',
                'Working') state,
        decode(state,
                'WAITING',
                'So far '||seconds_in_wait,
                'Last waited '||
                wait_time/100)||
        ' secs for '||event
        "Description"
from v$session
where username = 'ARUP';

Output:

 
SID   STATE       Description
����� ����������  �������������������������������������������������������
2832  Working     Last waited 2029 secs for SQL*Net message from client
3346  Waiting     So far 743 secs for enq: TX - row lock contention
4208  Waiting     So far 5498 secs for SQL*Net message from client

Note : wait_time column contains in centi second [hundredths of a second].
Note that an idle session does not show IDLE as the STATE column value; it still shows �Waiting.� You have to check the EVENT column to determine whether the session is truly idle. e.g �SQL*Net message from client� and �rdbms ipc message� idle events.

Session 4208 is idle, so any complaints that session 4208 is slow just aren�t related to the database. Any performance issues related to this session could be related to a bug in the code that�s going through an infinite loop or high CPU consumption on the application server. You can redirect the performance troubleshooting focus toward the application client.

The story of session 3346 is different. This session is truly a bottleneck to the application. Now that you know why this session appears slow�it is waiting for a row lock�the next logical question is which session holds that lock.

select 
  blocking_session B_SID,
  blocking_instance B_Inst
from v$session
where sid = 3346;

B_SID   B_INST
������  �������
 2832      1

The output shows clearly that SID 2832 is holding the lock that SID 3346 is waiting for. Now you can follow a cause/effect relationship between the session in which an update to a row is being blocked and the session that holds the lock on that row.

Getting row lock information

select row_wait_obj#,
       row_wait_file#,
       row_wait_block#,
       row_wait_row#
from v$session 
where sid = 3346;

ROW_WAIT_OBJ#  ROW_WAIT_FILE#  ROW_WAIT_BLOCK#  ROW_WAIT_ROW#
�������������  ��������������  ���������������� ��������������
241876         1024            2307623          0

To get the object information:
 
select owner, object_type, object_name, data_object_id
from dba_objects
where object_id = 241876;

OWNER  OBJECT_TYPE  OBJECT_NAME   DATA_OBJECT_ID
�����  ������������ ������������  ��������������
ARUP   TABLE        T1                    241877

The output shows that some row in the T1 table is the point of the row lock contention. But which specific row is locked? That data is available in three V$SESSION view 

REM  1. owner 
REM  2. table name 
REM  3. data_object_id
REM  4. relative file ID 
REM  5. block ID
REM  6. row Number 
REM
select *
from &1..&2
where rowid =
        dbms_rowid.rowid_create (
                rowid_type      =>  1, 
                object_number   => &3,
                relative_fno    => &4,
                block_number    => &5,
                row_number      => &6
        )
/

SQL> @rowinfo ARUP T1 241877 1024 2307623 0

COL1  C
����� �
  1   x
  
The output above shows the specific row on which a lock is being requested but that is locked by another session. So far you have identified not only the source session of the locking but the specific row being locked as well.

More on the Session

select SID, osuser, machine, terminal, service_name, 
       logon_time, last_call_et
from v$session
where username = 'ARUP'; 

SID   OSUSER  MACHINE   TERMINAL  SERVICE_NAME  LOGON_TIME LAST_CALL_ET
����� ������  �������   ��������  ������������  ���������� ������������
3346  oradb   prodb1    pts/5     SYS$USERS     05-FEB-12          6848
2832  oradb   prodb1    pts/6     SERV1         05-FEB-12          7616
4408  ANANDA  ANLAP     ANLAP     ADHOC         05-FEB-12             0

Suppose you receive a complaint that the applications running on the application server named appsvr1 are experiencing performance issues.

col username format a5
col program format a10
col state format a10
col last_call_et head 'Called|secs ago' format 999999
col seconds_in_wait head 'Waiting|for secs' format 999999
col event format a50

select sid, username, program,
        decode(state, 'WAITING', 'Waiting',
                'Working') state,
last_call_et, seconds_in_wait, event
from v$session
where machine = 'appsvr1'

Getting the SQL

select sql_id
from v$session
where sid = 3089;

SQL_ID
�����������������
g0uubmuvk4uax

set long 99999
select sql_fulltext -- clob type and formatted query
from v$sql
where sql_id = 'g0uubmuvk4uax';
SQL_FULLTEXT
����������������������������������������
update t1 set col2 = 'y' where col1 = 1

Another major cause of contention is disk I/O. When a session retrieves data from the database data files on disk to the buffer cache, it has to wait until the disk sends the data. This wait shows up for that session as �db file sequential read� (for index scans) or �db file scattered read� (for full-table scans) in the EVENT column, as shown below:
 
select event
from v$session
where sid = 3011;

EVENT
�������������������������
db file sequential read

When you see this event, you know that the session is waiting for I/O from the disk to complete. To make the session go faster, you have to reduce that waiting period. There are several ways to reduce the wait

Reduce the number of blocks retrieved by the SQL statement. Examine the SQL statement to see if it is doing a full-table scan when it should be using an index, if it is using a wrong index, or if it can be rewritten to reduce the amount of data it retrieves.
Place the tables used in the SQL statement on a faster part of the disk.
Consider increasing the buffer cache to see if the expanded size will accommodate the additional blocks, therefore reducing the I/O and the wait.
Tune the I/O subsystem to return data faster.

To find the table causing a wait, you will again use the V$SESSION view. The view�s P1 and P2 columns provide information about the segment the session is waiting for. Listing 7 shows a query of P1 and P2, and the output.

Code Listing 7: Checking data access waits
 
select SID, state, event, p1, p2
from v$session
where username = 'ARUP'; 

SID  STATE     EVENT                   P1 P2
���� �������   ����������������������� �� ����
2201 WAITING   db file sequential read  5 3011

The P1 column shows the file ID, and the P2 column shows the block ID.

select owner, segment_name
from dba_extents
where file_id = 5
and 3011 between block_id 
and block_id + blocks;

OWNER  SEGMENT_NAME
������ �������������
ARUP   T1

You can move the table to a high-speed disk for faster I/O, or, alternatively, you can focus on making I/O in this table faster by making changes that affect this table, such as creating new indexes, creating materialized views, or building a result cache.

--
Part - 2 - Diagnose the Past

select sid from v$session  where username = 'ARUP';
 
 SID
�����
  37
  
History of wait events in a specific session 

set lines 120 trimspool on
col event head "Waited for" format a30
col total_waits head "Total|Waits" format 999,999
col tw_ms head "Waited|for (ms)" format 999,999.99
col aw_ms head "Average|Wait (ms)" format 999,999.99
col mw_ms head "Max|Wait (ms)" format 999,999.99
select event, total_waits, time_waited*10 tw_ms,
       average_wait*10 aw_ms, max_wait*10 mw_ms
from v$session_event
where sid = 37
/
                                  Total      Waited     Average         Max
Waited for                        Waits    for (ms)   Wait (ms)   Wait (ms)
�������������������������� ������������  �����������  ����������  ���������
Disk file operations I/O              8         .00         .10         .00
KSV master wait                       2      350.00      173.20      340.00
os thread startup                     1       20.00       19.30       20.00
db file sequential read               5      160.00       32.10       70.00
direct path read                  1,521   51,010.00       33.50      120.00
direct path read temp           463,035  513,810.00        1.10      120.00
direct path write temp               20      370.00       18.70       50.00
resmgr:cpu quantum                   21      520.00       24.60      110.00
utl_file I/O                          8         .00         .00         .00
SQL*Net message to client            20         .00         .00         .00
SQL*Net message from client          20    9,620.00      481.20    9,619.00
kfk: async disk IO              904,818    3,050.00         .00         .00
events in waitclass Other            35       20.00         .70       20.00

you can see that session 37 (SID = 37) waited 513,810 ms, or more than 8.5 minutes, for the �direct path read temp� event. Every time the session waited for this event, it waited 1.1 ms on average, so if you can reduce the time for this event, you can reduce the overall time for the session. Looking at the session event history enables you to identify the biggest contributors to the delay in the session, whether they are currently affecting the session or have already affected it.

Did you notice the column for the maximum time waited: �Max Wait (ms)�? Why is that information useful? You see, the average wait time does not tell the whole story. Consider the �SQL*Net message from client� event in the output in Listing 1. The session waited 20 times with an average wait time of 481 ms for that event. Does that mean that the session waited for approximately 481 ms at each of the 20 occurrences or that the session waited a very short time for most of the event instances and a very long time for one event? The latter will skew the average to a high value but will indicate an isolated issue rather than a persistent one�the two possibilities lead to very different conclusions.

The �Max Wait (ms)� column shows the maximum time the session had to wait for one occurrence of this event. The value here is 9,619 ms, and because the total wait time was 9,620 ms, it appears that the session waited 9,619 ms on one occasion, leaving a 1 ms combined total for the other 19 occasions�a very small wait each time. Considering the single incidence of a large wait, this event should not be a general cause of concern. On the other hand, had you seen a maximum time close to the average time, you could surmise that all occurrences had to wait about the same amount of time. In such a case, reducing the time for this event would likely apply uniformly to all occurrences and consequently reduce the overall elapsed time.

Although the V$SESSION_EVENT view shows what the session waited for earlier, it doesn�t show when. That information is visible in another view�V$ACTIVE_SESSION_HISTORY

Although wait events are great for helping with understanding the speed bumps the sessions experience, they do not show another important attribute of sessions: the use of resources such as CPU, I/O, and memory. A resource-hogging session deprives other sessions of the same resources, thus causing performance issues. When the root of the problem is that the session is consuming too much CPU, you should look at resource consumption�not the events waited for�by a session. 

CPU Spike

Output of the top command 
top - 10:56:49 up 18 days, 18:48,  4 users,  load average: 1.02, 0.92, 0.48 
Tasks: 180 total,   2 running, 178 sleeping,   0 stopped,   0 zombie 
Cpu(s): 49.8%us,  0.5%sy,  0.0%ni, 49.2%id,  0.5%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:   1815256k total,  1771772k used,    43484k free,    66120k buffers 
Swap:  2031608k total,   734380k used,  1297228k free,   747740k cached 
 
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5946 oracle    25   0  706m 177m 159m R  100 10.0   9:20.26 oracle
 6104 oracle    15   0  2324 1060  800 R    1  0.1   0:00.12 top
31446 oracle    15   0  688m 135m 129m S    0  7.7   0:08.24 oracle

In the output in Listing 2, you can see that the process with ID 5946 consumes the most CPU (100 percent) and memory (10 percent) and therefore should be the focus of your attention. To find out more about the process, enter the following command at the UNIX prompt: 
$ ps -aef|grep 5946

oracle    5946  5945 63 10:59 ? 00:01:52 oracleD112D2 (DESCRIPTION=(LOCAL=YES)(ADDRESS=(PROTOCOL=beq)))

The output shows the entire description of the process, which is clearly an Oracle �server process��a process that is created by Oracle Database when a session is established�and that the process has been running for 1 minute and 52 seconds. The next question, then, is which Oracle Database session this process was created for.

select sid
from v$session s, v$process p
where p.spid = 5946
and s.paddr = p.addr;

SID
���
37

Once you know the SID, you can get everything you need to know about the session�the user who established the session, the machine it came from, the operating system user, the SQL it is executing, and so on�from the V$SESSION view.

Then you need to know if the CPU consumption was recent or if the session has been chewing it up since the beginning. This is where the V$SESSTAT view comes in very handy�it shows the resource consumption (CPU in this case) by a specific session. To find out the CPU used by session 37, you would use the following query: 

select s.value
from v$sesstat s, v$statname n
where s.sid = 37
and n.statistic# = s.statistic#
and n.name = 'CPU used by this session';

VALUE
�����
47379

The output shows the number of CPU �ticks� that have been consumed by this session since it started. Considering that this session has been running for about two minutes, the CPU consumption is pretty high, so it is likely that this session has been consuming CPU all the time. Again, checking the session�s other details, such as the SQL it is executing, makes it fairly easy to understand why this is the case

Let�s revisit the current problem by checking the CPU consumption once again with this: 
select s.valuez
from v$sesstat s, v$statname n
where s.sid = 37
and n.statistic# = s.statistic#
and n.name = 'CPU used by this session';

VALUE
�����
69724

Now the result�the CPU used�is 69,724. Note that this number is larger than the number the last time I checked CPU usage (47,379). This is because the statistic value increases over time.

All session statistics 

select name, value
from v$sesstat s, v$statname n
where sid = 37
and n.statistic# = s.statistic#
order by value desc
/

NAME                                        VALUE
�������������������������������   ���������������
table scan rows gotten                 1.0236E+10
session logical reads                    25898547
consistent gets                          25898543
table scan blocks gotten                 25325165
session pga memory max                   21250020
session pga memory                       21250020
session uga memory max                   20156552
session uga memory                       20156552
bytes sent via SQL*Net to client           878760
recursive calls                            576848
opened cursors cumulative                  143367
parse count (total)                        143292
parse count (hard)                         143118
table scans (short tables)                 143086
sql area evicted                           141996
DB time                                     70007
CPU used by this session                    69724


In the output, note the �table scan rows gotten� statistic value: 1.0236E+10 �about 10 billion rows( 1.0236E+10 = 10,236,000,000)! This is indeed a very high number of rows to be accessed by one session in two minutes.  
The value for the �consistent gets� statistic is 25,898,543�about 25.9 million blocks read from the buffer cache. The high number of buffer gets takes up a considerable amount of CPU.
Also note the �parse count (total)� statistic, a very high number at 143,292. It means that the session had to parse�not just execute�SQL statements that many times in about two minutes, which is quite unusual.
Therefore, you surmise from the output that there are two causes of high CPU usage for this session: a high number of buffer gets and a high number of parses.
Also note two other sets of statistics: �session pga memory max� and �session uga memory max,� which indicate the total memory consumed by the session. The very high numbers explain the high memory consumption by the Oracle server process that you noticed in the output of the operating system top command earlier. If you want to reduce the CPU and memory consumption of the server, you need to make sure the session consumes fewer of these resources, by appropriately modifying the SQL statement it issues.

Redo Spike

Occasionally you may have a performance issue that will not appear as clearly at the OS level as CPU and memory consumption. One such case is redo generation by the database instance, which, in turn, increases both the rapid switching of redo logs and the creation rate and number of archived logs. This may cause an increase in overall I/O on file systems, causing a systemwide performance issue. To alleviate this type of issue, you need to locate the session or sessions that caused the generation of high amounts of redo, but looking at OS metrics will not provide any insights into the offending session. In this case, you need to look at the sessions responsible for most of the load: the sessions generating maximum redo. Again, this information is available quite easily in the same V$SESSTAT view. The following query shows the sessions generating the most redo: 
select sid, value
from v$sesstat s, v$statname n
where n.statistic# = s.statistic#
and n.name = 'redo size'
order by value desc;

 SID     VALUE
����  ��������
 13   11982752
 10    3372240
 17     964912
 26     571324

 It�s clear from the output that SID 13 produced most of the redo, followed by SID 10, and so on.
 
Here are some other useful statistics visible in the V$SESSTAT view: 

physical reads: the number of database blocks retrieved from disk
db block changes: the number of database blocks changed in the session
bytes sent via SQL*Net to client: the bytes received from the client over the network, which is used to determine the data traffic from the client 
These are just a few of the 604 such statistics available in the V$SESSTAT view.
--
--
------ Query Tuning
--
--
SELECT *
  2    FROM t t1
  3   WHERE t1.object_type = 'TABLE'
  4     AND t1.object_id > (SELECT MAX(t2.object_id) - 500000 FROM t t2);
  
Here is the slow query I would like to tune, along with its plan: 
 
SQL> SELECT *
  2    FROM t t1
  3   WHERE t1.object_type = 'TABLE'
  4     AND t1.object_id > (SELECT MAX(t2.object_id) - 500000 FROM t t2);
6115 rows selected.

Execution Plan
�����������������������������������������������������������������������
| Id  | Operation                        | Name       | Rows  | Bytes |
�����������������������������������������������������������������������
|   0 | SELECT STATEMENT                 |            |   413 | 39235 |
|   1 |  TABLE ACCESS BY INDEX ROWID     | T          |   413 | 39235 |
|   2 |   BITMAP CONVERSION TO ROWIDS    |            |       |       |
|   3 |    BITMAP AND                    |            |       |       |
|   4 |     BITMAP CONVERSION FROM ROWIDS|            |       |       |
|   5 |      SORT ORDER BY               |            |       |       |
|*  6 |       INDEX RANGE SCAN           | T_IDX_ID   |  8252 |       |
|   7 |        SORT AGGREGATE            |            |     1 |     5 |
|   8 |         INDEX FULL SCAN (MIN/MAX)| T_IDX_ID   |     1 |     5 |
|   9 |     BITMAP CONVERSION FROM ROWIDS|            |       |       |
|* 10 |      INDEX RANGE SCAN            | T_IDX_TYPE |  8252 |       |
�����������������������������������������������������������������������

Predicate Information (identified by operation id):
�����������������������������������������������������������������������

   6 - access("T1"."OBJECT_ID"> (SELECT MAX("T2"."OBJECT_ID")-500000 FROM
              "T" "T2"))
       filter("T1"."OBJECT_ID"> (SELECT MAX("T2"."OBJECT_ID")-500000 FROM
              "T" "T2"))
  10 - access("T1"."OBJECT_TYPE"='TABLE')


 
 Here is the query and the faster plan I would like it to use:  

SQL> SELECT MAX(t2.object_id) - 500000 FROM t t2;

MAX(T2.OBJECT_ID)-500000
������������������������������������
                   19975

SQL> SELECT *
  2    FROM t t1
  3   WHERE t1.object_type = 'TABLE' AND t1.object_id > 19975;
6115 rows selected.

Execution Plan
�����������������������������������������������������������������
| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)|
�������������������������������������������������������������������������������
|   0 | SELECT STATEMENT            |            |  7198 |   667K|   102   (2)|
|*  1 |  TABLE ACCESS BY INDEX ROWID| T          |  7198 |   667K|   102   (2)|
|*  2 |   INDEX RANGE SCAN          | T_IDX_TYPE |  8553 |       |     6   (0)|
�������������������������������������������������������������������������������

Predicate Information (identified by operation id):
����������������������������������������������������������������������������

   1 - filter("T1"."OBJECT_ID">19975)
   2 � access("T1"."OBJECT_TYPE"='TABLE')

Although these two queries are semantically equivalent, they present very different challenges to the optimizer. In the first case, the optimizer will have to �guess� at the value returned by the subquery, because it has not yet executed the subquery.
is very much like
SQL> SELECT *
  2    FROM t t1
  3   WHERE t1.object_type = 'TABLE'
  4     AND t1.object_id > ???;

With the other query the optimizer has a lot more information to work with. It knows approximately how many rows will come back, due to the predicate with constant values. So what you are dealing with is a query in which the optimizer will have a really hard time obtaining correct cardinality.

SQL> select /*+ opt_param( '_b_tree_bitmap_plans', 'FALSE' ) */ *
  2    FROM t t1
  3   WHERE t1.object_type = 'TABLE'
  4     AND t1.object_id > (SELECT MAX(t2.object_id) - 500000 FROM t t2);
  
--
-- On Constraints, Metadata, and Truth : By Tom Kyte
--

Many people think of constraints as a data integrity thing, and it�s true�they are. But constraints are used by the optimizer as well when determining the optimal execution plan. The optimizer takes as inputs
 
The query to optimize
All available database object statistics
System statistics, if available (CPU speed, single-block I/O speed, and so on�metrics about the physical hardware)
Initialization parameters
Constraints

People tend to skip constraints in a data warehouse/reporting system. The argument is, �The data is good; we did a data cleansing; we don�t need data integrity constraints.� They might not need constraints for data integrity (and they might be unpleasantly surprised if they did enable them), but they do need integrity constraints in order to achieve the best execution plans. In a data warehouse, a bad query plan might be one that takes hours or days to execute�not just a couple of extra seconds or minutes. It is a data warehouse, therefore, that truly needs constraints�for performance reasons.

If you have a view containing union of two tables and two tables contains mutually exclusive data(e.g one contains object_type=table and  other objects type=view) and these are defined as constraint. Any query on the view with filter as object_type=table will only access the first table.

if you have a index on not null column and you execute count(*) it will use the index by default(INDEX FAST FULL SCAN). if you donot put the not null constraint it will be a full table scan. (if all columns in an index key are null, no entry will be made in the index), 

select * from t where object_type is null;
That shows that if OBJECT_TYPE is nullable, the optimizer will not (in fact, cannot) use the index to satisfy �OBJECT_TYPE IS NULL.� If we add an attribute to the index that is not null, the plan will change, however. Here I�ll add the constant zero to the index. (Any not null column will do, and in this case, I just need something not null, and zero is very small and known to be not null.)
create index t_idx on t (object_type, 0);
select * from t where object_type is null;

--------------------------------------------------------------------------------------
| Id  | Operation                    | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT             |       |     1 |   101 |  1      (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID | T     |     1 |   101 |  1      (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN           | T_IDX |     1 |       |  1      (0)| 00:00:01 |
--------------------------------------------------------------------------------------


We pretend they are large, using DBMS_STATS.SET_TABLE_STATS to make the optimizer believe they are �big��and we create the EMP_DEPT view, as shown in Listing 7.

Code Listing 7: Creating "big" EMP and DEPT tables and EMP_DEPT view

SQL> create table emp
  2    as
  3    select *
  4    from scott.emp;
Table created.

SQL> create table dept
  2    as
  3    select *
  4    from scott.dept;
Table created.

SQL> create or replace view emp_dept
  2    as
  3    select emp.ename, dept.dname
  4      from emp, dept
  5     where emp.deptno = dept.deptno; 
View created.

SQL> begin
  2       dbms_stats.set_table_stats
  3           ( user, 'EMP', numrows=>1000000, numblks=>100000 );
  4       dbms_stats.set_table_stats
  5           ( user, 'DEPT', numrows=>100000, numblks=>10000 );
  6    end; 
  7    /
PL/SQL procedure successfully completed.

--
-- On Clustering Factor and Validating Keys : By Tom Kyte
--

create table t (a number);

insert into t (a)
 with data(r)
 as
 (select 1 r from dual
 union all
 select r+1 from data where r+1 <= 100
 )
 select * from data
 
In short, the index clustering factor is a measure of how many I/Os the database would perform if it were to read every row in that table via the index in index order.
If the rows of a table on disk are sorted in about the same order as the index keys, the database will perform a minimum number of I/Os on the table to read the entire table via the index. That is because the next row needed from an index key would likely be the next row in the table block as well. The query would not be skipping all over the table to find row after row�they are naturally next to each other on the block. Conversely, if the rows in the table are not in the same order on disk as the index keys�if the data is scattered�the query will tend to perform the maximum number of I/Os on the table, as many as one I/O for every row in the table. That is because as the database scans through the index, the next row needed will probably not be on the same block as the last row. The database will have to discard that block and get another block from the buffer cache. The query will end up reading every block from the buffer as many times as it has rows on it.

So if a table and an index key are in about the same order, the clustering factor will be near the number of blocks in the table and the index will be useful for very large index range scans and for retrieving numerous rows from the table. On the other hand, if the data is randomly scattered, the clustering factor will be near the number of rows in the table, and given that the number of rows in a table is usually at least an order of magnitude more than the number of blocks, the index will be less efficient for returning numerous rows. 

For example, if a table is 100 blocks in size and has 100 rows per block, an index with a clustering factor of 100 (near the number of blocks) will perform about 2 I/Os against the table to retrieve 200 rows. That is because when the database reads the first table block to get row #1, rows 2�100 are probably on that same block, so the query will be able to get the first 100 rows by reading the table block once. The process will be similar for rows 101�200. 

If the index has a clustering factor of 10,000�the number of rows in the table�the number of I/Os required against the table will be approximately 200, even though there are only 100 blocks! That is because the first row in the index will be on a different block than the second row, which, in turn, will be on a different block than the third row, and so on�the database will probably never be able to get more than one row from a table block at a time.

SQL> create table organized
  2  as
  3  select x.*
  4    from (select * from stage 
             order by object_name) x
  5  /
Table created.

SQL> create table disorganized
  2  as
  3  select x.*
  4    from (select * from stage 
          order by dbms_random.random) x
  5  /
Table created.



Note that when I created these two tables, I used an ORDER BY statement. In the case of the first table, I sorted the data by OBJECT_NAME before loading it into the table. If I were to do a full table scan on the ORGANIZED table, the OBJECT_NAME column would be more or less sorted on the screen even without an ORDER BY (but you need the ORDER BY in the query if you want the data to be sorted). During the creation of the DISORGANIZED table, on the other hand, I sorted by a random value�I just scrambled the data. If I were to do a full table scan on that table, the OBJECT_NAME values would come out in an arbitrary order�I might see an object starting with the letter N first, then Z, then A, then Q, then B, then Z again, and so on.

Now I�ll index and gather statistics on these two tables and look at the statistics, as shown in Listing 1.

Code Listing 1: Creating indexes, generating statistics, and viewing information

SQL> create index organized_idx on organized(object_name);
Index created.

SQL> create index disorganized_idx on disorganized(object_name);
Index created.

SQL> begin
  2  dbms_stats.gather_table_stats
  3  ( user, 'ORGANIZED',
  4    estimate_percent => 100,
  5    method_opt=>'for all indexed columns size 254'
  6  );
  7  dbms_stats.gather_table_stats
  8  ( user, 'DISORGANIZED',
  9    estimate_percent => 100,
 10    method_opt=>'for all indexed columns size 254'
 11  );
 12  end;
 13  /
PL/SQL procedure successfully completed.

SQL> select table_name, blocks, num_rows from user_tables where table_name like '%ORGANIZED' order by 1;

TABLE_NAME        BLOCKS   NUM_ROWS  
����������������  �������  ������� 
DISORGANIZED      1064     72839  
ORGANIZED         1064     72839  

SQL> select table_name, index_name, clustering_factor  from user_indexes  where table_name like '%ORGANIZED' order by 1;

TABLE_NAME      INDEX_NAME       CLUSTERING_FACTOR
��������������  ��������������   ����������������
DISORGANIZED    DISORGANIZED_IDX            72760
ORGANIZED       ORGANIZED_IDX                1038

As you can see in Listing 1, both tables have the same number of rows and the same number of blocks. That is expected�they contain exactly the same rows, just in a different order. But when I look at the clustering factor, I see a large difference between the two. The ORGANIZED index has a clustering factor very near the number of blocks in the table, whereas the DISORGANIZED index has a clustering factor near the number of rows in the table. Again, this clustering factor metric is a measure of how many I/Os the database will perform against the table in order to read every row via the index. I can verify this fact by executing a query with tracing enabled that will, in fact, read every row of the table via the index. I�ll do that by using an index hint to force the optimizer to use my index and count the non-null occurrences of a nullable column that is not in the index. That will force the database to go from index to table for every single row:

 
SQL> select /*+ index( organized organized_idx) */
  2    count(subobject_name)
  3    from organized;

COUNT(SUBOBJECT_NAME)
����������������������
                  658

SQL> select /*+ index( disorganized disorganized_idx) */
  2    count(subobject_name)
  3    from disorganized;

COUNT(SUBOBJECT_NAME)
�����������������������������
                  658

Reviewing the TKPROF report for reading every row via the index, I discover the results in Listing 2.

Code Listing 2: Information on index scans on both tables

 
select /*+ index( organized organized_idx) */
  count(subobject_name)
 from organized

Row Source Operation
�������������������������������������������������������������������
SORT AGGREGATE (cr=1401 pr=1038 pw=0 time=307733 us)
 TABLE ACCESS BY INDEX ROWID ORGANIZED (cr=1401 pr=1038 pw=0 tim...
  INDEX FULL SCAN ORGANIZED_IDX (cr=363 pr=0 pw=0 time=53562 ...

select /*+ index( disorganized disorganized_idx) */
  count(subobject_name)
 from disorganized

Row Source Operation
���������������������������������������������������������������������
SORT AGGREGATE (cr=73123 pr=1038 pw=0 time=535990 us)
 TABLE ACCESS BY INDEX ROWID DISORGANIZED (cr=73123 pr=1038 pw=0 t...
  INDEX FULL SCAN DISORGANIZED_IDX (cr=363 pr=0 pw=0 time=47207 us �

As you can see in Listing 2, I performed 363 I/Os for the ORGANIZED table against the index (cr=363 in the INDEX FULL SCAN ORGANIZED_IDX row source), and if I subtract 363 from the 1,401 total I/Os performed by the query, I�ll get 1,038, which is exactly the clustering factor of this index. Similarly, if I do the same analysis on the DISORGANIZED index, I�ll see 73,123 � 363 = 72,760 I/Os against the table, again the clustering factor of that index.

So, for one table, the database performs 1,401 total I/Os to retrieve exactly the same data as for the other table�which needed 73,123 I/Os.

Obviously, one of these indexes is going to be more useful for retrieving a larger number of rows than the other. If I am going to read more than 1,038 blocks of the table via the index, I certainly should be doing a full table scan instead of using an index. I can observe this fact as well, by using autotrace on a few queries against both tables, as shown in Listing 3.

Code Listing 3: Comparing costs of using an index on two tables
 
SQL> select * from organized where object_name like 'F%';

����������������������������������������������������������������������������
| Id  | Operation                   | Name          | Rows | Bytes | Cost  |
����������������������������������������������������������������������������
|   0 | SELECT STATEMENT            |               |  149 | 14602 |    6  |
|   1 |  TABLE ACCESS BY INDEX ROWID| ORGANIZED     |  149 | 14602 |    6  |
|*  2 |   INDEX RANGE SCAN          | ORGANIZED_IDX |  149 |       |    3  |
����������������������������������������������������������������������������

SQL> select * from disorganized where object_name like 'F%';

������������������������������������������������������������������������������
| Id  | Operation                   | Name             | Rows | Bytes | Cost |
������������������������������������������������������������������������������
|   0 | SELECT STATEMENT            |                  |  149 | 14602 |  152 |
|   1 |  TABLE ACCESS BY INDEX ROWID| DISORGANIZED     |  149 | 14602 |  152 |
|*  2 |   INDEX RANGE SCAN          | DISORGANIZED_IDX |  149 |       |    3 |


 

As you can see in Listing 3, both plans expect to return the same number of rows: 149. Both plans are using an index range scan. But the two plans have radically different costs: one has a low cost of 6 and the other a much higher cost of 152�even though both plans are going after exactly the same set of rows from two tables that contain the same data! The reason for the cost difference is easy to explain: the optimizer computes the cost column value as a function of the number of expected I/Os and the CPU cost. For this simple query, the CPU cost is negligible, so most of the cost is simply the number of I/Os. 

Walking through the first plan, I see there is a cost of 3 for using the index for the ORGANIZED table and index�about three I/Os against the index, which makes sense. The query will hit the root block, branch, and probably the leaf block. Then the query will be doing about three more I/Os against the table, because the rows needed are all next to each other on a few database blocks, for a total cost of 6. The DISORGANIZED index, on the other hand, does the math a little differently. The plan still has the same three I/Os against the index�that won�t change�but because the rows needed from the table are not next to each other, the optimizer estimates that the query will have to perform an I/O against the table for every row it retrieves, and its estimated cost for 149 rows is 149 rows + 3 I/Os = 152.

If I change the query slightly, I can see what kind of effect this might have on the query plans shown in Listing 4.

Code Listing 4: Changing queries, changing costs
 
SQL> select * from organized where object_name like 'A%';

����������������������������������������������������������������������������
| Id  | Operation                   | Name          | Rows  | Bytes | Cost |
����������������������������������������������������������������������������
|   0 | SELECT STATEMENT            |               |  1825 |  174K |   39 |
|   1 |  TABLE ACCESS BY INDEX ROWID| ORGANIZED     |  1825 |  174K |   39 |
|*  2 |   INDEX RANGE SCAN          | ORGANIZED_IDX |  1825 |       |   12 |
����������������������������������������������������������������������������

SQL> select * from disorganized where object_name like 'A%';

�����������������������������������������������������������������
| Id  | Operation         | Name         | Rows  | Bytes | Cost |
�����������������������������������������������������������������
|   0 | SELECT STATEMENT  |              |  1825 |  174K |  291 |
|*  1 |  TABLE ACCESS FULL| DISORGANIZED |  1825 |  174K |  291 |
�����������������������������������������������������������������


 As you can see in Listing 4, the estimated row count has jumped to 1,825 and the ORGANIZED table will still use the index. The cost of the query is 39 � 12 I/Os estimated against the index for the range scan and 27 more I/Os against the table. That makes sense, because the ALL_OBJECTS rows� size means that about 70 or so fit on a database block�it would take about 27 blocks to hold 1,825 rows. When I look at the DISORGANIZED table, I see that it gets the same estimated row counts but that the plan is totally different. The optimizer chose not to use an index but instead to do a full table scan. What would the cost of using the index have been? I know from the result in Listing 4 that the cost of the index step (INDEX RANGE SCAN) would be 12, and given that the clustering factor of the index is near the number of rows in the table, I can assume that every row I need to retrieve will require an I/O. So, the query would need to perform 1,825 I/Os against the table, for a total query cost of 1,837�it would be less expensive to do a full table scan.

In fact, I have enough information to figure out when the optimizer would stop using this index. I know that the cost of a full table scan is 291, and I know that the cost of a query plan that uses an index against this table would be at least equal to the number of estimated rows plus the cost of the query. So if the query is getting around 285 rows, the cost of using the index would probably be around 5 or 6, the cost of the table access would be about 291, and the full table and index scan costs would be tied. Any cost above an estimated row count of 285 would cause the optimizer to do a full table scan. The cost of getting thousands of rows from the organized table is less than the cost of getting a few hundred from the disorganized table. And the clustering factor is what reports that cost, in general, for the index range scan.

---

Many of you might think the following demonstration is not possible, but it is. I�ll start with the tables:

 
SQL> create table p
  2  ( x int,
  3    y int,
  4    z int,
  5    constraint p_pk primary key(x,y)
  6  )
  7  /
Table created.

SQL> create table c
  2  ( x int,
  3    y int,
  4    z int,
  5    constraint c_fk_p 
  6    foreign key (x,y) 
  7    references p(x,y)
  8  )
  9  / 
Table created.


 

Looks like a normal parent-child relationship: a row may exist in C if and only if a parent row exists in P. But if that is true, how can this happen?

 
SQL> select count( x||y ) from p;

COUNT(X||Y)
���������������
          0

SQL> select count( x||y ) from c;

COUNT(X||Y)
���������������
          1

There are zero records in P�none. There is at least one record in C, and that record has a non-null foreign key. What is happening?

It has to do with NULLs, foreign keys, and the default MATCH NONE rule for composite foreign keys. If your foreign key allows NULLs and your foreign key is a composite key, you must be careful of the condition in which only some of the foreign key attributes are not null. For example, to achieve the above magic, I inserted
 
SQL> insert into c values ( 1, null, 0 );
1 row created.

The database cannot validate a foreign key when it is partially null. In order to enforce the MATCH FULL rule for composite foreign keys, you would add a constraint to your table:

 
SQL> alter table c add constraint 
check_nullness
  2  check ( ( x is not null 
  3            and y is not null ) or
  4          ( x is null 
  5             and y is null ) ) 
  6  /
Table altered.

The constraint will ensure that either
All of the columns are NULL in the foreign key, or
None of the columns are NULL in the foreign key

As long as that constraint is in place, your foreign key will work as you probably think it should.

---
---
---
---

This must be the most asked question in discussions involving SQL databases. If there were a 10-step tuning program you could always follow, someone would certainly have automated that process�and called it the optimizer! Tuning�finding the optimal way in which to execute a query�is what the Oracle Database optimizer is tasked with doing, but often it cannot fully achieve this goal because

It lacks sufficient information because sufficient information does not exist�yet. For example, the optimizer may not have sufficient information to correctly estimate cardinalities (estimated row counts), and when that happens, inefficient query plans can happen very readily.
It lacks sufficient information because it does not understand the data. Constraints have been withheld from the optimizer in a misguided attempt to place all logic outside the database.
Its plan is the most efficient possible one�there is no better plan�but there is a problem with the organization of the data.
The query is performing work�retrieving columns and doing computations�it does not need to do. This frequently happens as the result of using a generic one-size-fits-all view or views of views of views.

In my experience, the vast majority of poorly performing execution plans can be blamed on the first two reasons. This article looks at the first reason in more detail.


In general, when I�m asked to tune a query, the very first things I want to know are The data model. I want to know everything I can know about the data itself: all tables, indexes, constraints, and assumptions.
The question being asked of the data. I�ve found more than once that a complex query I�m asked to look at doesn�t even answer the question being asked. Sometimes, instead of tuning a query, you might want to start from scratch with a self-developed query�one that specifically answers the question.

Once you have the definitive query you are going to tune�either the original query or a newly formed one�you need to understand whether the optimizer has sufficient information to correctly estimate cardinalities. Let�s take a look at this in more detail.

Estimating Cardinalities

If the optimizer incorrectly guesses how many rows will flow out of a step of a plan, the result will likely be a bad query plan. For example, if I gave you the simple query SELECT * FROM T WHERE X=5 and told you that table T has 1 million rows, column X has five distinct values, and column X is indexed, what query plan would you come up with? By default, that is the amount of information the optimizer has to work with in most cases. It knows the number of rows in the table, the number of distinct values in the column, and whether the column is indexed. It knows some other things, too�the clustering factor of the index, the number of blocks in the table, the average row length, and so on�but those statistics do not help it guess how many rows the query will work with. In this case, the number of rows in the table and the number of distinct values of column X will be the most important facts for developing the query plan.

So again, what query plan would you come up with? The math you would do in your head would probably involve trying to figure out how many rows will be retrieved from table T. That is, you�d try to estimate the cardinality of the WHERE clause�WHERE X=5. You would likely take the 1,000,000 rows in the table and divide that number by 5 to guess how many rows that WHERE clause will return on average. If there are five distinct values of X and you assume that X is uniformly distributed (because you have to make some assumptions when you don�t have any other information), you would guess that around 200,000 rows would be returned�20 percent of the table. It is highly likely that you would decide to use a full table scan for that query, as would the optimizer in most cases. But what if, after running the query, you observed that the query returned only 5 rows? It is obvious that you should have instead used the index to get 5 rows, but because you guessed 200,000 rows, you made the wrong choice.

In this clear-cut example, you�and the optimizer��got it wrong� due to insufficient information. The optimizer had no way of knowing that right now X=5 would return only five records. The question then becomes what you can do to tune this query. And the answer is manifold and version-dependent. Typically this list will include the following tuning suggestions:

Supply more statically gathered statistics. A histogram on column X would be appropriate in this case. This approach works in all Oracle Database versions, although the types of statistics you can gather have changed dramatically in Oracle Database 11g with the addition of extended statistics.
Use dynamic sampling. This enables the optimizer to validate its guesses when it needs to (see bit.ly/1qZzy8q). This approach works in Oracle9i Database Release 2 and above.
Generate a SQL profile. A SQL profile enables the optimizer to aggressively look at a query, determine what the real cardinality estimates should be, and then remember this information in the data dictionary. The next time the query is hard-parsed, the optimizer will generate a plan with these adjusted cardinalities. This approach works in Oracle Database 10g and above.

Run the query again! In some cases, starting in Oracle Database 11g, a feature called Cardinality Feedback (bit.ly/X7Dojq) causes the query to be reoptimized during the second execution, using the actual observed values�instead of the optimizer�s guesses�as cardinality estimates. In Oracle Database 12c, this facility has been extended via SQL plan directives, making it possible for the optimizer to recognize that it needs additional information and to automatically gather the information the next time statistics are gathered, making the �fix� permanent.

Let�s look at this simple case step-by-step. It shows you how to determine whether the optimizer made a miscalculation in the cardinality step, and then, after I gather additional statistics, you�ll see what happens when the optimizer gets a better cardinality estimate.

I�ll start by building a table with the skewed distribution of the data I am interested in, as shown in Listing 1.

Code Listing 1: Creating table T and skewed data
SQL> create table t
  2  as
  3  select case when mod(rownum,200000) = 0 then 5
  4              else mod(rownum,4)
  5          end X,
  6         rpad( 'x', 100, 'x' ) data
  7    from dual
  8  connect by level <= 1000000
  9  /
Table created.

SQL> create index t_idx on t(x);
Index created.

SQL> exec dbms_stats.gather_table_stats( user, 'T' );
PL/SQL procedure successfully completed.

SQL> select x, count(*)
  2    from t
  3   group by x
  4   order by x
  5  /

         X   COUNT(*)
�����������  �����������  
         0     249995
         1     250000
         2     250000
         3     250000
         5          5

In this table T, WHERE X=5 will return 5 rows; there is definite skew in this data. I would like to use the index on column X for X=5 but probably not for any other value (0, 1, 2, 3), because queries for those values would return hundreds of thousands of rows. However, when I gather plan statistics and run the queries in Listing 2, I can see that the optimizer made the mistake we all would make, given the information available.

Code Listing 2: Statistics gathered, but optimizer doesn�t see the skew
SQL> select /*+ gather_plan_statistics */
  2         count(data)
  3    from t
  4   where x = 5;

COUNT(DATA)
����������������
          5
 
SQL> select *
  2    from table(
  3          dbms_xplan.display_cursor( format=> 'allstats last' )
  4          )
  5  /

PLAN_TABLE_OUTPUT
����������������������������������
SQL_ID  cdwn5mqb0cpg1, child number 0
����������������������������������
select /*+ gather_plan_statistics */        
count(data)   
from t  
where x = 5

Plan hash value: 2966233522

���������������������������������������������������������������������������
| Id  | Operation          | Name | Starts | E-Rows | A-Rows |   A-Time   |
���������������������������������������������������������������������������
|   0 | SELECT STATEMENT   |      |      1 |        |      1 |00:00:00.08 |
|   1 |  SORT AGGREGATE    |      |      1 |      1 |      1 |00:00:00.08 |
|*  2 |   TABLE ACCESS FULL| T    |      1 |    200K|      5 |00:00:00.08 |
���������������������������������������������������������������������������

Predicate Information (identified by operation id):
���������������������������������������������������������������������������

   2 - filter("X"=5)

20 rows selected.



The E-Rows (estimated rows) column shows that the optimizer thought it would get 200,000 rows. The A-Rows (actual rows) column shows that it got only 5. (I got these two columns in my result by using the GATHER_PLAN_STATISTICS hint in the query. This hint doesn�t affect the query plan at all; it affects just the generated code executed at runtime.) The runtime code is instrumented more than usual; it gathered runtime statistics while it was executing. I got this information by using DBMS_XPLAN to display the query plan with the ALLSTATS LAST format. This is a very easy way to quickly see if the optimizer is way off. In this case, I see a huge difference between the actual and estimated rows when the filter X=5 is applied. Using my knowledge of the data (or just running a few queries to learn about the data), I can figure out pretty easily that the optimizer is missing some information.

I fill in the blanks for the optimizer:
SQL> select histogram
  2    from user_tab_columns
  3   where table_name = 'T'
  4     and column_name = 'X';

HISTOGRAM
�������������
NONE

SQL> exec dbms_stats.gather_table_stats
( user, 'T', no_invalidate=>false );
PL/SQL procedure successfully completed.

SQL> select histogram
  2    from user_tab_columns
  3   where table_name = 'T'
  4     and column_name = 'X';

HISTOGRAM
�������������
FREQUENCY



 Note: I used the NO_INVALIDATE parameter to DBMS_STATS to ensure that the query I am looking at would be hard-parsed�optimized�on the next execution. By default, DBMS_STATS will not invalidate a cursor immediately but, rather, will invalidate affected cursors slowly over time in the background. You would not typically use NO_INVALIDATE.

Before I gathered table statistics for the second time, there was no histogram on column X. Now, statistics having been gathered, there is a histogram in place. The histogram gives the optimizer much more information about column X in the table. (For more information on histograms and statistics, I recommend the paper at bit.ly/1oQhubY). With the histogram in place, I see a big difference in the optimizer plan and query execution, as shown in Listing 3.

Code Listing 3: Better query plan after skew is identified
SQL> select /*+ gather_plan_statistics */
  2         count(data)
  3    from t
  4   where x = 5;

COUNT(DATA)
����������������
          5

SQL> select *
  2    from table(
  3          dbms_xplan.display_cursor( format=> 'allstats last' )
  4          )
  5  /

PLAN_TABLE_OUTPUT
����������������������������������
SQL_ID  cdwn5mqb0cpg1, child number 0
����������������������������������
select /*+ gather_plan_statistics */        
count(data)   
from t  
where x = 5

Plan hash value: 1789076273

������������������������������������������������������������������������
| Id | Operation                    | Name  | Starts | E-Rows | A-Rows |
������������������������������������������������������������������������
|  0 | SELECT STATEMENT             |       |      1 |        |      1 |
|  1 |  SORT AGGREGATE              |       |      1 |      1 |      1 |
|  2 |   TABLE ACCESS BY INDEX ROWID| T     |      1 |    182 |      5 |
|* 3 |    INDEX RANGE SCAN          | T_IDX |      1 |    182 |      5 |
������������������������������������������������������������������������

Predicate Information (identified by operation id):
������������������������������������������������������������������������

   3 - access("X"=5)

21 rows selected.

The plan is now using an index range scan instead of a full table scan, as you would expect for a small number of rows. Note that the E-Rows column value is not perfect, though. The guess made by the optimizer will rarely, if ever, be 100 percent dead-on, and I would not expect it to be. What is important is that the number is close to being correct. As long as the guess is close enough, the optimizer will choose the right access path, join order, and so on.

One thing you might be wondering about, however, is how just gathering statistics a second time made any difference. And why did the optimizer know to generate histograms the second time but didn�t know this the first time? The answers lie in the fact that the database has been spying on me�watching my predicates and remembering them in the data dictionary. When I ran the query with X=5 in it, the database remembered that, and the next time it gathered statistics, it took the facts that X is used to estimate cardinalities in predicates and that the data values in X are skewed and it automatically generated histograms. This will happen only if you leave the METHOD_OPT parameter in the DBMS_STATS package call at its default value. (For a full example of this feature and information on how it works, see bit.ly/1oQhAQU.)

This was a rather simple example: a single column predicate on a column with skewed data. What about a more complex case? What about a multicolumn predicate? Suppose you have a predicate on a table such as WHERE X = 5 and Y = 10. How do you go about estimating a cardinality for that combination? The optimizer can have a lot of information on X (including histograms) and it can have a lot of information on Y, but it doesn�t know anything by default about X and Y at the same time. In real life, there are often correlations between attributes in a table. Consider a car make and a car color. Do you often see pink Audis? How about lime-green BMWs? Probably not, but you might see a pink or lime-green Volkswagen Beetle. In a table containing information about shoes�along with demographic information such as gender�there is almost certainly a correlation between gender and shoe type. There are too many examples of correlated attributes to list.

So, how can you help the optimizer out here? How can you help it get a better estimated cardinality? Back to my list of tuning suggestions, you could use dynamic sampling (bit.ly/1qZzy8q), SQL profiles, Cardinality Feedback, or static statistics�known as extended statistics in Oracle Database 11g and above.

Here�s a demonstration of the static statistics method:

I start by creating a table with some multicolumn skewed data. In the new table T, FLAG1 and FLAG2 are columns that have only two values: Y and N. The way I�ve generated the data, however, ensures that almost all rows are created with FLAG1 <> FLAG2 (FLAG1 is not equal to FLAG2) and very few rows are created where FLAG1 = FLAG2. FLAG1 and FLAG2 values are each uniformly distributed�50 percent of FLAG1 and FLAG2 values are Y, and the other 50 percent are N. However, when you look at the values together�as a pair�a very definite data skew appears, as shown in Listing 4.

Code Listing 4: Creating a new table T and a new data skew
SQL> create table t
  2  as
  3  select case when mod(rownum,2) = 0 then 'Y' else 'N' end flag1,
  4         case when mod(rownum,2) = 0
  5              then case when mod(rownum,1000) = 0 then 'Y' else 'N' end
  6              else case when mod(rownum,1000) = 1 then 'N' else 'Y' end
  7          end flag2,
  8         rpad( 'x', 100, 'x' ) data
  9    from dual
 10  connect by level <= 1000000
 11  /
Table created.

SQL> create index t_idx on t(flag1,flag2);
Index created.

SQL> exec dbms_stats.gather_table_stats( user, 'T' );
PL/SQL procedure successfully completed.

SQL> select flag1, flag2, count(*)
  2    from t
  3   group by flag1, flag2
  4   order by flag1, flag2
  5  /

F F   COUNT(*)
� �   �����������
N N       1000
N Y     499000
Y N     499000
Y Y       1000



As you can see, in the new table T, out of 1,000,000 records, only 2,000 are such that FLAG1 = FLAG2. For the vast majority of the records, FLAG1 <> FLAG2. But pretend for a moment that you are the optimizer and are asked to calculate how many rows would come back from a predicate WHERE FLAG1 = �N� AND FLAG2 = �N�. What math would you go through to estimate that? You have all the default statistics: number of rows in the table, number of distinct values in every column, and so on. Now what estimated cardinality would you come up with? (Remember, you are the optimizer! You did not see the table getting created.)


Cardinalities

SQL> create or replace type str2tblType as table of varchar2(30)
  2  /
Type created. 

SQL> create or replace
  2  function str2tbl( p_str in varchar2, p_delim in varchar2 default ',' )
  3  return str2tblType
  4  PIPELINED
  5  as
  6      l_str      long default p_str || p_delim;
  7      l_n        number;
  8  begin
  9      loop
 10          l_n := instr( l_str, p_delim );
 11          exit when (nvl(l_n,0) = 0);
 12          pipe row( ltrim(rtrim(substr(l_str,1,l_n-1))) );
 13          l_str := substr( l_str, l_n+1 );
 14      end loop;
 15  end;
 16  /
 
 Once I have that function installed, I can try it out by executing a query like this: 
SQL> variable x varchar2(15)

SQL> exec :x := '1,2,3,a,b,c'

PL/SQL procedure successfully completed.

SQL> select * from table(str2tbl(:x));

COLUMN_VALUE
��������������������������������������
1
2
3
a
b
c

6 rows selected.

Optimizer making 8 K cardinality estimate 
SQL> select * from table(dbms_xplan.display_cursor);

PLAN_TABLE_OUTPUT
��������������������������������������������������������
SQL_ID  ddk1tv9s5pzq5, child number 0
��������������������������������������������������������
select * from table(str2tbl(:x))

Plan hash value: 2407808827

���������������������������������������������������������������������������
|Id|Operation                      |Name   |Rows|Bytes|Cost (%CPU)|Time    |
���������������������������������������������������������������������������
| 0|SELECT STATEMENT               |       |    |     |  29  (100)|        |
| 1| COLLECTION ITERATOR PICKLER...|STR2TBL|8168|16336|  29    (0)|00:00:01|


 
 As you can see, there is that magic 8,168 number in the ROWS column. The optimizer assumes that the collection returned by this function is going to have more than 8,000 entries�you can imagine how that might affect the choices made by the optimizer regarding whether to use an index when processing a query

 
 Solution - 1
 
 Using the CARDINALITY hint 
SQL> select * from table(dbms_xplan.display_cursor);

PLAN_TABLE_OUTPUT
��������������������������������������������������������
SQL_ID  bd2f8rh30z3ww, child number 0
��������������������������������������������������������
select /*+ cardinality(sq 10) */ * from table(str2tbl(:x)) sq

Plan hash value: 2407808827

���������������������������������������������������������������������������
|Id|Operation                      |Name   |Rows|Bytes|Cost (%CPU)|Time    |
���������������������������������������������������������������������������
| 0|SELECT STATEMENT               |       |    |     |  29  (100)|        |
| 1| COLLECTION ITERATOR PICKLER...|STR2TBL|  10|   20|  29    (0)|00:00:01|


As you can see, when I use CARDINALITY(SQ 10) as a hint in the query, the optimizer adjusts its estimated cardinality to be the number I input

Solution - 2

SQL> select 10/8168 from dual;

    10/8168
����������������
  .00122429
 
I want 10 instead of 8,168, so I need to use a scaling factor of 0.00122429. When I do that, I get the result in Listing 7.

Code Listing 7: Using the OPT_ESTIMATE hint 
select /*+ opt_estimate(table, sq, scale_rows=0.00122429) */ * 
  from table(str2tbl(:x)) sq

Plan hash value: 2407808827
���������������������������������������������������������������������������
|Id|Operation                      |Name   |Rows|Bytes|Cost (%CPU)|Time    |
���������������������������������������������������������������������������
| 0|SELECT STATEMENT               |       |    |     |  29  (100)|        |
| 1|  OLLECTION ITERATOR PICKLER...|STR2TBL|  10|   20|  29    (0)|00:00:01|


 I achieve the desired result again: a cardinality estimate of 10.
 
 Solution -3
 
 Using Cardinality Feedback (and the WITH factored subquery and materialize hint) 
with sq 
as (
select /*+ materialize */ *    
  from table( str2tbl( :x ) )
) 
select * 
  from sq

Plan hash value: 630596523

�����������������������������������������������������������������������������
|Id|Operation                        |Name   |Rows|Bytes|Cost (%CPU)|Time    |
�����������������������������������������������������������������������������
| 0|SELECT STATEMENT                 |       |    |     |  32  (100)|        |
| 1| TEMP TABLE TRANSFORMATION       |       |    |     |           |        |
| 2|  LOAD AS SELECT                 |       |    |     |           |        |
| 3|   COLLECTION ITERATOR PICKLER...|STR2TBL|8168|16336|   29   (0)|00:00:01|
| 4|  VIEW                           |       |8168| 135K|    3   (0)|00:00:01|
| 5|   TABLE ACCESS FULL             |SYS_...|8168|16336|    3   (0)|00:00:01|
�����������������������������������������������������������������������������

18 rows selected.

Note that the first time I execute this query, the cardinality estimate is way off�it is that magic number 8,168 (again). However, the optimizer learns from its mistake, and when I execute the query again, I get the result in Listing 10.

Run the query Again > Getting the corrected cardinality with Cardinality Feedback 
with sq as (select /*+ materialize */ *    from table( str2tbl( :x ) )
) select * from sq

Plan hash value: 630596523

�����������������������������������������������������������������������������
|Id|Operation                        |Name   |Rows|Bytes|Cost (%CPU)|Time    |
�����������������������������������������������������������������������������
| 0|SELECT STATEMENT                         |    |     |  32  (100)|        |
| 1| TEMP TABLE TRANSFORMATION               |    |     |           |        |
| 2|  LOAD AS SELECT                         |    |     |           |        |
| 3|   COLLECTION ITERATOR PICKLER...|STR2TBL|8168|16336|  29    (0)|00:00:01|
| 4|  VIEW                                   |   6| 102 |   3    (0)|00:00:01|
| 5|   TABLE ACCESS FULL             |SYS_...|   6|   12|   3    (0)|00:00:01|
�����������������������������������������������������������������������������

Note
�������
   - cardinality feedback used for this statement

22 rows selected.

--
--
--Active Session History : By Arup Nanda
--
--
Looking at performance issues in old sessions is easy with an Oracle Database feature called Active Session History. Note that the use of Active Session History requires Oracle Diagnostics Pack, a licensed option of Oracle Database available since Oracle Database 10g Release 1. 

Here are a few of the important columns of the V$ACTIVE_SESSION_HISTORY view:

SAMPLE_ID. The unique identifier of the Active Session History record.
SAMPLE_TIME. When Active Session History captured this data on all active sessions.
USER_ID. The numerical user ID (not the username) of the database user who created this session.
SESSION_ID. The session ID (SID) of the session.
SESSION_STATE. The state the session was in when Active Session History took the sample. It shows WAITING if the session was waiting for something; otherwise, it shows ON CPU to indicate that the session was doing productive work.
EVENT. If the session was in a WAITING state (in the SESSION_STATE column), this column will show the wait event the session was waiting for.
TIME_WAITED. If the session was in a WAITING state, this column will show how long it had been waiting when Active Session History took the sample.
WAIT_TIME. If the session is doing productive work�not in a WAITING state�this column will show how long the session waited for the last wait event.
SQL_ID. The ID of the SQL statement the session was executing at the time the sample was taken.
SQL_CHILD_NUMBER. The child number of the cursor. If this is the only version of the cursor, the child number will be 0.

To begin the identification, you need to pose two questions to the application owners or users executing the SQL statements that experienced slow performance: 

Which username was used to connect to the database?
What was the time interval (start and end times) of the period when the performance issues occurred? 

select user_id from dba_users where username = 'ARUP'; -- 92
        
select session_id, sample_time, session_state, event, wait_time, time_waited, sql_id, sql_child_number CH#
from v$active_session_history
where user_id = 92
and sample_time between
    to_date('29-SEP-12 04.55.00 PM','dd-MON-yy hh:mi:ss PM')
       and
    to_date('29-SEP-12 05.05.00 PM','dd-MON-yy hh:mi:ss PM')
order by session_id, sample_time;

Because Active Session History collects information on all active sessions, you need to order the output by SID, which identifies a session (shown under SESSION_ID), and then by the collection time 



SESSION_ID SAMPLE_TIME             SESSION_STATE   EVENT                          WAIT_TIME  TIME_WAITED SQL_ID        CH#
���������� ������������������������� ������� ������������������������������ ����������� ����������� ������������� ����
        39 29-SEP-12 04.55.02.379 PM WAITING  enq: TX - row lock contention           0           0 fx60htyzmz6wv   0
        39 29-SEP-12 04.55.03.379 PM WAITING  enq: TX - row lock contention           0           0 fx60htyzmz6wv   0
        39 29-SEP-12 04.55.04.379 PM WAITING  enq: TX - row lock contention           0           0 fx60htyzmz6wv   0
        39 29-SEP-12 04.55.05.379 PM WAITING  enq: TX - row lock contention           0           0 fx60htyzmz6wv   0
        39 29-SEP-12 04.55.06.379 PM WAITING  enq: TX - row lock contention           0           0 fx60htyzmz6wv   0
        39 29-SEP-12 04.55.07.389 PM WAITING  enq: TX - row lock contention           0           0 fx60htyzmz6wv   0
� output truncated �
        39 29-SEP-12 05.16.52.078 PM WAITING  enq: TX - row lock contention           0  1310761160      
        44 29-SEP-12 04.55.34.419 PM WAITING  resmgr:cpu quantum                      0      109984 92ty3097fqfwg   0
        44 29-SEP-12 04.55.35.419 PM ON CPU                                      110005           0 a5wts2yzmws18   0
        44 29-SEP-12 04.55.36.419 PM WAITING  resmgr:cpu quantum                      0      110016 61q5r7d0ztn6n   0
        44 29-SEP-12 04.55.37.419 PM ON CPU                                      109984           0 7bnf79qwyy9k8   0
        44 29-SEP-12 04.55.38.419 PM WAITING  resmgr:cpu quantum                      0      107874 7b0jbugzatdcr   0
        44 29-SEP-12 04.55.39.419 PM WAITING  resmgr:cpu quantum                      0      107962 fngb4y81xr57x   0
� output truncated �
        46 29-SEP-12 04.57.18.555 PM ON CPU                                      110984           0 f7kmq72a8h7pt   0
        46 29-SEP-12 04.57.19.555 PM WAITING  resmgr:cpu quantum                      0      110981 f7kmq72a8h7pt   0
        46 29-SEP-12 04.57.20.555 PM ON CPU                                      110982           0 f7kmq72a8h7pt   0
        46 29-SEP-12 04.57.21.555 PM WAITING  resmgr:cpu quantum                      0      111974 f7kmq72a8h7pt   0
        46 29-SEP-12 04.57.22.555 PM ON CPU                                      112986           0 f7kmq72a8h7pt   0
        46 29-SEP-12 04.57.23.555 PM WAITING  resmgr:cpu quantum                      0      111998 f7kmq72a8h7pt   0
        46 29-SEP-12 04.57.24.555 PM WAITING  resmgr:cpu quantum                      0      108975 f7kmq72a8h7pt   0

The first row of the output. It shows that the session identified by SESSION_ID 39 was waiting for the �enq: TX - row lock contention� event on 29-SEP-12 at 04.55.02.379 PM. Because the session was in a WAITING state, the value of the WAIT_TIME column is irrelevant, so it shows up as 0. Because the session was still in a WAITING state when Active Session History captured the state, the TIME_WAITED column shows 0. When the session finally got the lock, it could do what it had to do and stopped waiting. At that point, the total time the session had waited was updated in Active Session History (Row logged at 39 29-SEP-12 05.16.52.078) 1,310,761,160 microseconds (shown in the TIME_WAITED column), or about 22 minutes. And it was running SQL fx60htyzmz6wv. 
        
select SQL_TEXT 
from v$sql 
where sql_id = 'fx60htyzmz6wv';

update test1 set status = 'D' where object_id = :b1

Blocking sessiom shows the sesion ID holding the lock.

select sample_time, session_state, blocking_session, current_obj#, current_file#, current_block#, current_row#
from v$active_session_history
where user_id = 92
and sample_time between
    to_date('29-SEP-12 04.55.00 PM','dd-MON-yy hh:mi:ss PM')
    and
    to_date('29-SEP-12 05.05.00 PM','dd-MON-yy hh:mi:ss PM')
and session_id = 39
and event = 'enq: TX - row lock contention'
order by sample_time;
        
        
Getting specific row information
select
    owner||'.'||object_name||':'||nvl(subobject_name,'-') obj_name,
    dbms_rowid.rowid_create (
        1,
        o.data_object_id,
        row_wait_file#,
        row_wait_block#,
        row_wait_row#
    ) row_id
from v$session s, dba_objects o
where sid = &sid
and o.data_object_id = s.row_wait_obj#

OBJ_NAME       ROW_ID
�������������  �������������������
ARUP.TEST1:-   AAAdvSAAHAAABGPAAw

Now turn your attention to session 44. you can see that session 44 switched between waiting (shown under SESSION_STATE as WAITING) and doing productive work (shown as ON CPU). You need to know why the session was intermittently waiting for this wait event and therefore slowing down.

The �resmgr:cpu quantum� event is due to Oracle Database�s Database Resource Management feature. Database Resource Management acts as a resource governor: it limits CPU consumption of individual sessions when the total CPU demand from all sessions goes up to more than 100 percent, and it enables more-important sessions to get the CPU they need. Because the output shows the session waiting, you can conclude that the CPU consumption by the session with SESSION_ID 44 was high enough at that time for Database Resource Management to limit its CPU usage.

In that case, you may suspect that the session was under a consumer group that has a more restrictive CPU allocation than expected.

select sample_time, session_state, event, consumer_group_id
from v$active_session_history
where user_id = 92
and sample_time between
    to_date('29-SEP-12 04.55.02 PM','dd-MON-yy hh:mi:ss PM')
    and
    to_date('29-SEP-12 05.05.02 PM','dd-MON-yy hh:mi:ss PM')
and session_id = 44
order by 1;

                           SESSION
SAMPLE_TIME                _STATE   EVENT               CONSUMER_GROUP_ID
�������������������������  �������  ������������������  �����������������
29-SEP-12 04.55.34.419 PM  WAITING  resmgr:cpu quantum              12166
29-SEP-12 04.55.35.419 PM  ON CPU                                   12166
29-SEP-12 04.55.36.419 PM  WAITING  resmgr:cpu quantum              12166
29-SEP-12 04.55.37.419 PM  ON CPU                                   12166
29-SEP-12 04.55.38.419 PM  WAITING  resmgr:cpu quantum              12166
29-SEP-12 04.55.39.419 PM  WAITING  resmgr:cpu quantum              12166
29-SEP-12 04.55.40.419 PM  ON CPU                                   12166
� output truncated �
29-SEP-12 04.55.37.419 PM  ON CPU                                   12162
29-SEP-12 04.55.38.419 PM  ON CPU                                   12166
29-SEP-12 04.55.39.419 PM  ON CPU                                   12162
29-SEP-12 04.55.40.419 PM  ON CPU                                   12162

select name from v$rsrc_consumer_group where id in (12166,12162);     

   ID  NAME
������ ������������
12166  OTHER_GROUPS
12162  APP_GROUP

This could have happened due to one of the three most likely reasons: a DBA manually activated a different resource plan, a different plan was activated automatically by a scheduling mechanism,

Now you should examine why the OTHER_GROUPS consumer group was activated earlier and, perhaps more importantly, whether this restriction was necessary or just a mistake. In any case, you have now found the root cause of the wait.

The next obvious question is why session 44 consumed so much CPU that it had to be constrained by Database Resource Management. The answer lies in the SQL statement that session 44 was executing at that time (not now).

suppose a user complains that things seemed to have been slow from a specific client machine�prolaps01�between 4:55 p.m. and 5:05 p.m. on September 29. Because Active Session History also records the machine name, you can use the query 

select event, count(1)
from v$active_session_history
where machine = 'prolaps01'
and sample_time between
    to_date('29-SEP-12 04.55.00 PM','dd-MON-yy hh:mi:ss PM')
    and
    to_date('29-SEP-12 05.05.00 PM','dd-MON-yy hh:mi:ss PM')
group by event
order by event;

EVENT                             COUNT(1)
����������������������������      ��������
� output truncated �
db file scattered read                  93
db file parallel write                 127
log file parallel write                134
db file sequential read                293
control file parallel write            612
control file sequential read           948
enq: TX - row lock contention         1309
resmgr:cpu quantum                    1371

You can generate an Active Session History report from Oracle Enterprise Manager or from the command line. For the latter, connect to the database as a DBA user and execute the following script at the SQL*Plus prompt: @$ORACLE_HOME/rdbms/admin/ashrpt.sql.

Oracle Database archives the information from the ASH buffer to a database table to make it persistent. This archived table data is visible in a view called DBA_HIST_ACTIVE_SESS_HISTORY. If you don�t find the data in the V$ACTIVE_SESSION_HISTORY view, check for it in the DBA_HIST_ACTIVE_SESS_HISTORY view

Getting row lock information from the Active Session History archive 

select sample_time, session_state, blocking_session,
owner||'.'||object_name||':'||nvl(subobject_name,'-') obj_name,
    dbms_ROWID.ROWID_create (
        1,
        o.data_object_id,
        current_file#,
        current_block#,
        current_row#
    ) row_id
from dba_hist_active_sess_history s, dba_objects o
where user_id = 92
and sample_time between
    to_date('29-SEP-12 04.55.02 PM','dd-MON-yy hh:mi:ss PM')
    and
    to_date('29-SEP-12 05.05.02 PM','dd-MON-yy hh:mi:ss PM')
and event = 'enq: TX - row lock contention'
and o.data_object_id = s.current_obj#
order by 1,2;

--
--
--Beginning Performance Tuning: Trace Your Steps By Arup Nanda
--
--
The above tuning techniques do not, however, show the timing of individual queries or the different execution steps in each query. To display those details, you need to trace the session. Tracing is the action of enabling a flag in Oracle Database that instructs the database to write the details of the activities inside a session to a text file on the server.

There are many ways you can enable tracing in sessions, but the easiest is to use the Oracle-provided and -recommended DBMS_MONITOR package.

To start the session trace, you first need to know the unique identifiers of the session: the SID and the serial#. Use the following query to find these identifiers in the v$session view:

select sid, serial# from v$session where username = 'SH';

begin
  dbms_monitor.session_trace_enable (
    session_id => <SID>, 
    serial_num => <serial#>, 
    waits      => true, 
    binds      => true
    plan_stat  => 'all_executions');
end;

Script to identify the trace file
select
   r.value                                ||'\diag\rdbms\ '||
   sys_context('USERENV','DB_NAME')       ||'\ '||
   sys_context('USERENV','INSTANCE_NAME') ||'\trace\ '||
   sys_context('USERENV','DB_NAME')       ||'_ora_'||p.spid||'.trc'
   as tracefile_name
from v$session s, v$parameter r, v$process p
where r.name = 'diagnostic_dest'
and s.sid = &1
and p.addr = s.paddr;

tkprof ann1_ora_11408.trc ann1_ora_11408.out sys=no waits=yes  aggregate=no width=180

If the query is executed twice then that will be captured twice in the raw trace file. The tkprof tool, by default, consolidates the metrics of both executions of a specific SQL statement into a single value. That�s why I included the AGGREGATE=NO parameter, which caused each occurrence of the query to be recorded separately in the output file.

tkprof output, part 1
... output truncated ...
SELECT     sum(s.amount_sold) AS dollars
  FROM     sales s
  ,        times t
  WHERE    s.time_id = t.time_id
  AND      t.calendar_month_desc = '1998-05'

call     count      cpu    elapsed      disk      query    current        rows
����� �������� �������� ���������� ��������� ���������� ���������� �����������
Parse        1     0.00       0.00         0          0          0           0
Execute      1     0.00       0.00         0          0          0           0
Fetch        2     0.00       0.01         0          3          0           1
����� �������� �������� ���������� ��������� ���������� ���������� �����������
total        4     0.00       0.01         0          3          0           1


Rows (1st) Rows (avg) Rows (max) Row Source Operation
���������� ���������� ���������� �������������������������������������������
         1          1          1 SORT AGGREGATE (cr=3 pr=0 pw=0 time=61 us)
         1          1          1  MAT_VIEW REWRITE ACCESS FULL CAL_MONTH_
                                  SALES_MV (cr=3 pr=0 pw=0 time=52 us cost=3 
                                  size=15 card=1)
COUNT. The number of times that type of call has been made.
ELAPSED. The total time of the call, including CPU. (This is the directly observable metric. The greater the elapsed time, the more time the session is taking.)
CPU. The total CPU time of the call.
QUERY. How many blocks were accessed (queried) by the call (whether from disk or buffer cache).
DISK. How many of those queried blocks came from the disk.

In the above example the DISK column value is shown as 0, meaning that the query got all of its blocks from the buffer cache without needing to go to the physical disk. The QUERY column shows the number of rows retrieved at that stage. In this case, three rows were retrieved.
                                  
The CLIENT_ID_TRACE procedure:
The trace will persist after a database restart and you�ll have to explicitly disable it.
DBMS_MONITOR.CLIENT_ID_TRACE_ENABLE(
 client_id    IN  VARCHAR2,
 waits        IN  BOOLEAN DEFAULT TRUE,
 binds        IN  BOOLEAN DEFAULT FALSE,
 plan_stat    IN  VARCHAR2 DEFAULT NULL);

exec DBMS_SESSION.SET_IDENTIFIER('this is a test');
exec DBMS_MONITOR.CLIENT_ID_TRACE_ENABLE('this is a test',true,true);
select TRACE_TYPE,PRIMARY_ID,WAITS,BINDS,PLAN_STATS from dba_enabled_traces;
exec DBMS_MONITOR.CLIENT_ID_TRACE_DISABLE('this is a test');

The SERV_MOD_ACT_TRACE procedure:
dbms_monitor.serv_mod_act_trace_enable(
service_name  IN VARCHAR2,
module_name   IN VARCHAR2 DEFAULT ANY_MODULE,
action_name   IN VARCHAR2 DEFAULT ANY_ACTION,
waits         IN BOOLEAN  DEFAULT TRUE,
binds         IN BOOLEAN  DEFAULT FALSE,
instance_name IN VARCHAR2 DEFAULT NULL,
plan_stat     IN VARCHAR2 DEFAULT NULL);

exec dbms_monitor.serv_mod_act_trace_enable('SYS$USERS', 'SQL*Plus', dbms_monitor.all_actions, TRUE, TRUE);

SQL> select TRACE_TYPE,PRIMARY_ID,QUALIFIER_ID1,QUALIFIER_ID2,WAITS,BINDS from dba_enabled_traces;

SQL>  exec dbms_monitor.serv_mod_act_trace_disable('SYS$USERS', 'SQL*Plus', dbms_monitor.all_actions);

Using TRCSESS to aggregate your trace files

When you use a client_id trace, or procedure which can generate more than one trace file you will have to aggregate the files in order to analyze them all at the same time. This is the purpose of the TRCSESS utility.

trcsess  [output=output_file_name]
         [session=session_id]
         [clientid=client_id]
         [service=service_name]
         [action=action_name]
         [module=module_name]
         [trace_files]

If I need to aggregate the traces I made for the client_id �this is a test�, I�ll use the following syntaxe

trcsess output=mytracefile.trc clientid='this is a test' *.trc
tkprof mytracefile.trc mytraceoutput.log

-----------------------------
APEX Guidelines

There�s a certain comfort in that: you have total control, and anything and everything that happens in the application is reflected right there in the characters you typed�and can change.

The downside of 100 percent coding for applications is that developers are generally much less productive and the resulting code is much less structured than application code developed with a RAD framework, such as Oracle Application Express (or Oracle JDeveloper). A framework means that you cannot help but build your application according to the rules and formats supported by the framework

Therefore, I am happy to trade off some loss of control for dramatic improvements in productivity and maintainability. When a framework can do a lot of work for you

I suggest following these guidelines when writing PL/SQL code in Oracle Application Express applications: 

The only SQL statements you should write in the Application Builder (the Oracle Application Express UI for building applications) are queries to populate reports and tables. Even then, you should simplify those queries as much as possible through use of views and, for some complex scenarios, table functions.
Avoid repetition of code whenever possible. This advice is not specific to Oracle Application Express; it is one of the most important guidelines for high-quality programming overall.
Keep the volume of code inside the Oracle Application Express application to a minimum. Move as much code as possible to PL/SQL packages.

Condition on the Reviewer Actions region 
DECLARE
   l_dummy   CHAR (1);
BEGIN
   SELECT 'x'
     INTO l_dummy
     FROM qdb_question_reviews qr, qdb_domain_reviewers_v dr
    WHERE     dr.user_id = :ai_user_id
          AND dr.domain_reviewer_id = qr.domain_reviewer_id
          AND qr.question_id = :p659_question_id;

   RETURN TRUE;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      RETURN FALSE;
   WHEN TOO_MANY_ROWS
   THEN
      RETURN TRUE;
END;

codes like this should be moved into the package  IS_REVIEWER_OR_AUTHOR .

FUNCTION is_reviewer_or_author
   RETURN BOOLEAN
IS
   l_dummy       CHAR (1);
   l_author_id   PLS_INTEGER;
BEGIN
   SELECT 'x'
     INTO l_dummy
     FROM qdb_question_reviews qr, qdb_domain_reviewers_v dr
    WHERE     dr.user_id = v ('ai_user_id')
          AND dr.domain_reviewer_id = qr.domain_reviewer_id
          AND qr.question_id = v ('p659_question_id');

   RETURN TRUE;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      SELECT qu.author_id
        INTO l_author_id
        FROM qdb_questions qu
       WHERE qu.question_id = v ('p659_question_id');

      RETURN l_author_id = v ('ai_user_id');
   WHEN TOO_MANY_ROWS
   THEN
      RETURN TRUE;
END; 


 And then I could call the function from Application Builder as 
IF qdb_review_mgr.is_reviewer_or_author 
THEN


There are, unfortunately, two big problems with this approach: 

1.If the name of the item ever changes, that name change will be �hidden� behind the literal and will not be felt until testing�runtime, that is�instead of compile time.
2.The person maintaining the application cannot tell by looking at the function call what it is dependent on and will have to open the package body and search out the code.

IS_REVIEWER_OR_AUTHOR function as parameterized function 
CREATE OR REPLACE FUNCTION is_reviewer_or_author (
   user_id_in          INTEGER,
   question_id_in   IN INTEGER)
   RETURN BOOLEAN
IS

Again, the back end of the PL/SQL Challenge application, which consists of more than 1,900 procedures and functions collected into 40 packages, offers an excellent example. One of the main packages, qdb_content (QDB, the application prefix for PL/SQL Challenge, stands for Quiz Database), manages content for quizzes. This package contains 180 procedures and functions (and the package body contains more than 6,800 lines of code


