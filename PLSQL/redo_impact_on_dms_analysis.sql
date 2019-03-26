DMS Task Name : chris-dms-test-2
replication instance - chris-test-dms-latency-1
RDS Instance : chris-dms-latency-test


--DBA's create a separate tablespace for this experiment

select  a.tablespace_name,
       round(a.bytes_alloc / 1024 / 1024) megs_alloc,
       round(nvl(b.bytes_free, 0) / 1024 / 1024) megs_free,
       round((a.bytes_alloc - nvl(b.bytes_free, 0)) / 1024 / 1024) megs_used,
       round((nvl(b.bytes_free, 0) / a.bytes_alloc) * 100) Pct_Free,
       100 - round((nvl(b.bytes_free, 0) / a.bytes_alloc) * 100) Pct_used,
       round(maxbytes/1048576) Max
from  ( select  f.tablespace_name,
               sum(f.bytes) bytes_alloc,
               sum(decode(f.autoextensible, 'YES',f.maxbytes,'NO', f.bytes)) maxbytes
        from dba_data_files f
        group by tablespace_name) a,
      ( select  f.tablespace_name,
               sum(f.bytes)  bytes_free
        from dba_free_space f
        group by tablespace_name) b
where a.tablespace_name = b.tablespace_name (+)
and a.tablespace_name like 'REDO_CLEANUP%'

drop table redo_test_first;

select a.name, b.value from v$statname a, v$mystat b where a.statistic# = b.statistic# and a.name = 'redo size' -- 14836

create table REDO_TEST_FIRST(
 id               number
,name             char(2000)
,description      char(2000)
,created_dt       timestamp
,updated_dt       timestamp
,update_count     number
,rand_hash        number
,createdtime      timestamp
,updatedtime      timestamp
);

create sequence redo_test_seq start with 50001 increment by 1;

create unique index redo_test_first_idx_id on redo_test_first(id) nologging parallel;

--create index redo_test_first_sup_cols on redo_test_first(created_dt, updated_dt, update_count, rand_hash) nologging parallel;

alter table redo_test_first add primary key(id) using index redo_test_first_idx_id;

alter table redo_test_first modify (updated_dt not null);

ALTER TABLE itsr.redo_test_first ADD SUPPLEMENTAL LOG GROUP dms_log_group (ID) ALWAYS; 

alter table itsr.redo_test_first add supplemental log data (primary key) columns;

select a.name, b.value from v$statname a, v$mystat b where a.statistic# = b.statistic# and a.name = 'redo size' -- 325133960

select
    count(*) total_row_count, 
    sum(rand_hash) total_hash_value, 
    sum(update_count) update_count, 
    max(created_dt) last_create_time, 
    max(updated_dt) last_update_time  
from REDO_TEST_FIRST

select * from dba_segments where segment_name='redo_test_first' -- 65536

insert into redo_test_first
select 
rownum
,'Name_'||rownum
,'Desc_'||rownum
,sysdate
,sysdate
,rownum
,rownum
from dual
connect by rownum <=100000 -- 33 sec

select a.name, b.value from v$statname a, v$mystat b where a.statistic# = b.statistic# and a.name = 'redo size' -- 230554376

commit

-- Procedure for Generating specified amount of redo
create or replace function redo_generator(
    i_amount_in_mb     number
)
return number
is
    l_actual_redo       number;
    l_50mb_rec_count    number := 3500;
    l_intial_undo_size  number;
    l_final_undo_size   number;
    
begin

    select b.value 
    into   l_intial_undo_size
    from sys.v_$statname a, sys.v_$mystat b 
    where a.statistic# = b.statistic# 
        and a.name = 'redo size';

    for i in 1..(ceil(i_amount_in_mb/50)*50)/50
    loop
        insert into redo_test_first
        (
            id
            ,name
            ,description
            ,created_dt
            ,updated_dt
            ,update_count
            ,rand_hash
        )
        select 
             redo_test_seq.nextval                 id
            ,rpad('Name_'||rownum,2000,'_')        name
            ,rpad('Desc_'||rownum,2000,'_')        description
            ,systimestamp                          created_dt
            ,systimestamp                          updated_dt
            ,0                                     update_count
            ,dbms_random.value(1,100)
        from dual
        connect by rownum <= 3500;
        
        delete from redo_test_first where rownum <= 3499;
        
        update redo_test_first 
        set description = rpad(trim(description) ||'_'||update_count,2000,'_') ,
            update_count = update_count + 1,
            updated_dt  = systimestamp,
            rand_hash = dbms_random.value(1,100)
        where rownum <= 3500;
        
        commit; -- For creating more transactions      
        
    end loop;

    select b.value 
    into   l_final_undo_size
    from sys.v_$statname a, sys.v_$mystat b 
    where a.statistic# = b.statistic# 
        and a.name = 'redo size';
        
    return round((l_final_undo_size - l_intial_undo_size) /(1024*1024),2);        

exception
    when others then 
    dbms_output.put_line(sqlerrm);
    rollback;
end;
/

set serveroutput on;
declare
    l_amount_redo    number;
begin
    l_amount_redo := redo_generator(2048);
    dbms_output.put_line('Amount Redo Generated :'||l_amount_redo);
end;
/

begin
    dbms_stats.gather_schema_stats(
    ownname          => 'ITSR',
    options          => 'GATHER AUTO', 
    estimate_percent => dbms_stats.auto_sample_size
    );
end;
/

select trunc(first_time),sum(blocks*block_size) 
from (select distinct first_change#,first_time,blocks,block_size,completion_time
from v$archived_log) 
group by trunc(first_time) 
order by trunc(first_time); 

insert into redo_test_first
(
    id
    ,name
    ,description
    ,created_dt
    ,updated_dt
    ,update_count
    ,rand_hash
)
select /*+parallel */
    redo_test_seq.nextval                 id
    ,rpad('Name_'||rownum,2000,'_')        name
    ,rpad('Desc_'||rownum,2000,'_')        description
    ,systimestamp                          created_dt
    ,systimestamp                          updated_dt
    ,0                                     update_count
    ,dbms_random.value(1,100)              rand_hash
from dual
connect by rownum <=1000000;

alter table redo_test_first_1 add (CreatedTime timestamp, UpdatedTime timestamp);

select * from dba_segments where segment_name='REDO_TEST_FIRST_1'

create unique index redo_test_first_1_idx_id on redo_test_first_1(id) nologging parallel;

drop index redo_test_first_1_sup_cols;

create index redo_test_first_1_sup_cols on redo_test_first_1(created_dt, updated_dt, update_count, rand_hash) nologging parallel;

alter table redo_test_first_1 add primary key(id) using index redo_test_first_1_idx_id;

delete from redo_test_first_1;

commit;

alter table itsr.redo_test_first_1 add supplemental log data (primary key) columns; 

alter table redo_test_first add (CreatedTime timestamp, UpdatedTime timestamp);

set timing on;

select b.value 
from sys.v_$statname a, sys.v_$mystat b 
where a.statistic# = b.statistic# 
and a.name = 'redo size';

select max(id) from redo_test_first; -- 8347740

-- Insert into Source Table
insert into redo_test_first
(
    id
    ,name
    ,description
    ,created_dt
    ,updated_dt
    ,update_count
    ,rand_hash
)
select 
     redo_test_seq.nextval                 id
    ,'Name_'||rownum                       name
    ,'Desc_'||rownum                       description
    ,systimestamp                          created_dt
    ,systimestamp                          updated_dt
    ,0                                     update_count
    ,dbms_random.value(1,100)
from dual
connect by rownum <= 100000;

commit;

-- Measuring REDO generated
select b.value 
from sys.v_$statname a, sys.v_$mystat b 
where a.statistic# = b.statistic# 
and a.name = 'redo size';

UPDATE REDO_TEST_FIRST 
SET 
    NAME = RPAD(TRIM(NAME),2000,'*'),
    DESCRIPTION = RPAD(TRIM(DESCRIPTION),2000,'*'),
    RAND_HASH = dbms_random.value(1,100)
WHERE ID > 8047740;

COMMIT;

select b.value 
from sys.v_$statname a, sys.v_$mystat b 
where a.statistic# = b.statistic# 
and a.name = 'redo size';

UPDATE REDO_TEST_FIRST 
SET 
    NAME = RPAD(TRIM(NAME),2000,'*'),
    DESCRIPTION = RPAD(TRIM(DESCRIPTION),2000,'*'),
    RAND_HASH = dbms_random.value(1,100)
WHERE ID between 7747723 and 7847723;

COMMIT;

UPDATE REDO_TEST_FIRST 
SET 
    NAME = RPAD(TRIM(NAME),2000,'*'),
    DESCRIPTION = RPAD(TRIM(DESCRIPTION),2000,'*'),
    RAND_HASH = dbms_random.value(1,100)
WHERE ID between 7847723 and 7947723;

COMMIT;

UPDATE REDO_TEST_FIRST 
SET 
    NAME = RPAD(TRIM(NAME),2000,'*'),
    DESCRIPTION = RPAD(TRIM(DESCRIPTION),2000,'*'),
    RAND_HASH = dbms_random.value(1,100)
WHERE ID between 7947723 and 8047723;

COMMIT;

-- Measuring REDO generated
select b.value 
from sys.v_$statname a, sys.v_$mystat b 
where a.statistic# = b.statistic# 
and a.name = 'redo size';

COLUMN value FORMAT 999999999999999

-- Oracle Query
SELECT
    COUNT(*)             TOTAL_ROW_COUNT, 
    SUM(RAND_HASH)       TOTAL_HASH_VALUE, 
    SUM(UPDATE_COUNT)    UPDATE_COUNT, 
    MAX(CREATED_DT)      LAST_CREATE_TIME_SRC, 
    MAX(CREATEDTIME)     LAST_CREATE_TIME_TGT, 
    MAX(UPDATED_DT)      LAST_UPDATE_TIME_SRC,
    MAX(UPDATEDTIME)     LAST_UPDATE_TIME_TGT
FROM REDO_TEST_FIRST

SELECT
    COUNT(*)                                       TOTAL_ROW_COUNT, 
    SUM(RAND_HASH)                                 TOTAL_HASH_VALUE, 
    SUM(UPDATE_COUNT)                              UPDATE_COUNT, 
    MAX(CREATED_DT)                                LAST_CREATE_TIME_SRC, 
    DATE_ADD(MAX(CREATEDTIME), INTERVAL 1 HOUR)    LAST_CREATE_TIME_TGT, 
    MAX(UPDATED_DT)                                LAST_UPDATE_TIME_SRC,
    DATE_ADD(MAX(UPDATEDTIME), INTERVAL 1 HOUR)    LAST_UPDATE_TIME_TGT
FROM ITSR.REDO_TEST_FIRST

-- Number of log switches
SELECT to_char(first_time, 'yyyy/mm/dd') aday,
           to_char(first_time, 'hh24') hour,
           count(*) total
FROM   v$log_history
WHERE first_time > trunc(sysdate-1)
GROUP BY to_char(first_time, 'yyyy/mm/dd'),
              to_char(first_time, 'hh24')
ORDER BY to_char(first_time, 'yyyy/mm/dd'),
              to_char(first_time, 'hh24') asc
      
-- Size of Redo Generated        
SELECT  
    Start_Date,   
    Start_Time,   
    Num_Logs,
    Round(Num_Logs * (Vl.Bytes / (1024 * 1024)),2) AS Mbytes, 
    Vdb.NAME AS Dbname
FROM (
        SELECT 
        To_Char(Vlh.First_Time, 'YYYY-MM-DD') AS Start_Date,
        To_Char(Vlh.First_Time, 'HH24') || ':00' AS Start_Time, COUNT(Vlh.Thread#) Num_Logs
        FROM V$log_History Vlh 
        WHERE first_time > trunc(sysdate-1)
        GROUP BY To_Char(Vlh.First_Time,  'YYYY-MM-DD'),
        To_Char(Vlh.First_Time, 'HH24') || ':00'
    ) Log_Hist,
    V$log Vl ,  
    V$database Vdb
WHERE Vl.Group# = 1
ORDER BY Log_Hist.Start_Date, Log_Hist.Start_Time;

------

set timing on;

declare
	l_scope	             varchar2(100) := 'Redo Generation Process-2 (GB) - 60';
	l_max_id             number;
	l_big_batch_size     number        := 100000;
	i_initial_redo_size  number;
	i_last_redo_size     number;
	i_total_iteration    number        :=50;  -- 1 iteration= 1.3 Gig
	l_text               varchar2(32767);
begin
	logger.log_info (
		p_text    => 'Start'
		,p_scope  => l_scope
		);
		
	select max(id) into l_max_id from redo_test_first;
	
	select b.value 
	into i_initial_redo_size
	from sys.v_$statname a, sys.v_$mystat b 
	where a.statistic# = b.statistic# 
	and a.name = 'redo size';
	
	for l_iteration in 1..i_total_iteration
	loop
	
		insert into redo_test_first
		(
			id
			,name
			,description
			,created_dt
			,updated_dt
			,update_count
			,rand_hash
		)
		select 
			 redo_test_seq.nextval                 id
			,'Name_'||rownum                       name
			,'Desc_'||rownum                       description
			,systimestamp                          created_dt
			,systimestamp                          updated_dt
			,0                                     update_count
			,dbms_random.value(1,100)
		from dual
		connect by rownum <= l_big_batch_size;
		l_text := sql%rowcount||' Records Inserted - Iteration = '||l_iteration;
		commit;
		
		logger.log_info (
			p_text    => l_text
			,p_scope  => l_scope
			);
	
	end loop;
	
	for l_iteration in 1..i_total_iteration
	loop
	
		update redo_test_first 
		set 
			name = rpad(trim(name),2000,'*'),
			description = rpad(trim(description),2000,'*'),
			rand_hash = dbms_random.value(1,100)
		where id between (l_max_id + (l_iteration-1) * l_big_batch_size + 1) 
						and (l_max_id + (l_iteration * l_big_batch_size));
						
		l_text := sql%rowcount||' Records Updated - Iteration = '||l_iteration;
		commit;
	
		logger.log_info (
			p_text    => l_text
			,p_scope  => l_scope
			);
	
	end loop;
	
	select b.value 
	into i_last_redo_size
	from sys.v_$statname a, sys.v_$mystat b 
	where a.statistic# = b.statistic# 
	and a.name = 'redo size';

	logger.log_info (
		p_text    => 'End : Redo Generated(MB) = '|| round((i_last_redo_size - i_initial_redo_size)/(1024*1024),3)
		,p_scope  => l_scope
		);
		
exception
	when others then
		logger.log_error (
			p_text   => 'Failure!!',
			p_scope  => l_scope
			);
	
end;
/

select text, time_stamp,time_stamp-lag(time_stamp)over(partition by scope order by id) time_taken, call_stack, extra
from logger_logs where scope='redo generation process(gb) - 60' order by id desc

-- Deleting Records

set timing on;

declare
	l_scope	             varchar2(100) := 'Delete from redo_test_first';
	l_max_id             number;
	l_big_batch_size     number        := 100000;
	i_initial_redo_size  number;
	i_last_redo_size     number;
	i_total_iteration    number        :=50;  -- 1 iteration= 1.3 Gig
	l_text               varchar2(32767);
begin
	logger.log_info (
		p_text    => 'Start'
		,p_scope  => l_scope
		);
	
	select b.value 
	into i_initial_redo_size
	from sys.v_$statname a, sys.v_$mystat b 
	where a.statistic# = b.statistic# 
	and a.name = 'redo size';
	
	for l_iteration in 1..i_total_iteration
	loop
	
		delete from redo_test_first where rownum <= l_big_batch_size;
		l_text := sql%rowcount||' Records Deleted - Iteration = '||l_iteration;
		commit;
		
		logger.log_info (
			p_text    => l_text
			,p_scope  => l_scope
			);
	
	end loop;
	
	select b.value 
	into i_last_redo_size
	from sys.v_$statname a, sys.v_$mystat b 
	where a.statistic# = b.statistic# 
	and a.name = 'redo size';

	logger.log_info (
		p_text    => 'End : Redo Generated(MB) = '|| round((i_last_redo_size - i_initial_redo_size)/(1024*1024),3)
		,p_scope  => l_scope
		);
		
exception
	when others then
		logger.log_error (
			p_text   => 'Failure!!',
			p_scope  => l_scope
			);
	
end;
/

select text, time_stamp,time_stamp-lag(time_stamp)over(partition by scope order by id) time_taken, call_stack, extra
from logger_logs where scope= lower('Delete from redo_test_first') order by id desc

------
--
-- My SQL Query
--

/*
SELECT
    MAX(TIMESTAMPDIFF(SECOND, CREATED_DT, 
        (DATE_ADD(CREATEDTIME, INTERVAL 1 HOUR)))
    )                                               CREATE_LAG,
    MAX(TIMESTAMPDIFF(SECOND, UPDATED_DT, 
        (DATE_ADD( UPDATEDTIME ,INTERVAL 1 HOUR)))
    )                                               UPDATE_LAG,
    COUNT(*)                                       TOTAL_ROW_COUNT, 
    SUM(RAND_HASH)                                 TOTAL_HASH_VALUE 
FROM ITSR.REDO_TEST_FIRST;

SELECT * FROM ITSR.REDO_TEST_FIRST where ID between 6047724 and 6147724;

DROP TRIGGER IF EXISTS ITSR.INS_TRIG_REDO_TEST_FIRST;

DROP TRIGGER IF EXISTS ITSR.UPD_TRIG_REDO_TEST_FIRST;

update ITSR.REDO_TEST_FIRST set UPDATEDTIME=DATE_ADD(UPDATED_DT, INTERVAL -1 HOUR), CREATEDTIME=DATE_ADD(CREATED_DT, INTERVAL -1 HOUR);

CREATE TRIGGER `ITSR`.`INS_TRIG_REDO_TEST_FIRST` BEFORE INSERT
    ON ITSR.REDO_TEST_FIRST FOR EACH ROW
BEGIN
    SET NEW.CREATEDTIME = CURTIME();
END;

CREATE TRIGGER `ITSR`.`UPD_TRIG_REDO_TEST_FIRST` BEFORE UPDATE
    ON ITSR.REDO_TEST_FIRST FOR EACH ROW
BEGIN
    SET NEW.UPDATEDTIME = CURTIME();
END;

-- Finding Size of Table in MySQL
SELECT 
    table_name, 
    round(((data_length + index_length) / 1024 / 1024), 2) 'Size in MB'
FROM information_schema.TABLES 
WHERE table_schema = 'ITSR'
    AND table_name = 'REDO_TEST_FIRST';
    
*/

set timing on;
COLUMN value FORMAT 999999999999999

select b.value 
from sys.v_$statname a, sys.v_$mystat b 
where a.statistic# = b.statistic# 
and a.name = 'redo size';

delete from redo_test_first where rownum <= 100000;

commit;

select b.value 
from sys.v_$statname a, sys.v_$mystat b 
where a.statistic# = b.statistic# 
and a.name = 'redo size';
	
select operation, NVL(sql_undo, ' '), xidusn, xidslt, xidsqn, NVL(seg_name, ' '), SCN, RBASQN, RBABLK, RBABYTE, NVL(seg_owner, ' '), NVL(sql_redo, ' '), CSF, rollback, NVL(row_id, ' '), timestamp, NVL(username, ' ') from v$logmnr_contents where SCN >= :startScn and ((operation IN ('INSERT', 'DELETE', 'UPDATE', 'DIRECT INSERT') and (seg_name in ('OBJ# 18', 'OBJ# 68269', 'OBJ# 68345', 'OBJ# 68424', 'OBJ# 68427', 'OBJ# 68428', 'OBJ# 68433', 'OBJ# 68438', 'OBJ# 68457', 'OBJ# 68458', 'OBJ# 68463', 'OBJ# 68478', 'OBJ# 68480', 'OBJ# 68482', 'OBJ# 68484', 'OBJ# 68544', 'OBJ# 68582', 'OBJ# 68722', 'OBJ# 68726', 'OBJ# 68729', 'OBJ# 68735', 'OBJ# 68769', 'OBJ# 68771', 'OBJ# 68774', 'OBJ# 68783', 'OBJ# 68892', 'OBJ# 68943', 'OBJ# 68952', 'OBJ# 69145', 'OBJ# 69286', 'OBJ# 69287', 'OBJ# 69288', 'OBJ# 69310', 'OBJ# 69311', 'OBJ# 69318', 'OBJ# 69471', 'OBJ# 69522', 'OBJ# 69532', 'OBJ# 69534', 'OBJ# 69538', 'OBJ# 69543', 'OBJ# 69665', 'OBJ# 69668', 'OBJ# 69669', 'OBJ# 69708', 'OBJ# 69715', 'OBJ# 69855'

select operation, NVL(sql_undo, ' '), xidusn, xidslt, xidsqn, NVL(seg_name, ' '), SCN, RBASQN, RBABLK, RBABYTE, NVL(seg_owner, ' '), NVL(sql_redo, ' '), CSF, rollback, NVL(row_id, ' '), timestamp, NVL(username, ' ') from v$logmnr_contents where SCN >= :startScn and ((operation IN ('INSERT', 'DELETE', 'UPDATE', 'DIRECT INSERT') and (seg_name in ('OBJ# 18', 'OBJ# 68544', 'OBJ# 69471', 'OBJ# 69855', 'OBJ# 69867')) ) or operation IN ('START','COMMIT', 'ROLLBACK', 'DDL'))
select operation, NVL(sql_undo, ' '), xidusn, xidslt, xidsqn, NVL(seg_name, ' '), SCN, RBASQN, RBABLK, RBABYTE, NVL(seg_owner, ' '), NVL(sql_redo, ' '), CSF, rollback, NVL(row_id, ' '), timestamp, NVL(username, ' ') from v$logmnr_contents where SCN >= :startScn and ((operation IN ('INSERT', 'DELETE', 'UPDATE', 'DIRECT INSERT') and (seg_name in ('OBJ# 18', 'OBJ# 69311', 'OBJ# 69312', 'OBJ# 70208', 'OBJ# 144070')) ) or operation IN ('START','COMMIT', 'ROLLBACK', 'DDL'))


delete from "UNKNOWN"."OBJ# 1571393" where "COL 1" = HEXTORAW('c408244e06') and "COL 2" = HEXTORAW('4e616d655f393938322020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020') and "COL 3" = HEXTORAW('446573635f393938322020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020') and "COL 4" = HEXTORAW('787507150e180b0d5eda00') and "COL 5" = HEXTORAW('787507150e180b0d5eda00') and "COL 6" = HEXTORAW('80') and "COL 7" = HEXTORAW('c13224382c205c1c4f2848031a3d110b122e3e0325') and ROWID = 'AAGGWDAD6AAA85iAAA'; (oracdc_reader.c:2076)

--- DMS Task Details

Task name : An identifier for your Task	chris-dms-test-2
Task ARN : This ARN is the stable way uniquely identify your Replication Task when calling DMS APIs	arn:aws:dms:eu-west-1:556748783639:task:4E3KPHZW5RPEXJ32YISIPGNHHU
Status : The current computed status of the task. Note that this is acomputed value and may not match the raw status from the service API	ready
Migration type : How should this task migrate data	Full Load, Ongoing Replication
Replication instance : Replication instance	chris-test-dms-latency-1
Source endpointSource endpoint	chros-dms-latency-oracle
Target endpointTarget endpoint	chris-test-dms-mysql
Mapping methodThis is a json document that details how source tables are mapped to the target	{"rules":[{"rule-type":"selection","rule-id":"1","rule-name":"1","object-locator":{"schema-name":"ITSR","table-name":"REDO_TEST_FIRST"},"rule-action":"include"}]}
Task settingsThe task settings JSON allows you to apply custom settings to you task.	{"TargetMetadata":{"TargetSchema":"","SupportLobs":true,"FullLobMode":false,"LobChunkSize":64,"LimitedSizeLobMode":true,"LobMaxSize":200,"LoadMaxFileSize":0,"ParallelLoadThreads":0,"ParallelLoadBufferSize":0,"BatchApplyEnabled":false},"FullLoadSettings":{"TargetTablePrepMode":"DROP_AND_CREATE","CreatePkAfterFullLoad":false,"StopTaskCachedChangesApplied":false,"StopTaskCachedChangesNotApplied":false,"MaxFullLoadSubTasks":8,"TransactionConsistencyTimeout":600,"CommitRate":10000},"Logging":{"EnableLogging":true,"LogComponents":[{"Id":"SOURCE_UNLOAD","Severity":"LOGGER_SEVERITY_DETAILED_DEBUG"},{"Id":"TARGET_LOAD","Severity":"LOGGER_SEVERITY_DETAILED_DEBUG"},{"Id":"SOURCE_CAPTURE","Severity":"LOGGER_SEVERITY_DETAILED_DEBUG"},{"Id":"TARGET_APPLY","Severity":"LOGGER_SEVERITY_DETAILED_DEBUG"},{"Id":"TASK_MANAGER","Severity":"LOGGER_SEVERITY_DETAILED_DEBUG"}],"CloudWatchLogGroup":"dms-tasks-chris-test-dms-latency-1","CloudWatchLogStream":"dms-task-4E3KPHZW5RPEXJ32YISIPGNHHU"},"ControlTablesSettings":{"historyTimeslotInMinutes":5,"ControlSchema":"","HistoryTimeslotInMinutes":5,"HistoryTableEnabled":false,"SuspendedTablesTableEnabled":false,"StatusTableEnabled":false},"StreamBufferSettings":{"StreamBufferCount":3,"StreamBufferSizeInMB":8,"CtrlStreamBufferSizeInMB":5},"ChangeProcessingDdlHandlingPolicy":{"HandleSourceTableDropped":true,"HandleSourceTableTruncated":true,"HandleSourceTableAltered":true},"ErrorBehavior":{"DataErrorPolicy":"LOG_ERROR","DataTruncationErrorPolicy":"LOG_ERROR","DataErrorEscalationPolicy":"SUSPEND_TABLE","DataErrorEscalationCount":0,"TableErrorPolicy":"SUSPEND_TABLE","TableErrorEscalationPolicy":"STOP_TASK","TableErrorEscalationCount":0,"RecoverableErrorCount":-1,"RecoverableErrorInterval":60,"RecoverableErrorThrottling":true,"RecoverableErrorThrottlingMax":600,"ApplyErrorDeletePolicy":"IGNORE_RECORD","ApplyErrorInsertPolicy":"LOG_ERROR","ApplyErrorUpdatePolicy":"LOG_ERROR","ApplyErrorEscalationPolicy":"LOG_ERROR","ApplyErrorEscalationCount":0,"ApplyErrorFailOnTruncationDdl":false,"FullLoadIgnoreConflicts":true,"FailOnTransactionConsistencyBreached":false},"ChangeProcessingTuning":{"BatchApplyPreserveTransaction":true,"BatchApplyTimeoutMin":1,"BatchApplyTimeoutMax":30,"BatchApplyMemoryLimit":500,"BatchSplitSize":0,"MinTransactionSize":1000,"CommitTimeout":1,"MemoryLimitTotal":1024,"MemoryKeepTime":60,"StatementCacheSize":50}}
Last failure messageThe last failure message from the time the task was run and failed	
Created	
July 26, 2017 at 4:53:25 PM UTC+1
Started	

of target tables is not factored


