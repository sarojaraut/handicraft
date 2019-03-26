@C:C:\Saroj\DBMS_HPROF\dbmshptab.sql

C:\app\DatapumpDir

create directory DP_DIR as 'C:\Saroj\DBMS_HPROF'

grant read, write on directory DP_DIR to hr

create procedure proc3 as
    v_var int;
begin
    for i in 1..1000 loop
       select i into v_var from dual;
    end loop;
end;
/

create procedure proc2 as
begin
    for i in 1..100 loop
       proc3; -- execute proc3
    end loop;
end;
/

create procedure proc1 as
begin
    for i in 1..10 loop
       proc2; -- execute proc2
    end loop;
end;
/
grant execute on DBMS_HPROF to hr;

BEGIN
  DBMS_HPROF.start_profiling (location => 'DP_DIR', filename => 'Sample_hprof.txt');
  proc1; 
  DBMS_HPROF.stop_profiling;
END;
/

set serveroutput on;

DECLARE
  v_runid  NUMBER;
BEGIN
  v_runid := DBMS_HPROF.analyze (
               location    => 'DP_DIR',
               filename    => 'Sample_hprof_2.txt',
               run_comment => 'Sample run-2');
  DBMS_OUTPUT.put_line('Run Id Information=' || v_runid);
END;
/


78419285 micro second =  00:01:18.08

P#V : PLSHPROF banner with version number
P#C : Call to a subprogram (call event)
P#R : Return from a subprogram (return event)
P#X : Elapsed time between preceding and following events
P#! : Comment

Function Names of Operations that the PL/SQL Hierarchical Profiler Tracks
Tracked Operation  : Function Name : Namespace
Call to PL/SQL Virtual Machine : __plsql_vm : PL/SQL
PL/SQL anonymous block : __anonymous_block : PL/SQL
Package initialization block : __pkg_init : PL/SQL
Static SQL statement at line line# : __static_sql_exec_lineline# : SQL
Dynamic SQL statement at line line# : __dyn_sql_exec_lineline# : SQL
SQL FETCH statement at line line# : __sql_fetch_lineline# :SQL

C:\app\oracle\product\12.1.0\dbhome_1\BIN\plshprof -output C:\app\DatapumpDir\output_html_format C:\app\DatapumpDir\Sample_hprof_2.txt

/apps/software/oracle/11.2.0.3/bin/plshprof -output /home/dev/itsr/output_html_format /home/dev/itsr/Sample_hprof_2.txt

DBMSHP_RUNS : Top-level information for this run of DBMS_HPROF.analyze.
	TOTAL_ELAPSED_TIME : Total elapsed time for this run of DBMS_HPROF.analyze.
DBMSHP_FUNCTION_INFO : Information for each subprogram profiled in this run of DBMS_HPROF.analyze.
	MODULE : Module in which subprogram is defined (for example, DBMS_LOB, UTL_HTTP, or MY_PACKAGE).
	FUNCTION : Name of subprogram (not necessarily a function) (for example, INSERT_ORDER, PROCESS_ITEMS, or TEST). This name might be one of the special function names in Section 13.3.2. For subprogram B defined within subprogram A, this name is A.B. A recursive call to function X is denoted X@n, where n is the recursion depth. For example, X@1 is the first recursive call to X.
	SUBTREE_ELAPSED_TIME : Elapsed time, in microseconds, for subprogram, including time spent in descendant subprograms.
	FUNCTION_ELAPSED_TIME : Elapsed time, in microseconds, for subprogram, excluding time spent in descendant subprograms.
	CALLS : Number of calls to subprogram.
DBMSHP_PARENT_CHILD_INFO : Parent-child information for each subprogram profiled in this run of DBMS_HPROF.analyze. For column descriptions, see Table 13–6 on page 13-8.

DBMS_HPROF.START_PROFILING (
   location    VARCHAR2 DEFAULT NULL,
   filename    VARCHAR2 DEFAULT NULL,
   max_depth   PLS_INTEGER DEFAULT NULL);
   
By default (that is, when max_depth value is NULL) profile information is gathered for all functions irrespective of their call depth. When a non-NULL value is specified for max_depth, the profiler collects data only for functions up to a call depth level of max_depth.

DBMS_HPROF.STOP_PROFILING;

ANALYZE Function
This function analyzes the raw profiler output and produces hierarchical profiler information in database tables.

DBMS_HPROF.ANALYZE (
   location         VARCHAR2,
   filename         VARCHAR2,
   summary_mode     BOOLEAN     DEFAULT FALSE,
   trace            VARCHAR2    DEFAULT NULL,
   skip             PLS_INTEGER DEFAULT 0,
   collect          PLS_INTEGER DEFAULT NULL,
   run_comment      VARCHAR2    DEFAULT NULL)
  RETURN NUMBER;

A unique run identifier for this run of the analyzer. This can then be used to look up the results corresponding to this run from the hierarchical profiler tables.

Use the dbmshptab.sql script located in the rdbms/admin directory to create the hierarchical profiler database tables and other data structures required for persistently storing the results of analyzing the raw profiler data.

Running dbmshptab.sql drops the any previously created hierarchical profiler tables.

https://docs.oracle.com/cd/B28359_01/appdev.111/b28424/adfns_profiler.htm

select * from
dbmshp_runs

select * from
dbmshp_parent_child_info

select * from
dbmshp_function_info where runid = 2

SELECT RPAD(' ', level*2, ' ') || fi.owner || '.' || fi.module AS name,
       fi.function,
       pci.subtree_elapsed_time,
       pci.function_elapsed_time,
    pci.calls
FROM   dbmshp_parent_child_info pci
       JOIN dbmshp_function_info fi ON pci.runid = fi.runid AND pci.childsymid = fi.symbolid
WHERE  pci.runid = 2
CONNECT BY PRIOR childsymid = parentsymid 
START WITH pci.parentsymid = 1; 

SELECT 
    parent_info.owner || '.' || parent_info.module || '.' ||
    parent_info.function || '(' || parent_info.line# || ')' caller,
    child_info.owner || '.' || child_info.module || '.' ||
    child_info.function || '(' || child_info.line# || ')' callee,
    child_info.function_elapsed_time elapsed
FROM dbmshp_parent_child_info dpci
    JOIN dbmshp_function_info parent_info
        ON parent_info.runid = dpci.runid
    JOIN dbmshp_function_info child_info
        ON child_info.runid = dpci.runid
WHERE dpci.runid = :HPROF_RUNID
START WITH dpci.runid = :HPROF_RUNID
    AND dpci.childsymid = child_info.symbolid
    AND dpci.parentsymid = parent_info.symbolid
    AND parent_info.symbolid =1
CONNECT BY dpci.runid = PRIOR dpci.runid
    AND dpci.childsymid = child_info.symbolid
    AND dpci.parentsymid = parent_info.symbolid
    AND prior dpci.childsymid = dpci.parentsymid;

Advanced Oracle PL/SQL Developers Guide

You can use the PL/SQL hierarchical profiler to identify bottlenecks and performance-tuning opportunities in PL/SQL applications.
No compile-time preparation is required, any PL/SQL program can be profiled.

Nonhierarchical (flat) profilers record the time that a program spends within each subprogram—the function time or self time of each subprogram. Function time is helpful, but often inadequate. For example, it is helpful to know that a program spends 40% of its time in the subprogram INSERT_ORDER, but it is more helpful to know which subprograms call INSERT_ORDER often and the total time the program spends under INSERT_ORDER (including its descendant subprograms). Hierarchical profilers provide such information.

Stop coding multitable inserts manually. Why send multiple DML statements to the server when an action can be performed in a single multitable insert?
Stop using UTL_FILE to read text files if you can external tables.
Stop using PL/SQL when you could use SQL
Stop using pass-by-value (NOCOPY)
The easiest way to improve the speed of doing something is to avoid doing it in the first place.

The first sentence in the first chapter of the PL/SQL documentation states the following.

"PL/SQL, the Oracle procedural extension of SQL, is a portable, high-performance transaction-processing language."

So PL/SQL is an extension to SQL, not a replacement for it. In the majority of cases, a pure SQL solution will perform better than one made up of a combination of SQL and PL/SQL. Remember, databases are designed to work with sets of data. As soon as you start to process data in a row-by-row (or slow-by-slow) manner, you are stopping the database from doing what it does best. With that in mind, a PL/SQL programmer should aim to be an expert in SQL that knows a bit of PL/SQL, rather than an expert in PL/SQL that knows a little bit of SQL.

SQL has evolved greatly over the last 20 years. The introduction of features like analytic functions and SQL/XML mean you can perform very complex tasks directly from SQL. The following points describe some of the common situations where people use PL/SQL when SQL would be more appropriate.





