-- Used Demo Schema
alias cloudconfig=set cloudconfig C:\saroj\Wallet_ourcompany.zip;
alias conn_demo=conn demo/-*****@ourcompany_high;
grant SELECT_CATALOG_ROLE to demo;

create table tst_cur_sharing (
    id          number,
    record_type number,
    description varchar2(50),
    constraint tst_cur_sharing_pk primary key (id)
);

insert into tst_cur_sharing
select 
    rownum id 
    ,case mod(rownum,3)
        when 2 then 2
        when 0 then 3
        else rownum
    end record_type
    ,'Test Description for : '||
    case mod(rownum,3)
        when 2 then 2
        when 0 then 3
        else rownum
    end description
from dual 
connect by rownum <= 300000;

create index tst_cur_sharing_idx1 on tst_cur_sharing(record_type);

exec dbms_stats.gather_table_stats(user, 'tst_cur_sharing', estimate_percent =>100, method_opt=>'for all indexed columns size skewonly', cascade=>true);

-- Check Histogram
select column_name, histogram, num_distinct
from   user_tab_cols
where  table_name = 'TST_CUR_SHARING';

COLUMN_NAME	HISTOGRAM	   NUM_DISTINCT
ID	        NONE	        300000
RECORD_TYPE	HEIGHT BALANCED	100002
DESCRIPTION	NONE	

-- Table Data Analysis
select
    record_type
    ,count(*) cnt
from tst_cur_sharing
group by record_type
order by 1;

variable l_record_type number;
exec :l_record_type := 1;

set autotrace on;
select count(id) from tst_cur_sharing where record_type = :l_record_type;


Plan hash value: 3668031856

------------------------------------------------------------------------------------------
| Id  | Operation         | Name                 | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |                      |     1 |     4 |     3   (0)| 00:00:01 |
|   1 |  SORT AGGREGATE   |                      |     1 |     4 |            |          |
|*  2 |   INDEX RANGE SCAN| TST_CUR_SHARING_IDX1 |     3 |    12 |     3   (0)| 00:00:01 |
------------------------------------------------------------------------------------------


select sql_id, child_number, is_bind_sensitive, is_bind_aware
from   v$sql
where  sql_text = 'select count(id) from tst_cur_sharing where record_type = :l_record_type';
SQL_ID	CHILD_NUMBER	IS_BIND_SENSITIVE	IS_BIND_AWARE
574udv86b68b4	0	Y	N

-- At  this stage It's bind sensitive because of histogram on record_type but is'not bind aware at this stage

exec :l_record_type := 2;

set autotrace on;
select count(id) from tst_cur_sharing where record_type = :l_record_type;

------------------------------------------------------------------------------------------
| Id  | Operation         | Name                 | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |                      |     1 |     4 |     3   (0)| 00:00:01 |
|   1 |  SORT AGGREGATE   |                      |     1 |     4 |            |          |
|*  2 |   INDEX RANGE SCAN| TST_CUR_SHARING_IDX1 |     3 |    12 |     3   (0)| 00:00:01 |
------------------------------------------------------------------------------------------

select sql_id, child_number, is_bind_sensitive, is_bind_aware
from   v$sql
where  sql_text = 'select count(id) from tst_cur_sharing where record_type = :l_record_type';

SQL_ID	CHILD_NUMBER	IS_BIND_SENSITIVE	IS_BIND_AWARE
574udv86b68b4	0	Y	N


-- Still not bind aware run the query for third time

exec :l_record_type := 2;

set autotrace on;
select count(id) from tst_cur_sharing where record_type = :l_record_type;

select sql_id, child_number, is_bind_sensitive, is_bind_aware
from   v$sql
where  sql_text = 'select count(id) from tst_cur_sharing where record_type = :l_record_type';
------------------------------------------------------------------------------------------
| Id  | Operation         | Name                 | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |                      |     1 |     4 |     3   (0)| 00:00:01 |    
|   1 |  SORT AGGREGATE   |                      |     1 |     4 |            |          |    
|*  2 |   INDEX RANGE SCAN| TST_CUR_SHARING_IDX1 |     3 |    12 |     3   (0)| 00:00:01 |
------------------------------------------------------------------------------------------

SQL_ID	CHILD_NUMBER	IS_BIND_SENSITIVE	IS_BIND_AWARE
574udv86b68b4	0	Y	N
574udv86b68b4	1	Y	Y

-- Now it's bind aware


-- Information about the cursor sharing histograms, statistics and selectivity is displayed using the V$SQL_CS_HISTOGRAM, V$SQL_CS_STATISTICS and V$SQL_CS_SELECTIVITY views respectively.
select * from v$sql_cs_histogram where sql_id = '9bmm6cmwa8saf';
select * from v$sql_cs_statistics where sql_id = '9bmm6cmwa8saf';
select * from v$sql_cs_selectivity where sql_id = '9bmm6cmwa8saf



--! Clean up 

drop table tst_cur_sharing purge;
