As the number of concurrent users on your system begins to overwhelm the number of resources you have (memory,
CPU, and I/O), the ability to deploy parallel operations becomes questionable.

If the machine was not overwhelmed before
parallel execution, it almost certainly would be now.

Oracle Exadata Database Machine is a combined hardware/software offering by Oracle Corporation that takes parallel
operations to the next level. Oracle Exadata is a massively parallel solution to large database problems (on the order
of hundreds to thousands of terabytes, or more).

parallel explain plan
select * from table(dbms_xplan.display(null, null,'TYPICAL -ROWS -BYTES -COST'));
select * from table(dbms_xplan.display(null,null,'BASIC +PARALLEL'));

And remember, parallel query requires two things to be true. First, you need to have a large task to perform—for
example, a long-running query, the runtime of which is measured in minutes, hours, or days, not in seconds or
subseconds. This implies that parallel query is not a solution to be applied in a typical OLTP system, where you are not
performing long-running tasks. Enabling parallel execution on these systems is often disastrous.

Second, you need ample free resources such as CPU, I/O, and memory. If you are lacking in any of these, then
parallel query may well push your utilization of that resource over the edge, negatively impacting overall performance
and runtime.

Triggers are not s • upported during a PDML operation. This is a reasonable limitation in my
opinion, since triggers tend to add a large amount of overhead to the update, and you are
using PDML to go fast—the two features don’t go together.

create table t1
as
select object_id id, object_name text
from all_objects;

select num_rows from all_tables where table_name='T1';
returns null

We used DBMS_STATS to trick the optimizer into thinking that there are 10,000,000 rows in that input table and that it consumes 100,000 database blocks.

begin
dbms_stats.set_table_stats( user, 'T1', numrows=>10000000,numblks=>100000 );
end;
/

select num_rows from all_tables where table_name='T1';

returns 10000000

CREATE OR REPLACE TYPE t2_type AS OBJECT (
id number,
text varchar2(30),
session_id number
)
/

create or replace type t2_tab_type as table of t2_type
/

create or replace function parallel_pipelined(
    l_cursor in sys_refcursor )
return t2_tab_type
pipelined
parallel_enable ( partition l_cursor by any )
is
    l_session_id number;
    l_rec t1%rowtype;
begin
    select sid into l_session_id
    from v$mystat
    where rownum =1;
    
    loop
        fetch l_cursor into l_rec;
        exit when l_cursor%notfound;
    -- complex process here
        pipe row(t2_type(l_rec.id,l_rec.text,l_session_id));
    end loop;
    
    close l_cursor;
    
    return;
end;
/

create table t2(id varchar2(100), text varchar2(100), session_id varchar2(100));

insert /*+ append */
into t2(id,text,session_id)
select *
from table(parallel_pipelined
        (CURSOR(select /*+ parallel(t1) */ * from t1 )
        )
    )
/

select distinct session_id from t2; --default 8 sessions does not work in XE edition

truncate table t2;

insert /*+ append */
into t2(id,text,session_id)
select *
from table(parallel_pipelined
(CURSOR(select *
from t1 )
))
/

select distinct session_id from t2; -- one session 

truncate table t2;

insert /*+ append */
into t2(id,text,session_id)
select *
from table(parallel_pipelined
        (CURSOR(select /*+ parallel(t1 3) */ * from t1 )
        )
    )
/

select distinct session_id from t2; --3 sessions does not work in XE edition

truncate table t2;

DYI parallelism

  -- If there is an error, RESUME it for at most 2 times.
  L_try := 0;
  L_status := DBMS_PARALLEL_EXECUTE.TASK_STATUS('mytask');
  WHILE(l_try < 2 and L_status != DBMS_PARALLEL_EXECUTE.FINISHED) 
  LOOP
    L_try := l_try + 1;
    DBMS_PARALLEL_EXECUTE.RESUME_TASK('mytask');
    L_status := DBMS_PARALLEL_EXECUTE.TASK_STATUS('mytask');
  END LOOP;
 
  -- Done with processing; drop the task
  DBMS_PARALLEL_EXECUTE.DROP_TASK('mytask');

--
--Trial - 1
--
set timing on;
set serveroutput on;

drop table chunked_tab;
drop table source_tab;
drop procedure run_serial;

create table source_tab
parallel nologging
as select
    object_id,
    object_name
from user_objects;

Elapsed: 00:00:05.21

create table chunked_tab
(
    id          varchar2(100),
    text        varchar2(100),
    session_id  varchar2(100)
);

Elapsed: 00:00:00.06

create or replace procedure run_serial( p_lo_rid in rowid, p_hi_rid in rowid )
is
begin
    for x in ( 
        select 
        object_id id, 
        object_name text
        from source_tab
        where rowid between p_lo_rid and p_hi_rid
    )
    loop
        insert into chunked_tab (id, text, session_id )
        values ( x.id, x.text, sys_context( 'userenv', 'sessionid' ) );
    end loop;
end;
/


set serveroutput on;

begin
    dbms_parallel_execute.create_task('TRIAL_RUN');
    
    dbms_parallel_execute.create_chunks_by_rowid
    ( 
        task_name => 'TRIAL_RUN',
        table_owner => user,
        table_name => 'SOURCE_TAB',
        by_row => false,
        chunk_size => 10000 
    );
    
end;
/

select *
    from (
    select chunk_id, status, start_rowid, end_rowid
    from dba_parallel_execute_chunks
    where task_name = 'TRIAL_RUN'
    order by chunk_id
    )
where rownum <= 5
/


begin
    dbms_parallel_execute.run_task
        ( task_name => 'TRIAL_RUN',
        sql_stmt => 'begin run_serial( :start_id, :end_id ); end;',
        language_flag => DBMS_SQL.NATIVE,
        parallel_level => 4 );
end;
/

select session_id, count(*) from chunked_tab group by session_id

SESSION_ID	COUNT(*)
2688594	1001
2688592	1001
2688593	2144

--
--Trial -2
--

set timing on;
set serveroutput on;

create table source_tab
parallel nologging
as select
    object_id,
    object_name
from user_objects;


create global temporary  table source_gtt on commit preserve rows as select * from source_tab ;

select count(*) from source_gtt;

create table chunked_tab
(
    id          varchar2(100),
    text        varchar2(100),
    session_id  varchar2(100)
);


create or replace procedure run_serial_2( p_lo_rid in rowid, p_hi_rid in rowid )
is
begin
    for x in ( 
        select 
        object_id id, 
        object_name text
        from source_gtt
        where rowid between p_lo_rid and p_hi_rid
    )
    loop
        insert into chunked_tab (id, text, session_id )
        values ( x.id, x.text, sys_context( 'userenv', 'sessionid' ) );
    end loop;
end;
/

truncate table chunked_tab;

begin
    dbms_parallel_execute.drop_task('TRIAL_RUN_2');
end;
/

begin
    dbms_parallel_execute.create_task('TRIAL_RUN_2');
    
    dbms_parallel_execute.create_chunks_by_rowid
    ( 
        task_name => 'TRIAL_RUN_2',
        table_owner => user,
        table_name => 'SOURCE_TAB',
        by_row => false,
        chunk_size => 1000 
    );
    
end;
/

select *
    from (
    select chunk_id, status, start_rowid, end_rowid
    from dba_parallel_execute_chunks
    where task_name = 'TRIAL_RUN_2'
    order by chunk_id
    )
where rownum <= 5
/


begin
    dbms_parallel_execute.run_task
        ( task_name => 'TRIAL_RUN_2',
        sql_stmt => 'begin run_serial_2( :start_id, :end_id ); end;',
        language_flag => DBMS_SQL.NATIVE,
        parallel_level => 4 );
end;
/

select session_id, count(*) from chunked_tab group by session_id;

No rows returned;

drop procedure run_serial_2;
drop table chunked_tab;
drop table source_gtt;
drop table source_tab;

--
-- Trial-3
--

set timing on;
set serveroutput on;

create table source_tab
parallel nologging
as select
    object_id,
    object_name
from user_objects;

create global temporary  table chunking_tab
(
    id          number
)
on commit preserve rows;

create table chunked_tab
(
    id          varchar2(100),
    text        varchar2(100),
    session_id  varchar2(100)
);

create or replace procedure run_serial_3( p_lo_rid in number, p_hi_rid in number )
is
begin
    for x in ( 
        select 
        object_id id, 
        object_name text
        from source_tab
        where object_id between p_lo_rid and p_hi_rid
    )
    loop
        insert into chunked_tab (id, text, session_id )
        values ( x.id, x.text, sys_context( 'userenv', 'sessionid' ) );
    end loop;
end;
/


insert into chunking_tab select object_id from source_tab;


begin
    dbms_parallel_execute.drop_task('TRIAL_RUN_3');
end;
/

begin
    dbms_parallel_execute.create_task('TRIAL_RUN_3');
    
    dbms_parallel_execute.create_chunks_by_number_col(
        task_name    => 'TRIAL_RUN_3',
        table_owner  => user,
        table_name   => 'CHUNKING_TAB',
        table_column => 'ID',
        chunk_size   => 1000);
    
end;
/

select *
    from (
    select chunk_id, status, start_rowid, end_rowid
    from dba_parallel_execute_chunks
    where task_name = 'TRIAL_RUN_3'
    order by chunk_id
    )
where rownum <= 5;

select count(*) from source_tab;
select count(*) from chunking_tab;
select count(*) from chunked_tab;

begin
    dbms_parallel_execute.run_task
        ( task_name => 'TRIAL_RUN_3',
        sql_stmt => 'begin run_serial_3( :start_id, :end_id ); end;',
        language_flag => DBMS_SQL.NATIVE,
        parallel_level => 4 );
end;
/

select count(*) from source_tab;
select count(*) from chunking_tab;
select count(*) from chunked_tab;


select session_id, count(*) from chunked_tab group by session_id;

SESSION_ID	COUNT(*)
2688594	1001
2688592	1001
2688593	2144


drop table chunked_tab;
drop table chunking_tab;
drop table source_tab;
drop procedure run_serial_3;

begin
    dbms_parallel_execute.drop_task('TRIAL_RUN_3');
end;
/
