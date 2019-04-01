By implementing and using the Automatic Workload Repository (AWR) within your database, Oracle will store interval-based historical statistics in your database for future reference.

By default, the AWR should be enabled within your database. The key initialization parameter to validate is the STATISTICS_LEVEL parameter:
SQL> show parameter statistics_level

alter system set statistics_level=TYPICAL scope=both;

SELECT statistics_name, activation_level, system_status
FROM v$statistics_level
order by statistics_name;

The type of information that is stored in the AWR includes the following:
• Statistics regarding object access and usage
• Time model statistics
• System statistics
• Session statistics
• SQL statements
• Active Session History (ASH) information
The information gathered is then grouped and formatted by category. Some of the categories found on the report include the following:
• Load profile
• Instance efficiency
• Top 10 foreground events
• Memory, CPU, and I/O statistics
• Wait information
• SQL statement information
• Miscellaneous operating system and database statistics
• Database file and tablespace usage information

--*To use AWR functionality, the following must apply. First, you must be licensed for the Oracle Diagnostics Pack, otherwise you need to use Statspack. Second, the CONTROL_MANAGEMENT_PACK_ACCESS parameter must be set to DIAGNOSTIC+TUNING or DIAGNOSTIC .

SELECT EXTRACT(day from retention) || ':' ||
EXTRACT(hour from retention) || ':' ||
EXTRACT (minute from retention) awr_snapshot_retention_period,
EXTRACT (day from snap_interval) *24*60+
EXTRACT (hour from snap_interval) *60+
EXTRACT (minute from snap_interval) awr_snapshot_interval
FROM dba_hist_wr_control;

exec DBMS_WORKLOAD_REPOSITORY.MODIFY_SNAPSHOT_SETTINGS(retention=>43200, interval=>30);
-- modifies the retention period to 30 days (specified by number of minutes), and the snapshot interval at which snapshots are taken to 30 minutes.

--* Generating an AWR Report Manually
sqlplus / as sysdba @awrrpt
--* Generating an AWR Report for a Single SQL Statement
@awrsqrpt.sql

--* Quickly Analyzing AWR Output