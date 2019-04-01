SELECT
    'Segment Advice --------------------------'|| chr(10) ||
    'TABLESPACE_NAME : '  || tablespace_name   || chr(10) ||
    'SEGMENT_OWNER: '     || segment_owner     || chr(10) ||
    'SEGMENT_NAME: '      || segment_name      || chr(10) ||
    'ALLOCATED_SPACE : '  || allocated_space   || chr(10) ||
    'RECLAIMABLE_SPACE: ' || reclaimable_space || chr(10) ||
    'RECOMMENDATIONS : '  || recommendations   || chr(10) ||
    'SOLUTION 1: '        || c1                || chr(10) ||
    'SOLUTION 2: '        || c2                || chr(10) ||
    'SOLUTION 3: '        || c3 Advice
FROM TABLE(dbms_space.asa_recommendations('TRUE', 'TRUE','FALSE'));


select segments_processed, end_time
from dba_auto_segadv_summary
order by end_time desc;

DECLARE
    my_task_id number;
    obj_id number;
    my_task_name varchar2(100);
    my_task_desc varchar2(500);
BEGIN
    my_task_name := 'EMP_BKP Advice';
    my_task_desc := 'Manual Segment Advisor Run';
    ---------
    -- Step 1
    ---------
    dbms_advisor.create_task (
    advisor_name => 'Segment Advisor',
    task_id      => my_task_id,
    task_name    => my_task_name,
    task_desc    => my_task_desc);
    ---------
    -- Step 2
    ---------
    dbms_advisor.create_object (
    task_name   => my_task_name,
    object_type => 'TABLE',
    attr1       => 'MYDBA',
    attr2       => 'EMP_BKP',
    attr3       => NULL,
    attr4       => NULL,
    attr5       => NULL,
    object_id   => obj_id);
    ---------
    -- Step 3
    ---------
    dbms_advisor.set_task_parameter(
    task_name  => my_task_name,
    parameter => 'recommend_all',
    value     => 'TRUE');
    ---------
    -- Step 4
    ---------
    dbms_advisor.execute_task(my_task_name);
END;
/

SELECT
    'Task Name: '      || f.task_name || chr(10)  ||
    'Segment Name: '   || o.attr2     || chr(10)  ||
    'Segment Type: '   || o.type      || chr(10)  ||
    'Partition Name: ' || o.attr3     || chr(10)  ||
    'Message: '        || f.message   || chr(10)  ||
    'More Info: '      || f.more_info TASK_ADVICE
FROM dba_advisor_findings f
JOIN dba_advisor_objects o
    ON( o.task_id = f.task_id
    AND o.object_id = f.object_id)
WHERE f.task_name like 'EMP_BKP Advice'
ORDER BY f.task_name;

Row chaining : which is caused by very long records that can’t fit within the given free space in a block, there isn’t much you can do about this. 
Row migration : Initially record populated with minimal data and later updated with most of the data. This might happen the new record no longer fits in the existing block.

analyze table emp compute statistics;

select 
    owner
    ,chain_cnt -- The CHAIN_CNT contains the sum of both migrated and chained rows
    ,round(chain_cnt/num_rows*100,2) chain_pct -- if it's more than 15% then potential problem.
    ,avg_row_len
    ,pct_free
from dba_tables
where table_name = 'EMP';

--Another way of identifying rowchain issue

After you start your database instance, any time a migrated/chained row is read, the statistic with a value of “table fetch continued row” is incremented.

with a as (
    select sum(value) total_rows_read
    from v$sysstat
    where name like '%table%'
    and name != 'table fetch continued row'
),
b as (
    select value total_mig_chain_rows
    from v$sysstat 
    where name = 'table fetch continued row'
)
select 
    a.total_rows_read, 
    b.total_mig_chain_rows,
    b.total_mig_chain_rows/a.total_rows_read pct_rows_mig_or_chained
from a, b;


-- Resolving rwochain/migration issue
-- Assume the table was initially built with a PCTFREE value of 40%. This next move operation rebuilds the table with a PCTFREE value of 5%:
alter table emp move pctfree 5;
-- However, keep in in mind if you do this, you could make the problem worse, as there will be less room in the block for future updates (which will result in more migrated/chained rows).
--MOVE operation assignes new ROWID to the rows. This will invalidate any indexes and hence needs rebuild

select owner, index_name, status
from dba_indexes
where table_name='EMP';

alter index emp_pk rebuild;

--* Moving Individual Migrated/Chained Rows

@?/rdbms/admin/utlchn1.sql -- The script creates a table named CHAINED_ROWS
analyze table emp list chained rows; --- chained rows are now moved to CHAINED_ROWS table
select count(*) from chained_rows where table_name='EMP';
create table temp_emp
as select *
from emp
where rowid in
(select head_rowid from chained_rows where table_name = 'EMP');

delete from emp
where rowid in
(select head_rowid from chained_rows where table_name = 'EMP');

insert into emp select * from temp_emp;

-- * understanding rowid in oracle
select empno
,dbms_rowid.rowid_to_absolute_fno(rowid,schema_name=>'MYDBA',object_name=>'EMP') file_num
,dbms_rowid.rowid_block_number(rowid) block_num
,dbms_rowid.rowid_row_number(rowid)
row_num
from emp;

select * from dba_data_files where file_id=106;

select * from dba_segments where segment_name='EMP';

select * from dba_extents where segment_name='EMP';


-- *DBMS_SPACE to Detect Space Below the High-Water Mark
set serverout on size 1000000
declare
    p_fs1_bytes          number;
    p_fs2_bytes          number;
    p_fs3_bytes          number;
    p_fs4_bytes          number;
    p_fs1_blocks         number;
    p_fs2_blocks         number;
    p_fs3_blocks         number;
    p_fs4_blocks         number;
    p_full_bytes         number;
    p_full_blocks        number;
    p_unformatted_bytes  number;
    p_unformatted_blocks number;
begin
    dbms_space.space_usage(
        segment_owner      => user,
        segment_name       => 'EMP',
        segment_type       => 'TABLE',
        fs1_bytes          => p_fs1_bytes,
        fs1_blocks         => p_fs1_blocks,
        fs2_bytes          => p_fs2_bytes,
        fs2_blocks         => p_fs2_blocks,
        fs3_bytes          => p_fs3_bytes,
        fs3_blocks         => p_fs3_blocks,
        fs4_bytes          => p_fs4_bytes,
        fs4_blocks         => p_fs4_blocks,
        full_bytes         => p_full_bytes,
        full_blocks        => p_full_blocks,
        unformatted_blocks => p_unformatted_blocks,
        unformatted_bytes  => p_unformatted_bytes
    );
    dbms_output.put_line('FS1:blocks='||p_fs1_blocks);
    dbms_output.put_line('FS2:blocks='||p_fs2_blocks);
    dbms_output.put_line('FS3:blocks='||p_fs3_blocks);
    dbms_output.put_line('FS4:blocks='||p_fs4_blocks);
    dbms_output.put_line('Full blocks='||p_full_blocks);
end;
/

-- FS1:blocks=0
-- FS2:blocks=0
-- FS3:blocks=0
-- FS4:blocks=0
-- Full blocks=27272

-- In the prior output the FS1 parameter shows that 0 blocks have 0% to 25% free space. The FS2 parameter shows that 0 blocks have 25% to 50% free space. The FS3 parameter shows that 0 blocks have 50% to 75% free space. The FS4 parameter shows there are 0 blocks with 75% to 100% free space.

--*Freeing Unused Table Space
alter table emp enable row movement;
alter table emp shrink space;
alter table emp shrink space cascade; -- You can also shrink the space associated with any index segments via the CASCADE clause:



-- Finding the rwo size
drop table vsize_sample_1;
create table vsize_sample_1( name char(10), surname varchar2(10), hiredate date, salary number(38));

insert into vsize_sample_1 values ('sar','raut',sysdate,123);
insert into vsize_sample_1 values ('sar','raut1',sysdate,11111111111111);
insert into vsize_sample_1 values ('sar','1234567890', sysdate,123456);

SELECT NVL(vsize(name),0),NVL(vsize(surname),0),NVL(vsize(hiredate),0), NVL(vsize(salary),0)  FROM vsize_sample_1;
-- CHAR column in this case is 10 bytes, varchar2 is how many letters are there, date is 7 bytes and number is variable size