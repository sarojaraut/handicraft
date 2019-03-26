begin
dbms_scheduler.create_job (
job_name => 'TempJob',
job_type => 'PLSQL_BLOCK',
job_action => '
begin 
ams_etl.temp_create_moses_data_table;
end; ',
enabled => TRUE,
comments => 'USGAAP Cube analysis, time taking table creation');
end;
/

select * from dba_scheduler_jobs where job_name='TempJob';

begin
dbms_scheduler.run_job('TEMPJOB',TRUE);
end;
/

begin
dbms_scheduler.drop_job (
job_name => 'TEMPJOB'
);
end;
/

select * from dba_scheduler_jobs where job_name='TEMPJOB'

select * from dba_scheduler_running_jobs

To use an existing program when creating a job, the owner of the job must be the owner of the program or have EXECUTE privileges on it. The following PL/SQL block is an example of a CREATE_JOB procedure with a named program that creates a regular job called my_new_job1:

BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name          =>  'my_new_job1',
   program_name      =>  'my_saved_program', 
   repeat_interval   =>  'FREQ=DAILY;BYHOUR=12',
   comments          =>  'Daily at noon');
END;
/

BYHOUR=14; BYMINUTE=14

Creating Jobs Using a Named Schedule

BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name                 =>  'my_new_job2', 
   job_type                 =>  'PLSQL_BLOCK',
   job_action               =>  'BEGIN SALES_PKG.UPDATE_SALES_SUMMARY; END;',
   schedule_name            =>  'my_saved_schedule');
END;
/

Creating Jobs Using Named Programs and Schedules

BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name            =>  'my_new_job3', 
   program_name        =>  'my_saved_program1', 
   schedule_name       =>  'my_saved_schedule1');
END;
/

Altering Jobs

BEGIN
  DBMS_SCHEDULER.SET_ATTRIBUTE (
   name         =>  'update_sales',
   attribute    =>  'repeat_interval',
   value        =>  'freq=weekly; byday=wed');
END;
/

Running Jobs

By calling DBMS_SCHEDULER.RUN_JOB—You can use the RUN_JOB procedure to test a job or to run it outside of its specified schedule. You can run the job asynchronously, which is similar to the previous two methods of running a job, or synchronously, in which the job runs in the session that called RUN_JOB, and as the user logged in to that session. The use_current_session argument of RUN_JOB determines whether a job runs synchronously or asynchronously

RUN_JOB accepts a comma-delimited list of job names.

The following example asynchronously runs two jobs:
BEGIN
  DBMS_SCHEDULER.RUN_JOB(
    JOB_NAME            => 'DSS.ETLJOB1, DSS.ETLJOB2',
    USE_CURRENT_SESSION => FALSE);
END;
/

Stopping Jobs

You stop one or more running jobs using the STOP_JOB procedure.  For example, the following statement stops job job1, all jobs in the job class dw_jobs, and two child jobs of a multiple-destination job:

BEGIN
  DBMS_SCHEDULER.STOP_JOB('job1, sys.dw_jobs, 984, 1223');
END;
/

All instances of the designated jobs are stopped. After stopping a job, the state of a one-time job is set to STOPPED, and the state of a repeating job is set to SCHEDULED (because the next run of the job is scheduled). In addition, an entry is made in the job log with OPERATION set to 'STOPPED', and ADDITIONAL_INFO set to 'REASON="Stop job called by user: username"'.

Dropping Jobs

You drop one or more jobs using the DROP_JOB procedure or Enterprise Manager. DROP_JOB accepts a comma-delimited list of jobs and job classes. If a job class is supplied, all jobs in the job class are dropped, although the job class itself is not dropped.

The following statement drops jobs job1 and job3, and all jobs in job classes jobclass1 and jobclass2:

BEGIN
  DBMS_SCHEDULER.DROP_JOB ('job1, job3, sys.jobclass1, sys.jobclass2');
END;
/

If a job is running at the time of the procedure call, the attempt to drop the job fails. You can modify this default behavior by setting either the force or defer option.

When you set the force option to TRUE, the Scheduler first attempts to stop the running job by using an interrupt mechanism—calling STOP_JOB with the force option set to FALSE. If the job is successfully stopped, the job is then dropped. Alternatively, you can call STOP_JOB to first stop the job and then call DROP_JOB. If STOP_JOB fails, you can call STOP_JOB with the force option, provided you have the MANAGE SCHEDULER privilege.

When you specify multiple jobs to drop, the commit_semantics argument determines the outcome when an error occurs on one of the jobs. The following are the possible values for this argument:

•STOP_ON_FIRST_ERROR, the default—The call returns on the first error and the previous drop operations that were successful are committed to disk.
•TRANSACTIONAL—The call returns on the first error and the previous drop operations before the error are rolled back. force must be FALSE.
•ABSORB_ERRORS—The call tries to absorb any errors, attempts to drop the rest of the jobs, and commits all the drops that were successful.

BEGIN
  DBMS_SCHEDULER.DROP_JOB(
     job_name         => 'myjob1, myjob2',
     defer            => TRUE,
     commit_semantics => 'TRANSACTIONAL');
END;
/

Disabling Jobs

You disable one or more jobs using the DISABLE procedure or Enterprise Manager. A job can also become disabled for other reasons. For example, a job will be disabled when the job class it belongs to is dropped. A job is also disabled if either the program or the schedule that it points to is dropped. Note that if the program or schedule that the job points to is disabled, the job will not be disabled and will therefore result in an error when the Scheduler tries to run the job.

Disabling a job means that, although the metadata of the job is there, it should not run and the job coordinator will not pick up these jobs for processing. When a job is disabled, its state in the job table is changed to disabled.

Enabling Jobs

BEGIN
 DBMS_SCHEDULER.ENABLE ('job1, job2, job3, sys.jobclass1, sys.jobclass2, sys.jobclass3');
END;
/

Using Events to Start Jobs

An event is a message sent by one application or system process to another to indicate that some action or occurrence has been detected. An event is raised (sent) by one application or process, and consumed (received) by one or more applications or processes.

There are two kinds of events consumed by the Scheduler:
•Events raised by your application : An application can raise an event to be consumed by the Scheduler. The Scheduler reacts to the event by starting a job. For example, when an inventory tracking system notices that the inventory has gone below a certain threshold, it can raise an event that starts an inventory replenishment job.
•File arrival events raised by a file watcher : You can create a file watcher—a Scheduler object introduced in Oracle Database 11g Release 2—to watch for the arrival of a file on a system. 

Creating File Watchers and File Watcher Jobs

You perform the following tasks to create a file watcher and create the event-based job that starts when the designated file arrives.
Task 1   - Create a Credential : The file watcher requires a Scheduler credential object (a credential) with which to authenticate with the host operating system for access to the file.

    1.Create a credential for the operating system user that must have access to the watched-for file.

    BEGIN
      DBMS_SCHEDULER.CREATE_CREDENTIAL('WATCH_CREDENTIAL', 'salesapps', 'sa324w1');
    END;
    /

    2.Grant the EXECUTE object privilege on the credential to the schema that owns the event-based job that the file watcher will start.
    GRANT EXECUTE ON WATCH_CREDENTIAL to DSSUSER;

Task 2   - Create a File Watcher

    Perform these steps:

    1.Create the file watcher : You can specify wildcard parameters in the file name. A '?' prefix in the DIRECTORY_PATH attribute denotes the path to the Oracle home directory.

    BEGIN
      DBMS_SCHEDULER.CREATE_FILE_WATCHER(
        FILE_WATCHER_NAME => 'EOD_FILE_WATCHER',
        DIRECTORY_PATH    => '?/eod_reports',
        FILE_NAME         => 'eod*.txt',
        CREDENTIAL_NAME   => 'WATCH_CREDENTIAL',
        DESTINATION       => NULL,
        ENABLED           => FALSE);
    END;
    /

    2.Grant EXECUTE on the file watcher to any schema that owns an event-based job that references the file watcher.
    GRANT EXECUTE ON EOD_FILE_WATCHER to DSSUSER;

Task 3   - Create a Program Object with a Metadata Argument
So that your application can retrieve the file arrival event message content, which includes file name, file size, and so on, create a Scheduler program object with a metadata argument that references the event message.

Perform these steps:

    1.Create the program.
    BEGIN
      DBMS_SCHEDULER.CREATE_PROGRAM(
        PROGRAM_NAME        => 'DSSUSER.EOD_PROGRAM',
        PROGRAM_TYPE        => 'STORED_PROCEDURE',
        PROGRAM_ACTION      => 'EOD_PROCESSOR',
        NUMBER_OF_ARGUMENTS => 1,
        ENABLED             => FALSE);
    END;
    /

    2.Define the metadata argument using the event_message attribute.
    BEGIN
      DBMS_SCHEDULER.DEFINE_METADATA_ARGUMENT(
        PROGRAM_NAME       => 'DSSUSER.EOD_PROGRAM',
        METADATA_ATTRIBUTE => 'event_message',
        ARGUMENT_POSITION  => 1);
    END;
    /
    
    3.Create the stored procedure that the program invokes.

    The stored procedure that processes the file arrival event must have an argument of type SYS.SCHEDULER_FILEWATCHER_RESULT, which is the data type of the event message.
    
Task 4   - Create an Event-Based Job That References the File Watcher
Create the event-based job and provide the name of the file watcher in the queue_spec attribute.

Perform these steps to prepare the event-based job:

    1.Create the job.
    BEGIN
      DBMS_SCHEDULER.CREATE_JOB(
        JOB_NAME        => 'DSSUSER.EOD_JOB',
        PROGRAM_NAME    => 'DSSUSER.EOD_PROGRAM',
        EVENT_CONDITION => NULL,
        QUEUE_SPEC      => 'EOD_FILE_WATCHER',
        AUTO_DROP       => FALSE,
        ENABLED         => FALSE);
    END;
    /
    
    2.If you want the job to run for each instance of the file arrival event, even if the job is already processing a previous event, set the parallel_instances attribute to TRUE. With this setting, the job runs as a lightweight job so that multiple instances of the job can be started quickly. 
    
    BEGIN
    DBMS_SCHEDULER.SET_ATTRIBUTE('DSSUSER.EOD_JOB','PARALLEL_INSTANCES',TRUE);
    END;
    /

Task 5   - Enable All Objects
    Enable the file watcher, the program, and the job.
    BEGIN
       DBMS_SCHEDULER.ENABLE('DSSUSER.EOD_PROGRAM,DSSUSER.EOD_JOB,EOD_FILE_WATCHER');
    END;
    /
    
File Arrival Example

In this example, an event-based job watches for the arrival of end-of-day sales reports onto the local host from various locations. As each report file arrives, a stored procedure captures information about the file and stores the information in a table called eod_reports. A regularly scheduled report aggregation job can then query this table, process all unprocessed files, and mark any newly processed files as processed.

It is assumed that the database user running the following code has been granted EXECUTE on the SYS.SCHEDULER_FILEWATCHER_RESULT data type.


begin
  dbms_scheduler.create_credential(
     credential_name => 'watch_credential',
     username        => 'pos1',
     password        => 'jk4545st');
end;
/
 
create table eod_reports (when timestamp, file_name varchar2(100), 
   file_size number, processed char(1));
 
create or replace procedure q_eod_report 
  (payload IN sys.scheduler_filewatcher_result) as 
begin
  insert into eod_reports values 
     (payload.file_timestamp,
      payload.directory_path || '/' || payload.actual_file_name,
      payload.file_size,
      'N');
end;
/
 
begin
  dbms_scheduler.create_program(
    program_name        => 'eod_prog',
    program_type        => 'stored_procedure',
    program_action      => 'q_eod_report',
    number_of_arguments => 1,
    enabled             => false);
  dbms_scheduler.define_metadata_argument(
    program_name        => 'eod_prog',
    metadata_attribute  => 'event_message',
    argument_position   => 1);
  dbms_scheduler.enable('eod_prog');
end;
/
 
begin
  dbms_scheduler.create_file_watcher(
    file_watcher_name => 'eod_reports_watcher',
    directory_path    => '?/eod_reports',
    file_name         => 'eod*.txt',
    credential_name   => 'watch_credential',
    destination       => null,
    enabled           => false);
end;
/

begin
  dbms_scheduler.create_job(
    job_name        => 'eod_job',
    program_name    => 'eod_prog',
    event_condition => 'tab.user_data.file_size > 10',
    queue_spec      => 'eod_reports_watcher',
    auto_drop       => false,
    enabled         => false);
  dbms_scheduler.set_attribute('eod_job','parallel_instances',true);
end;
/

exec dbms_scheduler.enable('eod_reports_watcher,eod_job');

To change the file arrival detection interval: 

BEGIN
  DBMS_SCHEDULER.SET_ATTRIBUTE('FILE_WATCHER_SCHEDULE', 'REPEAT_INTERVAL',
    'FREQ=MINUTELY;INTERVAL=2');
END;
/

Viewing File Watcher Information

SELECT file_watcher_name, destination, directory_path, file_name, credential_name 
   FROM dba_scheduler_file_watchers;

BEGIN
    dbms_scheduler.create_job(  
        job_name        => 'EFRAME_TASK_MONITOR'
        ,job_type        => 'PLSQL_BLOCK'
        , job_action      => '
                          declare
                          v_count   number;
                          begin
                          v_count := 0;
                          for i in (select * from eframe_data.task@EFRAME_POC for update)
                          loop
                              dbms_lock.sleep(0.2);
                              v_count := v_count+1;
                          end loop;
                          dbms_output.put_line(''Total Number of records is : ''||v_count);
                          end;
                          '
        ,enabled         => TRUE
        ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=2;BYHOUR=9,10,11,12,13,14,15,16,17'
        ,comments        => 'Testing'
        );
END;
/
    
'FREQ=MONTHLY;INTERVAL=2;BYMONTHDAY=15;BYHOUR=9,17;INCLUDE=embed_sched'




begin
dbms_scheduler.create_job (
job_name => 'CEATEPRODUCT_1',
job_type => 'PLSQL_BLOCK',
job_action => '
begin
jda.uk_sku_upc_add(1474146, 153733);
end; ',
repeat_interval => 'FREQ=YEARLY;BYMONTH=4;BYMONTHDAY=18;BYHOUR=14; BYMINUTE=14',
enabled => TRUE,
comments => 'CeateProduct_1');
end;
/


begin
dbms_scheduler.drop_job (
job_name => 'CEATEPRODUCT_1'
);
end;
/



begin
dbms_scheduler.create_job (
job_name => 'CEATEPRODUCT_10',
job_type => 'PLSQL_BLOCK',
job_action => '
begin
jda.uk_sku_upc_add(1474146, 153733);
end; ',
repeat_interval => 'FREQ=YEARLY;BYMONTH=4;BYMONTHDAY=18;BYHOUR=14; BYMINUTE=21',
enabled => TRUE,
comments => 'CeateProduct_1');
end;
/

begin
dbms_scheduler.create_job (
job_name => 'CEATEPRODUCT_11',
job_type => 'PLSQL_BLOCK',
job_action => '
begin
jda.uk_sku_upc_add(1474146, 153733);
end; ',
repeat_interval => 'FREQ=YEARLY;BYMONTH=4;BYMONTHDAY=18;BYHOUR=14; BYMINUTE=21',
enabled => TRUE,
comments => 'CEATEPRODUCT_11');
end;
/

begin
dbms_scheduler.create_job (
job_name => 'CEATEPRODUCT_12',
job_type => 'PLSQL_BLOCK',
job_action => '
begin
jda.uk_sku_upc_add(1474146, 153733);
end; ',
repeat_interval => 'FREQ=YEARLY;BYMONTH=4;BYMONTHDAY=18;BYHOUR=14; BYMINUTE=21',
enabled => TRUE,
comments => 'CEATEPRODUCT_12');
end;
/

begin
dbms_scheduler.create_job (
job_name => 'CEATEPRODUCT_13',
job_type => 'PLSQL_BLOCK',
job_action => '
begin
jda.uk_sku_upc_add(1474146, 153733);
end; ',
repeat_interval => 'FREQ=YEARLY;BYMONTH=4;BYMONTHDAY=18;BYHOUR=14; BYMINUTE=21',
enabled => TRUE,
comments => 'CEATEPRODUCT_13');
end;
/

begin
dbms_scheduler.create_job (
job_name => 'CEATEPRODUCT_14',
job_type => 'PLSQL_BLOCK',
job_action => '
begin
jda.uk_sku_upc_add(1474146, 153733);
end; ',
repeat_interval => 'FREQ=YEARLY;BYMONTH=4;BYMONTHDAY=18;BYHOUR=14; BYMINUTE=21',
enabled => TRUE,
comments => 'CEATEPRODUCT_14');
end;
/

begin
dbms_scheduler.create_job (
job_name => 'CEATEPRODUCT_15',
job_type => 'PLSQL_BLOCK',
job_action => '
begin
jda.uk_sku_upc_add(1474146, 153733);
end; ',
repeat_interval => 'FREQ=YEARLY;BYMONTH=4;BYMONTHDAY=18;BYHOUR=14; BYMINUTE=21',
enabled => TRUE,
comments => 'CEATEPRODUCT_15');
end;
/


begin
dbms_scheduler.create_job (
job_name => 'CEATEPRODUCT_16',
job_type => 'PLSQL_BLOCK',
job_action => '
begin
jda.uk_sku_upc_add(1474146, 153733);
end; ',
repeat_interval => 'FREQ=YEARLY;BYMONTH=4;BYMONTHDAY=18;BYHOUR=14; BYMINUTE=21',
enabled => TRUE,
comments => 'CEATEPRODUCT_16');
end;
/


begin
dbms_scheduler.create_job (
job_name => 'CEATEPRODUCT_17',
job_type => 'PLSQL_BLOCK',
job_action => '
begin
jda.uk_sku_upc_add(1474146, 153733);
end; ',
repeat_interval => 'FREQ=YEARLY;BYMONTH=4;BYMONTHDAY=18;BYHOUR=14; BYMINUTE=21',
enabled => TRUE,
comments => 'CEATEPRODUCT_17');
end;
/

begin
dbms_scheduler.create_job (
job_name => 'CEATEPRODUCT_18',
job_type => 'PLSQL_BLOCK',
job_action => '
begin
jda.uk_sku_upc_add(1474146, 153733);
end; ',
repeat_interval => 'FREQ=YEARLY;BYMONTH=4;BYMONTHDAY=18;BYHOUR=14; BYMINUTE=21',
enabled => TRUE,
comments => 'CEATEPRODUCT_18');
end;
/

begin
dbms_scheduler.create_job (
job_name => 'CEATEPRODUCT_19',
job_type => 'PLSQL_BLOCK',
job_action => '
begin
jda.uk_sku_upc_add(1474146, 153733);
end; ',
repeat_interval => 'FREQ=YEARLY;BYMONTH=4;BYMONTHDAY=18;BYHOUR=14; BYMINUTE=21',
enabled => TRUE,
comments => 'CEATEPRODUCT_19');
end;
/

select * from dba_scheduler_jobs where job_name in (
'CEATEPRODUCT_10'
,'CEATEPRODUCT_11'
,'CEATEPRODUCT_12'
,'CEATEPRODUCT_13'
,'CEATEPRODUCT_14'
,'CEATEPRODUCT_15'
,'CEATEPRODUCT_16'
,'CEATEPRODUCT_17'
,'CEATEPRODUCT_18'
,'CEATEPRODUCT_19'
)

select * from DBA_SCHEDULER_JOB_RUN_DETAILS where job_name in (
'CEATEPRODUCT_10'
,'CEATEPRODUCT_11'
,'CEATEPRODUCT_12'
,'CEATEPRODUCT_13'
,'CEATEPRODUCT_14'
,'CEATEPRODUCT_15'
,'CEATEPRODUCT_16'
,'CEATEPRODUCT_17'
,'CEATEPRODUCT_18'
,'CEATEPRODUCT_19'
)

select * from DBA_SCHEDULER_JOB_LOG where job_name in (
'CEATEPRODUCT_10'
,'CEATEPRODUCT_11'
,'CEATEPRODUCT_12'
,'CEATEPRODUCT_13'
,'CEATEPRODUCT_14'
,'CEATEPRODUCT_15'
,'CEATEPRODUCT_16'
,'CEATEPRODUCT_17'
,'CEATEPRODUCT_18'
,'CEATEPRODUCT_19'
)



<br><span style="padding-left:10px;font-size: large; font-weight: bold; color: rgb(89,122,166);"> CMSDBA <br>

<center><font size="4" color="blue"> <b>CMSDBA</b></font></center>


BEGIN
    dbms_scheduler.create_job(  
        job_name        => 'CREATE_PO_AUDIT_REC'
        ,job_type        => 'PLSQL_BLOCK'
        , job_action      => '
                          declare
                          v_count   number;
                          begin
                          v_count := 0;
                          for i in (select * from eframe_data.task@EFRAME_POC for update)
                          loop
                              dbms_lock.sleep(0.2);
                              v_count := v_count+1;
                          end loop;
                          dbms_output.put_line(''Total Number of records is : ''||v_count);
                          end;
                          '
        ,enabled         => TRUE
        ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=5'
        ,comments        => 'Creating new instances of on-order PO records in AU_PO_CHG when the linked product attributes is changed'
        );
END;
/


begin
    for i in (select job_name from dba_scheduler_jobs where owner ='ITSR')
    loop
            dbms_scheduler.drop_job (
            job_name => i.job_name
            );
    end loop;
end;
/

