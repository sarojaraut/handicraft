Genaral Guide lines

Choose proper table :
    heap table : default use unless any compelling reason to use other 
    partitioned table : for large data set, making use of partition pruning, easier data purge 
    mv : for storing pre computed data 
    choose appropriate pctfree for tables which are heavily updated with more data later
    define fk where appropriate this gives usefull insight to optimiser along with data integrity
    global temporary tables for avoiding redo generation 
maximise data loading speed : make table as no logging and use append and append_values hint as appropriate ctas 
efficient data removal : truncate table, alter table f_sales truncate partition p_2012;
--
analyze table emp list chained rows;
create table temp_emp
as select *
from emp
where rowid in
(select head_rowid from chained_rows where table_name = 'EMP');
delete from emp
where rowid in
(select head_rowid from chained_rows where table_name = 'EMP');
insert into emp select * from temp_emp;
select count(*) from user_extents where segment_name='EMP';
ALTER TABLE...SHRINK SPACE or truncate table 
alter table emp enable row movement;
alter table emp shrink space;
alter table emp shrink space cascade; -- shrink space for index as well
--
sometimes we need to enable/disble constraint for loading very large volume of data, make sure to create index separately in that case so that we can drop/disable constraint without loosing the index or rebuilding the index.
compress indexes whereever applicable : create index cust_cidx1 on cust(last_name, first_name) compress 1; -- last_name are mostly repeated
bitmap index on foreign key columns and may disable them during data loading
faster index creation with no logging
avoid accidental full table scan by applying any function on indexed column trunc or to_char or lower 
--
use pipelined function for returning complex dataset 
use plsql associative array for faster look up 
identify plsql that needs to be pinned 
use identity columns wherever possible 
leverage plsql reslt cache 
avoid not clause in sql wherever possible not might lead to unwanted fulltable scan
--
alter table sales cache;
alter system flush buffer_cache; -- only do it dev/test
When a query with RESULT_CACHE hint is run, Oracle will see if the results of the query have already been executed, computed, and cached, and, if so, retrieve the data from the cache instead of querying the data blocks and computing the results again. Take the following important points into consideration before using this feature: useful only for SQL queries that are executed frequently and data does not change
hint index (tab_name index_name)
exists runs faster than in : exists return as soon as it find a single matching row as opposed to in which retrieves all rows

-------------Quick Notes
exec DBMS_SESSION.SET_IDENTIFIER('this is a test');
exec DBMS_MONITOR.CLIENT_ID_TRACE_ENABLE('this is a test',true,true);
select TRACE_TYPE,PRIMARY_ID,WAITS,BINDS,PLAN_STATS from dba_enabled_traces;
exec DBMS_MONITOR.CLIENT_ID_TRACE_DISABLE('this is a test');
--
begin
  dbms_monitor.session_trace_enable (
    session_id => <SID>, 
    serial_num => <serial#>, 
    waits      => true, 
    binds      => true
    plan_stat  => 'all_executions');
end;
--
ALTER SESSION SET sql_trace=TRUE;
--
set autotrace traceonly explain
autotrace on explain 
--
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
--
SELECT trace_filename
FROM   v$diag_trace_file
WHERE  con_id = 3;
--
select * from v$diag_info;
--
SELECT p.tracefile
FROM   v$session s
JOIN v$process p ON s.paddr = p.addr
WHERE  s.sid = 635;
--v$active_session_history
dba_hist_active_sess_history

Samples of wait event information are taken once per second and made available using the V$ACTIVE_SESSION_HISTORY view. An active session is one that is waiting on CPU or any event that does not belong to the "Idle" wait class at the time of the sample. The sample information is written to a circular buffer in the SGA, so the greater the database activity, the less time the information will remain available for.
session id, serial number, sql id, session state, wait time

SELECT NVL(a.event, 'ON CPU') AS event,
       COUNT(*) AS total_wait_time
FROM   v$active_session_history a
WHERE  a.sample_time > SYSDATE - 5/(24*60) -- 5 mins
GROUP BY a.event
ORDER BY total_wait_time DESC;

call     count   cpu elapsed disk      query    current         rows
------- ------  ------ ---------- -- ---------- ----------   --------
Parse        1  0.00   0.00   0          0          0            0
Execute      1  0.00   0.00   0          0          0            0
Fetch    17322  1.82   1.85   3        136          5       259806
------- ------  -------- -------- -- ---------- ---------- ----------
total    17324  1.82   1.85   3        136          5       259806

TK Prof takeaway
parsing numbers are high : use bind variable or increase shared_pool_size
parse elapsed time is high : may be problem with the number of open cursors
disk reads are high : indexes are not being used or index absent
query/current reads are high : indexes may be on lowe cardinality column, use histogram, poor join order etc 
Number of rows processed is very high compared to number of rows returned : could be poorly written query or poor execution plan picked by optimiser because of lack of dbms_application_info

select disk_reads, sql_text from v$sqlarea

ANALYZE INDEX index_name VALIDATE STRUCTURE;
SELECT HEIGHT, DEL_LF_ROWS, LF_ROWS, LF_BLKS FROM INDEX_STATS;
If the value for DEL_LF_ROWS/LF_ROWS is greater than 2, or LF_ROWS is lower than LF_BLKS, or HEIGHT is 4 then the index should be rebuilt.

exec dbms_Stats.gather_table_stats(
     ownname=>null,-
     tabname=>'customers',-
     method_opt=>'for all columns size skewonly,-
     for columns (cust_state_province,country_id) size skewonly');
     
exec dbms_stats.gather_table_stats(null,'customers',
     method_opt=>'for all columns size skewonly,
     for columns (lower(cust_state_province)) size skewonly');

Nested Loops
If you're joining small subsets of data, the nested loop (NL) method is ideal. If you're returning fewer than, say, 10,000 rows, the NL join may be the right join method. If the optimizer is using hash joins or full table scans, force it to use the NL join method by using the following hint:
SELECT /*+ USE_NL (TableA, TableB) */

Hash Join
If the join will produce large subsets of data or a substantial proportion of a table is going to be joined, use the hash join hint if the optimizer indicates it isnt going to use it:
SELECT /* USE_HASH */

Merge Join
If the tables in the join are being joined with an inequality condition (not an equi join), the merge join method is ideal:
SELECT /*+ USE_MERGE (TableA, TableB) */

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

