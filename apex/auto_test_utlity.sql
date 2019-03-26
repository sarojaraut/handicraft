/*
alter procedure ams_etl.undo_split_gilt_run compile;
begin
	ams_etl.undo_split_gilt_run(19660);
end;
/
set linesize 500;
alter package ams_etl.ut_split_gilt_run compile;
exec ut_split_gilt_run.set_batch_run_id(19660);
exec utplsql.test ('split_gilt_run');
rollback;

set serveroutput on;
set linesize 400;
alter package AMS_ETL.PA_UTIL_LOGGER compile;
begin
	ams_etl.split_gilt_run('19660');
end;
/
--
--
--
begin
	ams_etl.undo_split_gilt_run(19002);
end;
/
set linesize 500;
alter package ams_etl.ut_split_gilt_run compile;
exec ut_split_gilt_run.set_batch_run_id(19002);
exec utplsql.test ('split_gilt_run');
rollback;

set serveroutput on;
set linesize 400;
alter package AMS_ETL.PA_UTIL_LOGGER compile;
begin
	ams_etl.split_gilt_run('19002');
end;
/
--
--
--
begin
	ams_etl.undo_split_gilt_run(19226);
end;
/
set linesize 500;
alter package ams_etl.ut_split_gilt_run compile;
exec ut_split_gilt_run.set_batch_run_id(19226);
exec utplsql.test ('split_gilt_run');
rollback;

set serveroutput on;
set linesize 400;
alter package AMS_ETL.PA_UTIL_LOGGER compile;
begin
	ams_etl.split_gilt_run('19226');
end;
/

set serveroutput on;
set linesize 400;
alter package AMS_ETL.PA_UTIL_LOGGER compile;
begin
	ams_etl.split_gilt_run('0000');
end;
/
--
--
--
create or replace type ams_etl.T_GILT_DETAIL as object 
(gilt_number  number(5)
,batch_run_id number(18)
,job_run_id   number(18)
);
/
create or replace type ams_etl.T_GILT_DETAIL_LIST is table of ams_etl.T_GILT_DETAIL;
/
*/

-----------------

 create or function ams_etl.ColumnExists(p_schema_owner_i in all_tab_columns.owner%type,
                        p_table_name_i   in all_tab_columns.table_name%type,
                        p_column_name_i  in all_tab_columns.column_name%type)
    return varchar is
    cnt number;
  begin
    select count(1)
      into cnt
      from all_tab_columns
     where owner = upper(p_schema_owner_i)
       and table_name = upper(p_table_name_i)
       and column_name = upper(p_column_name_i);
    if cnt > 0 then
      return 'Y';
    else
      return 'N';
    end if;
  end;


/*
--
-- Test Cases
--

1.	Verify Proper Record Insertion for tetl_batch_log

	insert into tetl_batch_log
	(batch_run_id
	,batch_cd
	,start_time
	,end_time
	,status)
	select   
	i_child_batch_run_id
	,bl.batch_cd 
	,bl.start_time
	,bl.end_time
	,bl.status
	from 
	tetl_batch_log  bl
	where
	bl.batch_run_id = i_parent_batch_run_id;
			
2.	Verify Proper Record Insertion for tetl_batch_log_src_tgt


select  tblst.batch_cd
	,tblst.source_target_type_cd
	,tblst.system_data_set_cd
	,tblst.system_data_cd
	,tblst.system_data_type_cd
	,tblst.file_name
	,tblst.file_no_of_records
	,tblst.data_file_delimiter
from 
ams_etl.tetl_batch_log_src_tgt  tblst
where   
	tblst.SOURCE_TARGET_TYPE_CD = 'SOURCE'
	tblst.batch_run_id = i_parent_batch_run_id
	

3.	Verify Proper Record Insertion for tetl_batch_run_list

select batch_run_id 
from ams_etl.tetl_batch_run_list 
where 
dependent_batch_end_time > trunc(sysdate) 
and dependent_batch_run_id = 19660
and batch_cd = 'LOAD_MOSES_RESULTS'
and dependent_batch_cd = 'LOAD_MOSES_RESULTS'
	   
	   
4.	Verify Proper Record Insertion for tams_job_run

select job_id
,job_run_status
,job_file_name
,start_dt
,end_dt 
from ams_etl.tams_job_run 
where job_run_id = 1615
5.	Verify Proper Record Insertion for tams_job_run_parameter

select parameter_type
,parameter_value 
from ams_etl.tams_job_run_parameter 
where job_run_id = 1615

6.	Verify Proper Record Insertion for tams_job_run_rep_basis
select reporting_basis
,reporting_group_map_version
from ams_etl.tams_job_run_rep_basis 
where job_run_id = 1615

7.	Verify Proper Record Insertion for tams_job_run_rep_group

select reporting_basis
,reporting_group
,job_run_id
from ams_etl.tams_job_run_rep_group
where job_run_id = 

8.	Verify Proper Record Insertion for tams_job_run_risk_fact

select 
	job_run_risk_factor_id
	,description
	,risk_factor
	,risk_factor_type
	,stress_delta
	,term_structure_id
	from tams_job_run_risk_factor 
	where job_run_id = '||g_input_job_run_id;
	
9.	Verify Proper Record Insertion for tams_job_run_batch

SELECT 1 FROM UTP.SPLIT_GILT_TEST sgt WHERE NOT EXISTS 
(SELECT 1 
FROM tams_job_run_batch 
WHERE 
	batch_run_id=sgt.new_batch_run_id 
	and job_run_id=sgt.new_job_run_id)

10.	Verify copy of glit records with matching job run id

SELECT ETL_BATCH_RUN_ID, COUNT(*) 
FROM AMS.TAMS_DISCOUNT_CASHFLOW_NL_S1 
WHERE 
ETL_BATCH_RUN_ID BETWEEN 420 AND 424 
GROUP BY ETL_BATCH_RUN_ID


11.	Verify count of records tables inserted against count in tetl_batch_log_src_tgt

SELECT BATCH_RUN_ID, NUM_ROWS_INSERTED FROM AMS_ETL.TETL_BATCH_LOG_SRC_TGT 
WHERE BATCH_RUN_ID BETWEEN 420 AND 424 
AND SOURCE_TARGET_TYPE_CD = 'TARGET'
MINUS
SELECT NEW_BATCH_JOB_ID,REC_COUNT FROM UTP.SPLIT_GILT_TEST
 
 select ams_etl.tetl_batch_log_src_tgt where BATCH_RUN_ID 420 and 424 

*/

create global temporary table utp.split_gilt_test(
  table_name                  varchar2(60)
, gilt_number                 number
, rec_count                   number
, new_batch_run_id            number
, new_job_run_id              number
, original_batch_job_id       number
)ON COMMIT PRESERVE ROWS;

grant all on  utp.split_gilt_test to public;

select 
tblst.table_schema||'.'||tblst.table_name, 
tblst.system_data_cd
from 
ams_etl.tetl_batch_log_src_tgt   tblst
where 
tblst.batch_run_id = 19660
and tblst.source_target_type_cd = 'TARGET'
and ColumnExists(tblst.table_schema,tblst.table_name,'report_group')='Y';

SELECT distinct to_number(substr(report_group,instr(report_group,''GILTS'',-1) + 5)) as GlitNum  FROM
l_target_table_list(i)
WHERE
etl_batch_run_id =  i_batch_run_id
and report_group like '%GILTS%'

select brl.dependent_batch_run_id, brl.batch_run_id, jrb.job_run_id, jr.scenario_number-90000
from ams_etl.tetl_batch_run_list brl, ams_etl.tams_job_run_batch jrb, ams_etl.tams_job_run jr
where dependent_batch_end_time >= trunc(sysdate)
and brl.batch_run_id = jrb.batch_run_id
and jrb.job_run_id = jr.job_run_id 
and scenario_number >= 90000

select batch_cd,start_time,end_time,status,batch_run_id from ams_etl.tetl_batch_log
where  (batch_cd,start_time,end_time,status) in
(select batch_cd,start_time,end_time,status from ams_etl.tetl_batch_log where batch_run_id = 19660)
and batch_run_id <> 19660

select batch_cd,source_target_type_cd,system_data_set_cd,system_data_cd,batch_run_id 
from ams_etl.tetl_batch_log_src_tgt
where  (batch_cd,source_target_type_cd,system_data_set_cd,system_data_cd) in
(select batch_cd,source_target_type_cd,system_data_set_cd,system_data_cd 
from ams_etl.tetl_batch_log_src_tgt where batch_run_id = 19660)
and batch_run_id <> 19660
and SOURCE_TARGET_TYPE_CD = 'SOURCE';

select * from ams_etl.tetl_batch_run_list 
where dependent_batch_end_time > trunc(sysdate) 
and dependent_batch_run_id = 19660

select job_id,job_run_status,job_file_name,start_dt,end_dt,scenario_number,job_run_id
from ams_etl.tams_job_run
where  (job_id,job_run_status,job_file_name,start_dt,end_dt) in
(select job_id,job_run_status,job_file_name,start_dt,end_dt 
from ams_etl.tams_job_run where job_run_id = 1615)
and job_run_id <> 1615

select parameter_type,parameter_value,job_run_id
from ams_etl.tams_job_run_parameter
where  (parameter_type,parameter_value) in
(select parameter_type,parameter_value 
from ams_etl.tams_job_run_parameter where job_run_id = 1615)
and job_run_id <> 1615 

0 rows

select reporting_basis,reporting_group_map_version,job_run_id
from ams_etl.tams_job_run_rep_basis
where  (reporting_basis,reporting_group_map_version) in
(select reporting_basis,reporting_group_map_version
from ams_etl.tams_job_run_rep_basis where job_run_id = 1615)
and job_run_id <> 1615

0 rows



0 rows

select job_run_risk_factor_id,description,risk_factor,risk_factor_type,stress_delta,term_structure_id,job_run_id
from ams_etl.tams_job_run_risk_factor
where  (job_run_risk_factor_id,description,risk_factor,risk_factor_type,stress_delta,term_structure_id) in
(select job_run_risk_factor_id,description,risk_factor,risk_factor_type,stress_delta,term_structure_id
from ams_etl.tams_job_run_risk_factor where job_run_id = 1615)
and job_run_id <> 1615

select job_run_risk_factor_id,description,risk_factor,risk_factor_type,stress_delta,term_structure_id
from tams_job_run_risk_factor where job_run_id = 1615

select job_run_risk_factor_id,description,risk_factor,risk_factor_type,stress_delta,term_structure_id
from ams_etl.tams_job_run_risk_factor where job_run_id in
(SELECT new_job_run_id FROM UTP.SPLIT_GILT_TEST) 

0 rows

select job_run_id,batch_run_id from ams_etl.tams_job_run_batch
same number as distinct glits

copy all records from target table with etl_batch_run_id = input batch run id to the same target table with different etl_batch_run_id as mapped to the corresponding glit number

select batch_run_id,num_rows_inserted,table_name,table_schema from ams_etl.tetl_batch_log_src_tgt where 
 BATCH_CD                      = 'LOAD_MOSES_RESULTS'
and SOURCE_TARGET_TYPE_CD         = 'TARGET'
and SYSTEM_DATA_SET_CD            = 'MOSES_RESULT_DATA'
and SYSTEM_DATA_CD                = 'NPA_DISCOUNT_CASHFLOW_DATA_S1'
and SYSTEM_DATA_TYPE_CD           = 'Database Table'
and FILE_NAME                     is null
and FILE_NO_OF_RECORDS            is null
and DATA_FILE_DELIMITER           is null
and USE_QUOTED_FIELD_VALUES       is null
and HEADER_PRESENT                is null
and TRAILER_PRESENT               is null
and TABLE_NAME                    = 'TAMS_DISCOUNT_CASHFLOW_NL_S1'
and TABLE_SCHEMA                  = 'AMS'
and TABLE_DESCRIPTION             = 'AMS.TAMS_DISCOUNT_CASHFLOW_NL_S1'
and TABLE_TYPE                    is null
and NUM_ROWS_UPDATED              = 0
and NUM_ROWS_DELETED              = 0
and UPDBYID = 'SARRARA'
and INSBYID = 'SARRARA'
and INSTS > trunc(sysdate) 

l_updts := systimestamp;
l_updbyid := upper(sys_context('USERENV','OS_USER'));

sum of NUM_ROWS_INSERTED should be equal to count of glit rows on all target tables for the same job run id

select  sequence_name, last_number from dba_sequences 
where sequence_name in ('SEQ_GL_BATCH_ID','SEQ_JOB_RUN_ID') 
and sequence_owner='AMS'

--drop table auto_test_config;
create table auto_test_config
(
	config_id                 number(10)
	,main_object              varchar2(30)
	,sub_object               varchar2(30)   
	,config_string            varchar2(1000)
	,test_status              varchar2(100)
	,test_start_timestamp     date
	,test_end_timestamp       date
	,test_description         varchar2(1000)
	,config_creation_time     date
);
--
-- Table Comments
--
COMMENT ON TABLE auto_test_config IS 'Used for automated testing';
--
-- Column Comments
--
COMMENT ON column auto_test_config.config_id IS 'Unique for each test scenario';
COMMENT ON column auto_test_config.main_object IS 'Procedure/package for which this config row is';
COMMENT ON column auto_test_config.sub_object IS 'Procedure/package for which this config row is';
COMMENT ON column auto_test_config.config_string IS 'Comma separated list of name=value pairs';
COMMENT ON column auto_test_config.test_status IS 'If this config value is used at all';
COMMENT ON column auto_test_config.test_start_timestamp IS 'When this config row was used';
COMMENT ON column auto_test_config.test_end_timestamp IS 'When this config row was used';
COMMENT ON column auto_test_config.test_description IS 'Description of this test case';
COMMENT ON column auto_test_config.config_creation_time IS 'When this config row was created';
--
--
Test Data
"RowNum ","ETL_BATCH_RUN_ID","COUNT(*)"
"1","335","4"
"2","336","4"
"3","337","4"
"4","338","4"
"5","339","4"
"6","19544","1428"
"7","19545","2856"
"8","19546","38841"
"9","19547","1008"
"10","19552","6538"
"11","19553","167883"
"12","19556","8132"
"13","19557","38841"
"14","19571","1008"
"15","19575","20160"
"16","19577","8132"
"17","19578","8132"
"18","19579","8132"
"19","19580","38841"
"20","19585","324"
"21","19586","62"
"22","19588","6356"
"23","19589","38841"
"24","19590","1008"
"25","19591","1008"
"26","19598","5656"
"27","19599","3290"
"28","19600","3452"
"29","19603","2186"
"30","19604","1008"
"31","19607","123760"
"32","19608","8132"
"33","19609","1008"
"34","19610","1008"
"35","19611","1008"
"36","19660","20"


----------------------- Test Data Set up

create table ams.TAMS_DISCOUNT_CASHFLOW_NL_S13 
as select * from ams_etl.TAMS_DISCOUNT_CASHFLOW_NL_S1 where  report_group like '%GILTS%' 
and etl_batch_run_id = 19660

create table ams.TAMS_DISCOUNT_CASHFLOW_NL_S14 
as select * from ams_etl.TAMS_DISCOUNT_CASHFLOW_NL_S1 where  report_group like '%GILTS%' 
and etl_batch_run_id = 19660

insert into ams_etl.tetl_batch_log_src_tgt(BATCH_RUN_ID
				,BATCH_CD
				,SOURCE_TARGET_TYPE_CD
				,SYSTEM_DATA_SET_CD
				,SYSTEM_DATA_CD
				,SYSTEM_DATA_TYPE_CD
				,FILE_NAME
				,FILE_NO_OF_RECORDS
				,DATA_FILE_DELIMITER
				,USE_QUOTED_FIELD_VALUES
				,HEADER_PRESENT
				,TRAILER_PRESENT
				,TABLE_NAME
				,TABLE_SCHEMA
				,TABLE_DESCRIPTION
				,TABLE_TYPE
				,NUM_ROWS_INSERTED
				,NUM_ROWS_UPDATED
				,NUM_ROWS_DELETED
     )
 select BATCH_RUN_ID
				,'LOAD_MOSES_RESULTS'
				,SOURCE_TARGET_TYPE_CD
				,SYSTEM_DATA_SET_CD
				,SYSTEM_DATA_CD
				,SYSTEM_DATA_TYPE_CD
				,FILE_NAME
				,FILE_NO_OF_RECORDS
				,DATA_FILE_DELIMITER
				,USE_QUOTED_FIELD_VALUES
				,HEADER_PRESENT
				,TRAILER_PRESENT
				,'TAMS_DISCOUNT_CASHFLOW_NL_S13'
				,TABLE_SCHEMA
				,TABLE_DESCRIPTION
				,TABLE_TYPE
				,0
				,0
				,0 
        from ams_etl.tetl_batch_log_src_tgt 
        where batch_run_id = 19660 and source_target_type_cd = 'TARGET'
		
insert into ams_etl.tetl_batch_log_src_tgt(BATCH_RUN_ID
				,BATCH_CD
				,SOURCE_TARGET_TYPE_CD
				,SYSTEM_DATA_SET_CD
				,SYSTEM_DATA_CD
				,SYSTEM_DATA_TYPE_CD
				,FILE_NAME
				,FILE_NO_OF_RECORDS
				,DATA_FILE_DELIMITER
				,USE_QUOTED_FIELD_VALUES
				,HEADER_PRESENT
				,TRAILER_PRESENT
				,TABLE_NAME
				,TABLE_SCHEMA
				,TABLE_DESCRIPTION
				,TABLE_TYPE
				,NUM_ROWS_INSERTED
				,NUM_ROWS_UPDATED
				,NUM_ROWS_DELETED
     )
 select BATCH_RUN_ID
				,'LOAD_MOSES_RESULTS'
				,SOURCE_TARGET_TYPE_CD
				,SYSTEM_DATA_SET_CD
				,SYSTEM_DATA_CD
				,SYSTEM_DATA_TYPE_CD
				,FILE_NAME
				,FILE_NO_OF_RECORDS
				,DATA_FILE_DELIMITER
				,USE_QUOTED_FIELD_VALUES
				,HEADER_PRESENT
				,TRAILER_PRESENT
				,'TAMS_DISCOUNT_CASHFLOW_NL_S14'
				,TABLE_SCHEMA
				,TABLE_DESCRIPTION
				,TABLE_TYPE
				,0
				,0
				,0 
        from ams_etl.tetl_batch_log_src_tgt 
        where batch_run_id = 19660 and source_target_type_cd = 'TARGET'

alter table ams_etl.TETL_BATCH_LOG_SRC_TGT modify constraint PK_TETL_BATCH_LOG_SRC_TGT defer

AMS_ETL.PK_TETL_BATCH_LOG_SRC_TGT
select
BATCH_CD,
BATCH_RUN_ID,
SOURCE_TARGET_TYPE_CD,
SYSTEM_DATA_SET_CD,
SYSTEM_DATA_CD,
SYSTEM_DATA_TYPE_CD,
SOURCE_TARGET_OBJECT,
TABLE_DESCRIPTION
from ams_etl.tetl_batch_log_src_tgt where batch_run_id = 19660
 
 
 CASE "SYSTEM_DATA_TYPE_CD" WHEN 'Database Table' THEN "TABLE_NAME" WHEN 'Flat File' THEN "FILE_NAME" ELSE 'unknown' END 
 ((SYSTEM_DATA_TYPE_CD <> 'Flat File' AND FILE_NAME IS NULL) OR (FILE_NAME IS NOT NULL AND SYSTEM_DATA_TYPE_CD = 'Flat File')) AND
((SYSTEM_DATA_TYPE_CD <> 'Flat File' AND FILE_NO_OF_RECORDS IS NULL) OR (FILE_NO_OF_RECORDS IS NOT NULL AND SYSTEM_DATA_TYPE_CD = 'Flat File')) AND
((SYSTEM_DATA_TYPE_CD <> 'Database Table' AND TABLE_NAME IS NULL) OR (TABLE_NAME IS NOT NULL AND SYSTEM_DATA_TYPE_CD = 'Database Table')) AND
((SYSTEM_DATA_TYPE_CD <> 'Database Table' AND TABLE_SCHEMA IS NULL) OR (TABLE_SCHEMA IS NOT NULL AND SYSTEM_DATA_TYPE_CD = 'Database Table')) AND
((SYSTEM_DATA_TYPE_CD <> 'Database Table' AND TABLE_DESCRIPTION IS NULL) OR (TABLE_DESCRIPTION IS NOT NULL AND SYSTEM_DATA_TYPE_CD = 'Database Table')) AND
((SYSTEM_DATA_TYPE_CD <> 'Database Table' AND NUM_ROWS_INSERTED IS NULL) OR (NUM_ROWS_INSERTED IS NOT NULL AND SYSTEM_DATA_TYPE_CD = 'Database Table')) AND
((SYSTEM_DATA_TYPE_CD <> 'Database Table' AND NUM_ROWS_UPDATED IS NULL) OR (NUM_ROWS_UPDATED IS NOT NULL AND SYSTEM_DATA_TYPE_CD = 'Database Table')) AND
((SYSTEM_DATA_TYPE_CD <> 'Database Table' AND NUM_ROWS_DELETED IS NULL) OR (NUM_ROWS_DELETED IS NOT NULL AND SYSTEM_DATA_TYPE_CD = 'Database Table'))


 ---------- Test data Population
 
insert /*+ APPEND */ into AMS.TAMS_DISCOUNT_CASHFLOW_NL_S1
with t as (select 
REPORT_GROUP,DISC_RATE,PERIOD,PRODUCT,PURPOSE,T_FROM,T_TO,TIME,ETL_BATCH_RUN_ID,ETL_DQ_INDICATOR,ETL_INSERT_DATE,ETL_UPDATE_DATE,90000+rownum,ETL_SOURCE_SYSTEM_CD,ETL_SYSTEM_DATA_CD,ETL_DATA_SECTION,ANN_PV,ANN_PV_PV,ANN_PV_T0,BEL_CLMS,BEL_COMEXP,BEL_E,BEL_PREM,BEL_SHTRAN,BEL_TERM,BELT0,CLM_ANN_B,CLM_ANN_E,CLM_ANN_M,CLM_DIS,CLM_DIS_T0,CLM_DTH,CLM_DTH_T0,CLM_MT_ELR,CLM_SURR,CLMANN_BT0,CLMANN_ET0,CLMANN_MT0,CLMANNB_PV,CLMANNE_PV,CLMANNM_PV,CLMDIS_PV,CLMDTH_PV,CLMME_PV,CLMMTER_T0,CLMSURR_PV,CLMSURR_T0,COMM_INIT,COMM_REN,COMMINI_PV,COMMINI_T0,COMMREN_PV,COMMREN_T0,EXP_INIT,EXP_REN,EXP_REN_T0,EXPINIT_PV,EXPINIT_T0,EXPREN_PV,INITIALIS2,PREMINC,PREMINC_PV,PREMINC_T0,SHR_TR_B,SHR_TR_E,SHR_TR_M,SHRTRB_PV,SHRTRE_PV,SHRTRM_PV,SHTR_BT0,SHTR_ET0,SHTR_MT0,STARTUP,TARGET_COL,CLMROP_PV,CLM_ROP,CLMROP_T0 
from AMS.TAMS_DISCOUNT_CASHFLOW_NL_S1
 WHERE
etl_batch_run_id = 19660
and report_group like '%GILTS%'
and rownum =1)
select 
substr(REPORT_GROUP,1, length(REPORT_GROUP)-3)||lpad(mod(rownum,100),3,'0'), DISC_RATE,PERIOD,PRODUCT,PURPOSE,T_FROM,T_TO,TIME,ETL_BATCH_RUN_ID,ETL_DQ_INDICATOR,ETL_INSERT_DATE,ETL_UPDATE_DATE,90000+rownum,ETL_SOURCE_SYSTEM_CD,ETL_SYSTEM_DATA_CD,ETL_DATA_SECTION,ANN_PV,ANN_PV_PV,ANN_PV_T0,BEL_CLMS,BEL_COMEXP,BEL_E,BEL_PREM,BEL_SHTRAN,BEL_TERM,BELT0,CLM_ANN_B,CLM_ANN_E,CLM_ANN_M,CLM_DIS,CLM_DIS_T0,CLM_DTH,CLM_DTH_T0,CLM_MT_ELR,CLM_SURR,CLMANN_BT0,CLMANN_ET0,CLMANN_MT0,CLMANNB_PV,CLMANNE_PV,CLMANNM_PV,CLMDIS_PV,CLMDTH_PV,CLMME_PV,CLMMTER_T0,CLMSURR_PV,CLMSURR_T0,COMM_INIT,COMM_REN,COMMINI_PV,COMMINI_T0,COMMREN_PV,COMMREN_T0,EXP_INIT,EXP_REN,EXP_REN_T0,EXPINIT_PV,EXPINIT_T0,EXPREN_PV,INITIALIS2,PREMINC,PREMINC_PV,PREMINC_T0,SHR_TR_B,SHR_TR_E,SHR_TR_M,SHRTRB_PV,SHRTRE_PV,SHRTRM_PV,SHTR_BT0,SHTR_ET0,SHTR_MT0,STARTUP,TARGET_COL,CLMROP_PV,CLM_ROP,CLMROP_T0
from t, dual
connect by rownum <= 1000000;

commit;

DELETE FROM AMS.TAMS_DISCOUNT_CASHFLOW_NL_S1 where  etl_batch_run_id=19660 and  ETL_RECORD_NUMBER >= 90000;


insert  into AMS.TAMS_DISCOUNT_CASHFLOW_NL_S1
select 
REPORT_GROUP,DISC_RATE,PERIOD,PRODUCT,PURPOSE,T_FROM,T_TO,TIME,19002,ETL_DQ_INDICATOR,ETL_INSERT_DATE,ETL_UPDATE_DATE,90000+rownum,ETL_SOURCE_SYSTEM_CD,ETL_SYSTEM_DATA_CD,ETL_DATA_SECTION,ANN_PV,ANN_PV_PV,ANN_PV_T0,BEL_CLMS,BEL_COMEXP,BEL_E,BEL_PREM,BEL_SHTRAN,BEL_TERM,BELT0,CLM_ANN_B,CLM_ANN_E,CLM_ANN_M,CLM_DIS,CLM_DIS_T0,CLM_DTH,CLM_DTH_T0,CLM_MT_ELR,CLM_SURR,CLMANN_BT0,CLMANN_ET0,CLMANN_MT0,CLMANNB_PV,CLMANNE_PV,CLMANNM_PV,CLMDIS_PV,CLMDTH_PV,CLMME_PV,CLMMTER_T0,CLMSURR_PV,CLMSURR_T0,COMM_INIT,COMM_REN,COMMINI_PV,COMMINI_T0,COMMREN_PV,COMMREN_T0,EXP_INIT,EXP_REN,EXP_REN_T0,EXPINIT_PV,EXPINIT_T0,EXPREN_PV,INITIALIS2,PREMINC,PREMINC_PV,PREMINC_T0,SHR_TR_B,SHR_TR_E,SHR_TR_M,SHRTRB_PV,SHRTRE_PV,SHRTRM_PV,SHTR_BT0,SHTR_ET0,SHTR_MT0,STARTUP,TARGET_COL,CLMROP_PV,CLM_ROP,CLMROP_T0 
from AMS.TAMS_DISCOUNT_CASHFLOW_NL_S1
 WHERE
etl_batch_run_id = 19660
and report_group like '%GILTS%'



