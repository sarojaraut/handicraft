CREATE MATERIALIZED VIEW MVW_LOGGER_DATA
TABLESPACE STD_DATA
BUILD IMMEDIATE
REFRESH START WITH SYSDATE NEXT  (SYSDATE+5/(24*60))
WITH PRIMARY KEY
AS
WITH metric AS 
	(
		SELECT 'Last Hour' name, 2 mid FROM DUAL
		UNION
		SELECT 'Today' name, 4 mid FROM DUAL
		UNION
		SELECT 'This Week' name, 8 mid FROM DUAL
	 ),
 log_data AS (  
	SELECT 
		CASE
			WHEN time_stamp >= SYSTIMESTAMP - INTERVAL '1' HOUR 
			THEN 2
			WHEN time_stamp >= TRUNC (SYSTIMESTAMP) 
			THEN 4
			ELSE 8
		END metric_id,
		SUM (DECODE (logger_level, 2, 1, 0)) error_count,
		SUM (DECODE (logger_level, 4, 1, 0)) warning_count
	FROM 
		logger_logs
	WHERE 
		logger_level IN (2, 4)
		AND time_stamp >= TRUNC (SYSTIMESTAMP, 'ww')
	GROUP BY 
	logger_level,
	CASE
		WHEN time_stamp >= SYSTIMESTAMP - INTERVAL '1' HOUR
		THEN 2
		WHEN time_stamp >= TRUNC (SYSTIMESTAMP)
		THEN 4
		ELSE 8
	END
	)
SELECT name,
	 mid                  metric_id,
	 SUM (error_count)    error_count,
	 SUM (warning_count)  warning_count
FROM 
	metric 
	LEFT JOIN log_data ld 
		ON (metric.mid = ld.metric_id)
GROUP BY mid, name
/

COMMENT ON MATERIALIZED VIEW MVW_LOGGER_DATA IS
'  NAME           : MVW_LOGGER_DATA
  ALIAS          : MVW_LOGGER_DATA
  DESCRIPTION    : This materialised view holds the summary data from   
                 : logger_logs table and used by diagnostic apex app.
  SOURCE APP     : N/A
  SOURCE TABLE   : LOGGER_LOGS
  SOURCE FILE    : N/A
  LOADER FILE    : N/A
  --
  --$Revision:   1.1  $ 
  VER|     DATE  | AUTHOR       | REASON
  -----------------------------------------------------------------------------
  1.0| 14/09/2017| S. Raut      | Initial Revision   
'
/ 
COMMENT ON COLUMN mvw_logger_data.metric_id IS
'Metric ID can be 2, 4, 8.  Where 2=Last Hour, 4=Today and 8=This Week'
/
COMMENT ON COLUMN mvw_logger_data.error_count IS
'Number of error messages logged during the period period crresponding to the metric ID'
/
COMMENT ON COLUMN mvw_logger_data.warning_count IS
'Number of warning messages logged during the period crresponding to the metric ID'
/
