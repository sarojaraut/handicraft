create or replace package ams_etl.pa_util_logger 
as 
    --******************************************************************************* 
    -- 
    -- This package contains routines to log processing steps 
    -- 
    -- %PCMS_HEADER_SUBSTITUTION_START% 
    --       File: %ARCHIVE% 
    --       $Revision %PR% 
    --       Author: %AUTHOR% 
    --       Last Changed: %PRT% 
    -- %PCMS_HEADER_SUBSTITUTION_END% 
    -- 
    --******************************************************************************* 

    -- debug levels 
    NONE      constant varchar2(10) := 'NONE'; 
    DEBUG     constant varchar2(10) := 'DEBUG'; 
    INFO      constant varchar2(10) := 'INFO'; 
    ERROR     constant varchar2(10) := 'ERROR'; 
    -- target types 
    BOTH     constant varchar2(10) := 'BOTH'; 
    SCREEN   constant varchar2(20) := 'SCREEN'; 
    TAB      constant varchar2(20) := 'TABLE'; 


    procedure override_debug_settings 
    ( 
        i_debug_level                   in      tetl_processing_logger_config.debug_level%type 
       ,i_debug_target                  in      tetl_processing_logger_config.debug_target%type 
    ); 


    procedure record_step 
    ( 
        i_step                          in      tetl_processing_log.processing_module_step%type 
       ,i_debug_level                   in      tetl_processing_logger_config.debug_level%type := pa_util_logger.debug 
       ,i_sub_module                    in      tetl_processing_log.processing_sub_module%type := null 
       ,i_parameter_name_1              in      tetl_processing_log.parameter_name_1%type := null 
       ,i_parameter_value_1             in      varchar2 := null 
       ,i_parameter_name_2              in      tetl_processing_log.parameter_name_2%type := null 
       ,i_parameter_value_2             in      varchar2 := null 
       ,i_parameter_name_3              in      tetl_processing_log.parameter_name_3%type := null 
       ,i_parameter_value_3             in      varchar2 := null 
       ,i_parameter_name_4              in      tetl_processing_log.parameter_name_4%type := null 
       ,i_parameter_value_4             in      varchar2 := null 
       ,i_parameter_name_5              in      tetl_processing_log.parameter_name_5%type := null 
       ,i_parameter_value_5             in      varchar2 := null 
       ,i_parameter_name_6              in      tetl_processing_log.parameter_name_6%type := null 
       ,i_parameter_value_6             in      varchar2 := null 
       ,i_parameter_name_7              in      tetl_processing_log.parameter_name_7%type := null 
       ,i_parameter_value_7             in      varchar2 := null 
       ,i_parameter_name_8              in      tetl_processing_log.parameter_name_8%type := null 
       ,i_parameter_value_8             in      varchar2 := null 
       ,i_parameter_name_9              in      tetl_processing_log.parameter_name_9%type := null 
       ,i_parameter_value_9             in      varchar2 := null 
       ,i_parameter_name_10             in      tetl_processing_log.parameter_name_10%type := null 
       ,i_parameter_value_10            in      varchar2 := null 
    ); 
end; 

Log records are written to ams_etl.tetl_processing_log table 

create or replace package ams_etl.pa_util_error 
as 
    --******************************************************************************* 
    -- 
    -- This package contains routines to raise oracle errors 
    -- 
    -- %PCMS_HEADER_SUBSTITUTION_START% 
    --       File: %ARCHIVE% 
    --       $Revision %PR% 
    --       Author: %AUTHOR% 
    --       Last Changed: %PRT% 
    -- %PCMS_HEADER_SUBSTITUTION_END% 
    -- 
    --******************************************************************************* 

    /** 
    *  Raise an application error 
    * 
    * @param i_error                        Error Mnemonic 
    * @param i_parameter_1                  Parameter value for substitution variable 1 
    * @param i_parameter_2                  Parameter value for substitution variable 2 
    * @param i_parameter_3                  Parameter value for substitution variable 3 
    * @param i_parameter_4                  Parameter value for substitution variable 4 
    * @param i_parameter_5                  Parameter value for substitution variable 5 
    * @param i_parameter_6                  Parameter value for substitution variable 6 
    * @param i_parameter_7                  Parameter value for substitution variable 7 
    * @param i_parameter_8                  Parameter value for substitution variable 8 
    * @param i_parameter_9                  Parameter value for substitution variable 9 
    * @param i_parameter_10                 Parameter value for substitution variable 10 
    */ 
    procedure raise_error 
    ( 
        i_error                         in      tetl_processing_error.error_mnemonic%type 
       ,i_parameter_1                   in      varchar2 := NULL 
       ,i_parameter_2                   in      varchar2 := NULL 
       ,i_parameter_3                   in      varchar2 := NULL 
       ,i_parameter_4                   in      varchar2 := NULL 
       ,i_parameter_5                   in      varchar2 := NULL 
       ,i_parameter_6                   in      varchar2 := NULL 
       ,i_parameter_7                   in      varchar2 := NULL 
       ,i_parameter_8                   in      varchar2 := NULL 
       ,i_parameter_9                   in      varchar2 := NULL 
       ,i_parameter_10                  in      varchar2 := NULL 
    ); 

end; 

Note - Errors are held in ams_etl.tetl_processing_error table 




create or replace procedure ams_etl.split_gilt_run1 
( 
    i_batch_run_id                 tetl_batch_log.batch_run_id%type  -- '19660' 
) 
as 
    
    l_target_table_list            ams_etl.t_varchar2_list    := t_varchar2_list();           -- need to check name of type 
    l_target_system_data_cd        ams_etl.t_varchar2_list    := t_varchar2_list();           -- need to check name of type 
    l_gilt_details                 t_gilt_detail_list := t_gilt_detail_list(); 
    l_sql_statement                varchar2(32767); 
    l_sql_statement1               varchar2(32767); 
    l_sql_statement2               varchar2(32767); 
    l_column_list                  varchar2(32767); 
    l_column_list2                  varchar2(32767); 
    l_table_name                   varchar2(61); 

    e_no_data                      exception; 
    e_no_gilts                     exception; 

begin 
-- get target data tables for given Batch Run ID (i_batch_run_id) 
    select  tblst.table_schema || '.' || tblst.table_name, tblst.system_data_cd 
    bulk collect into l_target_table_list, l_target_system_data_cd 
    from    tetl_batch_log_src_tgt   tblst 
    where   tblst.batch_run_id = i_batch_run_id 
    and     tblst.source_target_type_cd = 'TARGET'; 

    if (l_target_table_list.count = 0) 
    then 
        raise e_no_data; 
    end if; 

-- build sql to check for GILTS in report_group columns 
    for i in 1..l_target_table_list.count 
    loop 
        l_sql_statement := 'union all ' || 
                           'select  distinct report_group from ' || 
                                    l_target_table_list(i) || 
                           ' where etl_batch_run_id = ' || i_batch_run_id; -- report_group column might not be there Saroj needs an appropriate error message.
    end loop;                                     
    l_sql_statement := 'select substr(report_group,instr(report_group,''GILTS'',-1) + 5),' || 
                               ' seq_gl_batch_id.nextval,' || 
                               ' seq_job_run_id.nextval' || 
                       ' from (' || 
                               substr(l_sql_statement,11) || 
                             ')' || 
                       ' where instr(report_group,''GILTS'') > 0'; 

    execute immediate l_sql_statement bulk collect into l_gilt_details; 
  
    if (l_gilt_details.count = 0) 
    then 
        raise e_no_gilts; 
    end if; 

--     create new batches 
    insert into tetl_batch_log 
            (batch_run_id, batch_cd, start_time, end_time, status) 
    select   lgd.batch_run_id 
            ,tbl.batch_cd 
            ,tbl.start_time 
            ,tbl.end_time 
            ,tbl.status 
     from   table(l_gilt_details)  lgd 
    cross join 
            tetl_batch_log  tbl 
    where   tbl.batch_run_id = i_batch_run_id; 


    insert into ams_etl.tetl_batch_log_src_tgt 
           (batch_run_id, batch_cd, source_target_type_cd, system_data_set_cd, system_data_cd, system_data_type_cd, file_name, file_no_of_records, data_file_delimiter) 
    select  lgd.batch_run_id 
           ,tblst.batch_cd 
           ,tblst.source_target_type_cd 
           ,tblst.system_data_set_cd 
           ,tblst.system_data_cd 
           ,tblst.system_data_type_cd 
           ,tblst.file_name 
           ,tblst.file_no_of_records 
           ,tblst.data_file_delimiter 
    from    table(l_gilt_details)  lgd 
    cross join 
            ams_etl.tetl_batch_log_src_tgt  tblst 
    where   tblst.batch_run_id = i_batch_run_id 
    and     tblst.SOURCE_TARGET_TYPE_CD = 'SOURCE'; 


    -- create link between batches 
    insert into tetl_batch_run_list     -- have to check which way round the columns should be 
           (batch_run_id,batch_cd,dependent_batch_run_id,dependent_batch_cd,dependent_batch_end_time) 
    select  lgd.batch_run_id 
           ,'LOAD_MOSES_RESULTS' 
           ,i_batch_run_id 
           ,'LOAD_MOSES_RESULTS' 
           ,sysdate 
    from   table(l_gilt_details) lgd; 
   

    -- create new job run details 
    insert into tams_job_run 
           (job_run_id,job_id,scenario_number,job_run_status,job_file_name,start_dt,end_dt) 
    select  lgd.job_run_id 
           ,tjr.job_id 
           ,(tjr.scenario_number * 10000) + lgd.gilt_number 
           ,tjr.job_run_status 
           ,tjr.job_file_name 
           ,tjr.start_dt 
           ,tjr.end_dt 
    from   table(l_gilt_details)  lgd 
    cross join 
           tams_job_run  tjr 
    where  tjr.job_run_id = (select tjrb.job_run_id from tams_job_run_batch tjrb where tjrb.batch_run_id = i_batch_run_id); 


    -- repeat above for child tables of tams_job_run 

    insert into ams.tams_job_run_parameter 
           (JOB_RUN_ID,PARAMETER_TYPE, PARAMETER_VALUE) 
    select lgd.JOB_RUN_ID 
           ,tjrp.PARAMETER_TYPE 
           ,tjrp.PARAMETER_VALUE 
    from   table(l_gilt_details)  lgd 
    cross join 
           ams.tams_job_run_parameter  tjrp 
    where  tjrp.job_run_id = (select tjrb.job_run_id from tams_job_run_batch tjrb where tjrb.batch_run_id = i_batch_run_id); 


    insert into ams.tams_job_run_rep_basis 
           (JOB_RUN_ID,REPORTING_BASIS,REPORTING_GROUP_MAP_VERSION) 
    select  lgd.JOB_RUN_ID 
           ,tjrrb.REPORTING_BASIS 
           ,tjrrb.REPORTING_GROUP_MAP_VERSION 
    from   table(l_gilt_details)  lgd 
    cross join 
           ams.tams_job_run_rep_basis  tjrrb 
    where  tjrrb.job_run_id = (select tjrb.job_run_id from tams_job_run_batch tjrb where tjrb.batch_run_id = i_batch_run_id); 


    insert into ams.tams_job_run_rep_group 
           (JOB_RUN_ID,REPORTING_BASIS,REPORTING_GROUP) 
    select lgd.JOB_RUN_ID, 
           tjrrg.REPORTING_BASIS, 
           tjrrg.REPORTING_GROUP 
    from table(l_gilt_details)  lgd 
    cross join 
           ams.tams_job_run_rep_group  tjrrg 
    where  tjrrg.job_run_id = (select tjrb.job_run_id from tams_job_run_batch tjrb where tjrb.batch_run_id = i_batch_run_id); 
    

    insert into tams_job_run_risk_factor 
           (JOB_RUN_RISK_FACTOR_ID,JOB_RUN_ID,DESCRIPTION,RISK_FACTOR,RISK_FACTOR_TYPE,STRESS_DELTA,TERM_STRUCTURE_ID) 
    select  tjrrf.JOB_RUN_RISK_FACTOR_ID 
           ,lgd.JOB_RUN_ID 
           ,tjrrf.DESCRIPTION 
           ,tjrrf.RISK_FACTOR 
           ,tjrrf.RISK_FACTOR_TYPE 
           ,tjrrf.STRESS_DELTA 
           ,tjrrf.TERM_STRUCTURE_ID 
    from  table(l_gilt_details)  lgd 
    cross join 
          ams.tams_job_run_risk_factor  tjrrf 
    where  tjrrf.job_run_id = (select tjrb.job_run_id from tams_job_run_batch tjrb where tjrb.batch_run_id = i_batch_run_id); 


    -- create link between batc and job_run 
    insert into tams_job_run_batch 
           (job_run_id,batch_run_id) 
    select  lgd.job_run_id 
           ,lgd.batch_run_id 
    from    table(l_gilt_details)  lgd;   


    -- copy data 
    for i in 1..l_target_table_list.count 
    loop 
        l_table_name := l_target_table_list(i); 
        
        -- build column list from all_tab_columns for target table except etl_batch_run_id 
        for i in 
        ( 
            select atc.column_name 
            from   all_tab_columns atc 
            where  atc.owner = substr(l_table_name,1,instr(l_table_name,'.') - 1) 
            and    atc.table_name = substr(l_table_name,instr(l_table_name,'.') + 1) 
            and    atc.column_name != 'ETL_BATCH_RUN_ID' 
        ) 
        loop 
               l_column_list := l_column_list || i.column_name || ','; 
               l_column_list2 := l_column_list2 || 't.' || i.column_name || ','; 
        end loop; 

-- copy data 
        l_sql_statement1:= 'insert into ' || l_target_table_list(i) || '(' || 
                                   l_column_list || 'ETL_BATCH_RUN_ID' ||                --<column_list>, 
                                   ')' || 
                           ' select ' || l_column_list2 || 
                                    ' lgb.batch_run_id'  || 
                           ' from ' ||  l_target_table_list(i) || ' t ' || --<target_table> t 
                           ' inner join ' || 
                                     ' table(:gilt_details)   lgd' || 
                                     ' on  t.report_group like ''%GILT''  || to_char(lgd.gilt_number)' || 
                           ' where  t.etl_batch_run_id = ' || i_batch_run_id || ' ;'; 

        execute immediate l_sql_statement1 using l_gilt_details; 


-- create batch_log_src_tgt target record 
        l_sql_statement2:= 'insert into telt_batch_log_src_tgt' || 
                                   ' (BATCH_RUN_ID,BATCH_CD,SOURCE_TARGET_TYPE_CD,SYSTEM_DATA_SET_CD,SYSTEM_DATA_CD,SYSTEM_DATA_TYPE_CD,SOURCE_TARGET_OBJECT,SOURCE_TARGET_OBJECT_DATA_CNT,FILE_NAME,FILE_NO_OF_RECORDS,DATA_FILE_DELIMITER,USE_QUOTED_FIELD_VALUES,HEADER_PRESENT,TRAILER_PRESENT,TABLE_NAME,TABLE_SCHEMA,TABLE_DESCRIPTION,TABLE_TYPE,NUM_ROWS_INSERTED)' || 
                           ' select t.batch_run_id,' || 
                                   chr(39) || 'LOAD_MOSES_RESULTS' || chr(39) || ',' || 
                                   chr(39) || 'TARGET' || chr(39) || ',' || 
                                   chr(39) || 'MOSES_RESULT_DATA' || chr(39) || ',' || 
                                   l_target_system_data_cd(i) || ',' || 
                                   chr(39) || 'Database Table' || chr(39) || ',' || 
                                   l_target_table_list(i) || ',' || 
                                   'count(*),null,null,null,null,null,null,' || 
                                   'substr(' || l_target_table_list(i) || ',1,instr(' || l_target_table_list(i) || ',' || chr(39) || '.' || chr(39) || ') - 1),' || 
                                   'substr(' || l_target_table_list(i) || ',instr(' || l_target_table_list(i) || ',' || chr(39)  || '.' || chr(39) || ') + 1),' || 
                                   l_target_table_list(i) || ',null, count(*)' ||   
                           ' from  ' || l_target_table_list(i) || ' t, ' || l_target_system_data_cd(i) || 
                           ' inner join ' || 
                           ' table(l_gilt_details)  lgd' || 
                           ' on  t.etl_batch_run_id = lgd.batch_run_id;'; 

        execute immediate l_sql_statement2; 
    end loop; 
                

exception 
    when e_no_data or e_no_gilts 
    then 
        null; 
  
end split_gilt_run1; 




Example package with logging 


create or replace package body ams_etl.pa_fw_data_retention 
as 
    --******************************************************************************* 
    -- 
    -- This package contains routines to delete data outside specified retention periods 
    -- 
    -- %PCMS_HEADER_SUBSTITUTION_START% 
    --       File: %ARCHIVE% 
    --       $Revision %PR% 
    --       Author: %AUTHOR% 
    --       Last Changed: %PRT% 
    -- %PCMS_HEADER_SUBSTITUTION_END% 
    -- 
    --******************************************************************************* 

    /** 
    * Remove data older than a specified retention period 
    * The retention period can be specified at SYSTEM_DATA / SYSTEM_DATA_SET level, there values are specified at both levels 
    * the maximum retention period is used. 
    * The RETENTION_TYPE can be either 
    *    ROLLING - Whereby the the RETENTION_PERIOD specifies the offset from the current date. The last character of the 
    *              RETENTION_PERIOD specifies the units D - Days, W - Weeks, M - Months and Y - Years 
    *    FIXED   - The RETENTION_PERIOD specifies a specific date, any data prior to this will be removed 
    * 
    * @param i_batch_cd                     The unique id of the batch/logical process 
    * @param i_batch_run_id                 The unique id for run instance of the batch 
    * @param i_workflow_name                The name of the workflow step within the batch (ALL is across all batches) 
    * @exception always returned to calling module 
    */ 
    procedure  remove_data 
    ( 
        i_batch_cd                      in      tetl_batch_log.batch_cd%type 
       ,i_batch_run_id                  in      tetl_batch_log.batch_run_id%type 
       ,i_workflow_name                 in      tetl_batch_def_proc_wf.workflow_name%type 
    ) 
    as 
        l_sub_module                    varchar2(30) := 'remove_data'; 
        l_default_date                  date := to_date('31/12/4000','DD/MM/YYYY'); 
        l_sql_statement                 varchar2(32767); 
        l_data_removed                  boolean := false; 
        l_process_log_retention_period  pls_integer; 
        e_partition_does_not_exist      exception; 

        pragma exception_init (e_partition_does_not_exist,-2149); 
    begin 
        pa_util_logger.record_step 
        ( 
            i_debug_level => pa_util_logger.info 
           ,i_sub_module => l_sub_module 
           ,i_step => 'Start' 
           ,i_parameter_name_1  => 'i_batch_cd' 
           ,i_parameter_value_1 => i_batch_cd 
           ,i_parameter_name_2  => 'i_batch_run_id' 
           ,i_parameter_value_2 => to_char(i_batch_run_id) 
        ); 

        for tab in 
        ( 
            with published_batches 
            as 
            ( 
                select /*+ materialize */ 
                       tjrb.batch_run_id 
                from   ams.tams_job_run_signoff  tjrs 
                inner join 
                       tams_job_run_batch  tjrb 
                  on   tjrb.job_run_id = tjrs.job_run_id 
                where  tjrs.current_status in ('DRAFT','AUTHORISED') 
            ) 
           ,linked_batches 
            as 
            ( 
                select  tbrl.dependent_batch_run_id  batch_run_id 
                from    tetl_batch_run_list tbrl 
                connect by tbrl.batch_run_id = prior tbrl.dependent_batch_run_id 
                start with tbrl.batch_run_id in 
                       ( 
                            select pb.batch_run_id 
                            from   published_batches pb 
                       ) 
                union all 
                select  pb.batch_run_id 
                from    published_batches pb 
            ) 
            select  rp.system_data_set_cd 
                   ,rp.system_data_cd 
                   ,rp.retention_lwm 
                   ,tblst.table_name 
                   ,tblst.table_schema 
                   ,atab.partitioned 
                   ,tbl.batch_cd 
                   ,tbl.batch_run_id 
            from    ( 
                        select  tsds.system_data_set_cd 
                               ,tsd.system_data_cd 
                               ,trunc 
                                ( 
                                    least 
                                    ( 
                                        -- SYSTEM_DATA values 
                                        case tsd.retention_type 
                                            when 'FIXED' 
                                            then 
                                                to_date(tsd.retention_period,'DD/MM/YYYY') 
                                            when 'ROLLING' 
                                            then 
                                                case substr(tsd.retention_period,-1) 
                                                    -- Retention specified in days 
                                                    when 'D' 
                                                    then 
                                                        sysdate - to_number(substr(tsd.retention_period,1,length(tsd.retention_period) - 1)) 
                                                    -- Retention specified in weeks 
                                                    when 'W' 
                                                    then 
                                                        sysdate - (to_number(substr(tsd.retention_period,1,length(tsd.retention_period) - 1)) * 7) 
                                                    -- Retention specified in months 
                                                    when 'M' 
                                                    then 
                                                        add_months(sysdate,(to_number(substr(tsd.retention_period,1,length(tsd.retention_period) - 1)) * -1)) 
                                                    -- Retention specified in years 
                                                    when 'Y' 
                                                    then 
                                                        add_months(sysdate,(to_number(substr(tsd.retention_period,1,length(tsd.retention_period) - 1)) * -12)) 
                                                    else 
                                                       l_default_date 
                                                end 
                                            else 
                                                l_default_date 
                                        end 
                                        -- SYSTEM_DATA_SET values 
                                       ,case tsds.retention_type 
                                            when 'FIXED' 
                                            then 
                                                to_date(tsds.retention_period,'DD/MM/YYYY') 
                                            when 'ROLLING' 
                                            then 
                                                case substr(tsds.retention_period,-1) 
                                                    -- Retention specified in days 
                                                    when 'D' 
                                                    then 
                                                        sysdate - to_number(substr(tsds.retention_period,1,length(tsds.retention_period) - 1)) 
                                                    -- Retention specified in weeks 
                                                    when 'W' 
                                                    then 
                                                        sysdate - (to_number(substr(tsds.retention_period,1,length(tsds.retention_period) - 1)) * 7) 
                                                    -- Retention specified in months 
                                                    when 'M' 
                                                    then 
                                                        add_months(sysdate,(to_number(substr(tsds.retention_period,1,length(tsds.retention_period) - 1)) * -1)) 
                                                    -- Retention specified in years 
                                                    when 'Y' 
                                                    then 
                                                        add_months(sysdate,(to_number(substr(tsds.retention_period,1,length(tsds.retention_period) - 1)) * -12)) 
                                                    else 
                                                        l_default_date 
                                                end 
                                            else 
                                                l_default_date 
                                        end 
                                    ) 
                                )  retention_lwm 
                        from    tetl_system_data   tsd 
                        inner join 
                                tetl_system_data_set_memb  tsdsm 
                          on    tsdsm.system_data_cd = tsd.system_data_cd 
                        inner join 
                                tetl_system_data_set  tsds 
                          on    tsds.system_data_set_cd = tsdsm.system_data_set_cd 
                        where   tsd.system_data_type_cd = 'Database Table' 
                        and     ( 
                                    ( 
                                        tsd.retention_type is not null 
                                        and 
                                        tsd.retention_period is not null 
                                    ) 
                                    or 
                                    ( 
                                        tsds.retention_type is not null 
                                        and 
                                        tsds.retention_period is not null 
                                    ) 
                                ) 
                    ) rp 
            inner join 
                    tetl_batch_log_src_tgt   tblst 
              on    tblst.system_data_set_cd = rp.system_data_set_cd 
              and   tblst.system_data_cd = rp.system_data_cd 
            inner join 
                    tetl_batch_log   tbl 
              on    tbl.batch_run_id = tblst.batch_run_id 
            inner join 
                    all_tables   atab 
              on    atab.owner = tblst.table_schema 
              and   atab.table_name = tblst.table_name 
            left outer join 
                    linked_batches  lb 
              on    lb.batch_run_id = tbl.batch_run_id 
            where   rp.retention_lwm != l_default_date 
            and     coalesce(tbl.end_time,tbl.batch_effective_date,tbl.start_time) <  rp.retention_lwm 
            and     coalesce(tblst.data_archived,'N') = 'N' 
            and     lb.batch_run_id is null    -- not used in a publication set 
        ) 
        loop 
            pa_util_logger.record_step 
            ( 
                i_debug_level => pa_util_logger.debug 
               ,i_sub_module => l_sub_module 
               ,i_step => 'processing table / batch' 
               ,i_parameter_name_1  => 'i_batch_run_id' 
               ,i_parameter_value_1 => tab.batch_run_id 
               ,i_parameter_name_2  => 'table_schema' 
               ,i_parameter_value_2 => tab.table_schema 
               ,i_parameter_name_3  => 'table_name' 
               ,i_parameter_value_3 => tab.table_name 
            ); 

            -- log removal 
            pa_fw_batch_control.maintain_batch_log_ora 
            ( 
                i_batch_cd       => i_batch_cd 
               ,i_batch_run_id   => i_batch_run_id 
               ,i_package_name   => 'pa_data_archiver' 
               ,i_procedure_name => 'remove_data' 
               ,i_msg            => 'Removing data relating to batch run - ' || to_char(tab.batch_run_id) || ' from table ' || tab.table_schema || '.' || tab.table_name 
            ); 


            if (tab.partitioned = 'YES') 
            then 
                l_sql_statement := 'alter table ' || tab.table_name || ' drop partition for (' || tab.batch_run_id || ') update indexes'; 
            else 
                l_sql_statement := 'delete from ' || tab.table_name || ' where etl_batch_run_id = ' || tab.batch_run_id; 
            end if; 

            pa_util_logger.record_step 
            ( 
                i_debug_level => pa_util_logger.debug 
               ,i_sub_module => l_sub_module 
               ,i_step => 'removal statement' 
               ,i_parameter_name_1  => 'l_sql_statement' 
               ,i_parameter_value_1 => l_sql_statement 
            ); 

            begin 
                execute immediate 'begin ' || tab.table_schema || '.pr_execute_ddl(''' || l_sql_statement || '''); end;'; 
            exception 
                when e_partition_does_not_exist 
                then 
                    null; 
            end; 


            -- flag the tgt table as being archived 
            pa_fw_batch_control.maintain_bat_log_src_tgt_table 
            ( 
                i_batch_cd              => tab.batch_cd 
               ,i_batch_run_id          => tab.batch_run_id 
               ,i_source_target_type_cd => 'TARGET' 
               ,i_table_name            => tab.table_name 
               ,i_table_schema          => tab.table_schema 
               ,i_data_archived         => 'Y' 
            ); 

            l_data_removed := true; 
        end loop; 

        if (not l_data_removed) 
        then 
            pa_fw_batch_control.maintain_batch_log_ora 
            ( 
                i_batch_cd       => i_batch_cd 
               ,i_batch_run_id   => i_batch_run_id 
               ,i_package_name   => 'pa_data_archiver' 
               ,i_procedure_name => 'remove_data' 
               ,i_msg            => 'No data removed' 
            ); 
        end if; 


        pa_util_logger.record_step 
        ( 
            i_debug_level => pa_util_logger.info 
           ,i_sub_module => l_sub_module 
           ,i_step => 'Deleting old process log data' 
        ); 

        -- default to 7 days 
        l_process_log_retention_period := coalesce 
                                          ( 
                                              pa_util_session_variables.get_application_setting 
                                              ( 
                                                  i_setting_name => 'PROCESS_LOG_RETENTION_IN_DAYS' 
                                              ) 
                                             ,7 
                                          ); 

        delete from tetl_processing_log  tpl 
        where  tpl.processing_module_step_dt < sysdate - l_process_log_retention_period; 



        pa_util_logger.record_step 
        ( 
            i_debug_level => pa_util_logger.info 
           ,i_sub_module => l_sub_module 
           ,i_step => 'Finish' 
        ); 

    exception 
        when others 
        then 
            pa_util_logger.record_step 
            ( 
                i_debug_level => pa_util_logger.error 
               ,i_sub_module => l_sub_module 
               ,i_step => 'Exception' 
               ,i_parameter_name_1 => 'Error Message' 
               ,i_parameter_value_1 => SQLERRM 
            ); 

            raise; 
    end; 

end; 



--------------------

select  tblst.table_schema || '.' || tblst.table_name, tblst.system_data_cd, batch_run_id
    from    ams_etl.tetl_batch_log_src_tgt   tblst 
    where   tblst.batch_run_id= 19660 
    and     tblst.source_target_type_cd = 'TARGET'
    order by batch_run_id
    
select distinct report_group from AMS.TAMS_DISCOUNT_CASHFLOW_NL_S1 where etl_batch_run_id = 19660

select substr(report_group,instr(report_group,'GILTS',-1) + 5)  from 
(select report_group from AMS.TAMS_DISCOUNT_CASHFLOW_NL_S1 where etl_batch_run_id = 19660)
                        where instr(report_group,'GILTS') > 0;

insert into tetl_batch_log for each record of the above output

    select  tbl.batch_cd 
            ,tbl.start_time 
            ,tbl.end_time 
            ,tbl.status 
     from   ams_etl.tetl_batch_log  tbl 
    where   tbl.batch_run_id = 19660;
    
Insert into tetl_batch_log_src_tgt for each record of the above output

Insert into tetl_batch_run_list 

insert into ams.tams_job_run where batch run id in tams_job_run_batch

insert into ams.tams_job_run_parameter for each record of the above output and batch run id in tams_job_run_batch

insert into ams.tams_job_run_rep_basis for each record of the above output and batch run id in tams_job_run_batch

insert into ams.tams_job_run_rep_group for each record of the above output and batch run id in tams_job_run_batch

insert into tams_job_run_risk_factor for each record of the above output and batch run id in tams_job_run_batch

insert into tams_job_run_batch

list of comma separated 

column names

SELECT GlitNum, ams.seq_gl_batch_id.nextval, ams.seq_job_run_id.nextval FROM
(
SELECT distinct to_number(substr(report_group,instr(report_group,'GILTS',-1) + 5)) as GlitNum
FROM AMS.TAMS_DISCOUNT_CASHFLOW_NL_S13
WHERE report_group like '%GILTS%'
)


DECLARE
	T_GILT_DETAILS                 AMS_ETL.GILT_NUM_TAB := AMS_ETL.GILT_NUM_TAB(); 
	a number;
	b number;
	c number;
	i number:=0;
BEGIN
	for glitcur in
	(SELECT GlitNum a, ams.seq_gl_batch_id.nextval b, ams.seq_job_run_id.nextval c
		FROM
		(
			SELECT distinct to_number(substr(report_group,instr(report_group,'GILTS',-1) + 5)) as GlitNum
			FROM AMS.TAMS_DISCOUNT_CASHFLOW_NL_S13
			WHERE report_group like '%GILTS%'
		)
	)
	loop 
		i := i+1;
		T_GILT_DETAILS.extend();
		T_GILT_DETAILS(i) := AMS_ETL.T_THREE_NUMB(glitcur.a,glitcur.b,glitcur.c);
	end loop;
	for i in (select * from table(T_GILT_DETAILS))
	loop
		dbms_output.put_line(i.glit_number);
		null;
	end loop;

EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

PLS-00310: with %ROWTYPE attribute, 'AMS_ETL.GILT_NUM_TAB' must name a table, cursor or cursor-variable


DECLARE
	T_GILT_DETAILS                 AMS_ETL.GILT_NUM_TAB;
	l_target_table_list            ams_etl.t_varchar2_list    := ams_etl.t_varchar2_list(); 
BEGIN
	SELECT GlitNum  bulk collect into l_target_table_list
	FROM
	(
	SELECT distinct to_number(substr(report_group,instr(report_group,'GILTS',-1) + 5)) as GlitNum
	FROM AMS.TAMS_DISCOUNT_CASHFLOW_NL_S13
	where report_group like '%GILTS%'
	);
	for i in (select column_value as val from table(l_target_table_list))
	loop
		dbms_output.put_line(i.val);
		null;
	end loop;
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/


CREATE TYPE AMS_ETL.T_THREE_NUMB AS OBJECT
(
	glit_number   number(5)
	,batch_run_id number
	,job_run_id   number
);
/
-- DROP TYPE AMS_ETL.T_THREE_NUMB;

CREATE OR REPLACE TYPE AMS_ETL.GILT_NUM_TAB AS TABLE OF T_THREE_NUMB;
/


CREATE OR REPLACE TYPE department_t AS OBJECT (
   deptno number(10),
   dname CHAR(30));

CREATE OR REPLACE TYPE employee_t AS OBJECT(
   empid RAW(16),
   ename CHAR(31),
   dept REF department_t,
      STATIC function construct_emp
      (name VARCHAR2, dept REF department_t)
      RETURN employee_t
);

create or replace type ams_etl.T_GILT_DETAIL as object (gilt_number  number(5)
                                    ,batch_run_id number(18)
                                    ,job_run_id   number(18)
                                    )

create or replace type ams_etl.T_GILT_DETAIL_LIST is table of ams_etl.T_GILT_DETAIL;


Failed Attempts
------------------
DECLARE
	T_GILT_DETAILS                 AMS_ETL.GILT_NUM_TAB := AMS_ETL.GILT_NUM_TAB(); 
	TYPE glitcur IS REF CURSOR RETURN AMS_ETL.GILT_NUM_TAB%ROWTYPE;
	glit_cv  glitcur;
	glit_rec AMS_ETL.GILT_NUM_TAB%ROWTYPE;
BEGIN
	for glit_cv in
	(SELECT GlitNum, ams.seq_gl_batch_id.nextval, ams.seq_job_run_id.nextval
		FROM
		(
			SELECT distinct to_number(substr(report_group,instr(report_group,'GILTS',-1) + 5)) as GlitNum
			FROM AMS.TAMS_DISCOUNT_CASHFLOW_NL_S13
			WHERE report_group like '%GILTS%'
		)
	)
	loop 
		fetch glit_cv into glit_rec;
	end loop;

EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

PLS-00310: with %ROWTYPE attribute, 'AMS_ETL.GILT_NUM_TAB' must name a table, cursor or cursor-variable
