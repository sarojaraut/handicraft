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
USERNAME     SID ADDR               STATUS     USED_UBLK   USED_UREC 
MYDBA         23 0000000071F64FF8   ACTIVE           559       48480

rollback;
insert /*+ APPEND */ into emp_bkp select * from emp;
-- 600,000 rows inserted.
-- Elapsed: 00:00:03.920
USERNAME     SID ADDR               STATUS     USED_UBLK   USED_UREC 
MYDBA         23 0000000071F64FF8   ACTIVE             2           2 

rollback;
insert into emp_bkp select * from emp;
-- 600,000 rows inserted.
-- Elapsed: 00:00:08.598
USERNAME     SID ADDR               STATUS     USED_UBLK   USED_UREC 
MYDBA         23 0000000071F64FF8   ACTIVE           559       48480 
