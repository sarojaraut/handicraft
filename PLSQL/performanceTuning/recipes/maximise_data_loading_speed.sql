set timing on;
-- Data set up
-- create 10 thousand currency records

--
-- Query to find out the redo blocks used
--
select 
   s.username, 
   s.sid, 
   t.addr, 
   t.status, 
   t.used_ublk, 
   t.used_urec
from 
   v$session     s, 
   v$transaction t 
where 
    s.taddr=t.addr
    and sid=23;

select table_name, logging
from user_tables
where table_name = 'CURRENCY';


-- Direct path inserts have two performance advantages over regular insert statements:
-- • If NOLOGGING is specified, then a minimal amount of redo is generated.
-- • The buffer cache is bypassed and data is loaded directly into the datafiles. This can significantly improve the loading performance.
-- One downside to reducing redo generation is that you can’t recover the data created via NOLOGGING in the event a failure occurs after the data is loaded (and before you back up the table). If you can tolerate some risk of data loss, then use NOLOGGING but back up the table soon after the data is loaded.

select name, log_mode, force_logging from v$database;
select tablespace_name, logging from dba_tablespaces;
select owner, table_name, logging from dba_tables where logging = 'NO';

-- *Experiment on XE 18c HPPro book
-- Finding IO speed sudo hdparm -tT /dev/sda4
-- for i in 1 2 3; do sudo hdparm -tT /dev/sda4; done
    -- /dev/sda4:
    -- Timing cached reads:   11502 MB in  2.00 seconds = 5764.46 MB/sec
    -- Timing buffered disk reads: 360 MB in  3.01 seconds = 119.80 MB/sec

    -- /dev/sda4:
    -- Timing cached reads:   11340 MB in  1.99 seconds = 5686.71 MB/sec
    -- Timing buffered disk reads: 344 MB in  3.01 seconds = 114.37 MB/sec

    -- /dev/sda4:
    -- Timing cached reads:   10890 MB in  2.00 seconds = 5458.17 MB/sec
    -- Timing buffered disk reads: 374 MB in  3.01 seconds = 124.29 MB/sec
    -- ranjan@myhpprobook-ubu1810:~$ dmesg | grep -i sata | grep 'link up'
    -- [    4.892997] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    -- [    5.228196] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
    -- ranjan@myhpprobook-ubu1810:~$ sudo hdparm -I /dev/sda | grep -i speed
    --     *	Gen1 signaling speed (1.5Gb/s)
    --     *	Gen2 signaling speed (3.0Gb/s)
    --     *	Gen3 signaling speed (6.0Gb/s)

drop table emp;

create table emp(  
  empno        number(10,0),  
  ename        varchar2(10),  
  job          varchar2(9),  
  mgr          number(4,0),  
  hiredate     date,  
  sal          number(7,2),  
  comm         number(7,2),  
  deptno       number(2,0),
  reference    char(256),
  constraint pk_emp primary key (empno)
);

--
-- APEND in this case is detrimental, wondering why?
--
insert /*+ APPEND */ into emp
select
    rownum                                as  empno
    ,dbms_random.string('U',10)           as  ename
    ,dbms_random.string('U',9)            as  job
    ,trim(dbms_random.value(1,9999))      as  mgr
    ,sysdate                              as  hiredate 
    ,round(dbms_random.value(1,99999),2)  as  sal
    ,round(dbms_random.value(1,999),2)    as  comm
    ,trim(dbms_random.value(1,99))        as  deptno
    ,dbms_random.string('X',9)            as  job
from dual
connect by rownum <= 600000; 
-- 600,000 rows inserted.
-- Elapsed: 00:02:29.543

EXECUTE DBMS_STATS.GATHER_TABLE_STATS (USER,'EMP');

drop table emp_bkp;
create table emp_bkp as select * from emp where 1=2;

rollback;
insert into emp_bkp select * from emp;
-- 600,000 rows inserted.
-- Elapsed: 00:00:19.552
-- USERNAME     SID ADDR               STATUS     USED_UBLK   USED_UREC 
-- MYDBA         23 0000000071F64FF8   ACTIVE           559       48480

rollback;
insert /*+ APPEND */ into emp_bkp select * from emp;
-- 600,000 rows inserted.
-- Elapsed: 00:00:03.920
-- USERNAME     SID ADDR               STATUS     USED_UBLK   USED_UREC 
-- MYDBA         23 0000000071F64FF8   ACTIVE             2           2 

rollback;
insert into emp_bkp select * from emp;
-- 600,000 rows inserted.
-- Elapsed: 00:00:08.598
-- USERNAME     SID ADDR               STATUS     USED_UBLK   USED_UREC 
-- MYDBA         23 0000000071F64FF8   ACTIVE           559       48480 

