DATE

SYSDATE
CURRENT_DATE - Sysdate in session time zone
ADD_MONTHS(date, months)
LAST_DAY(date) - Last day of the month in the specified date
MONTHS_BETWEEN(date, date) - If both dates are on the same day of the month, or both the last day of the month the returned value is an integer, otherwise the return value includes a fraction of the month difference.
NEXT_DAY(date, day) - Returns the date of the first day that matches the specified day that occurs after the specified date.
NEW_TIME(date, timezone1, timezone2) - Converts a date from timezone1 into the appropriate date for timeszone2.
TO_CHAR(date, format) - Converts a specified date to a string using the specified format mask.
TO_DATE(date_string, format)  - Converts a specified string to a date using the specified format mask.
ROUND(date, format) - Returns a date rounded to the level specified by the format.
TRUNC(date, format) - Returns a date truncated to the level specified by the format.

Rounding or Truncating Unit
To the first year of the century - CC, SCC 
To the year. Rounds up on January 1st - SYYYY, YYYY, YEAR, SYEAR ,YYY ,YY ,Y
To the quarter, rounding up on the 16th day of the second month - Q
To the same day of the week as the first day of the year. - WW, if first day of the year is Friday then dates will be rounded and truncated to the first day of that year.
To the same day of the week as the first day of the month. - W
To the day. - DDD, DD, J
To the starting day of the week - DAY, DY, D
To the hour. - HH, HH24, HH12
To the minute. - MI

INTERVAL

Intervals provide a way of storing a specific period of time that separates two datetime values. There are currently two supported types of interval, one specifying intervals in years and months, the other specifying intervals in days, hours, minutes and seconds. The syntax of these datatypes is shown below.
INTERVAL YEAR [(year_precision)] TO MONTH
INTERVAL DAY [(day_precision)] TO SECOND [(fractional_seconds_precision)]

The precision elements are defined as follows.
•year_precision – The maximum number of digits in the year component of the interval, such that a precision of 3 limits the interval to a maximum of 999 years. The default value is 2.
•day_precision – The maximum number of digits in the day component of the interval, such that a precision of 4 limits the interval to a maximum of 9999 days. The day precision can accept a value from 0 to 9, with the default value being 2.
•fraction_second_precision – The number of digits in the fractional component of the interval. Values between 0 and 9 are allowed, with the default value being 6.

select sysdate + INTERVAL '2-2' YEAR TO MONTH from dual

INTERVAL '21-2' YEAR TO MONTH - An interval of 21 years and 2 months. 
INTERVAL '100-5' YEAR(3) TO MONTH - An interval of 100 years and 5 months. The leading precision is specified, as it is greater than the default of 2. 
INTERVAL '1' YEAR - An interval of 1 year. 
INTERVAL '20' MONTH - An interval of 20 months. 
INTERVAL '100' YEAR(3) - An interval of 100 years. The precision must be specified as this value is beyond the default precision. 
INTERVAL '10000' MONTH(5) - An interval of 10,000 months. The precision must be specified as this value is beyond the default precision. 
INTERVAL '1-13' YEAR TO MONTH - Error produced. When the leading field is YEAR the allowable values for MONTH are 0 to 11. 

INTERVAL '2 3:04:11.333' DAY TO SECOND(3) - 2 days, 3 hours, 4 minutes, 11 seconds and 333 thousandths of a second. 
INTERVAL '2 3:04' DAY TO MINUTE - 2 days, 3 hours, 4 minutes. 
INTERVAL '2 3' DAY TO HOUR - 2 days, 3 hours. 
INTERVAL '2' DAY - 2 days. 
INTERVAL '03:04:11.333' HOUR TO SECOND 3 hours, 4 minutes, 11 seconds and 333 thousandths of a second. 
INTERVAL '03:04' HOUR TO MINUTE - 3 hours, 4 minutes. 
INTERVAL '40' HOUR - 40 hours. 
INTERVAL '04:11.333' MINUTE TO SECOND - 4 minutes, 11 seconds and 333 thousandths of a second. 
INTERVAL '70' MINUTE - 70 minutes. 
INTERVAL '70' SECOND - 70 seconds. 

SELECT SYSDATE + INTERVAL '2-2' YEAR TO MONTH FROM DUAL
SELECT INTERVAL '1' YEAR - INTERVAL '1' MONTH FROM dual
SELECT INTERVAL '2 3:04:11.333' DAY TO SECOND FROM DUAL
SELECT SYSDATE + INTERVAL '3:04:11.333' HOUR TO SECOND FROM DUAL

Oracle provides several interval specific functions, which are listed in the table below.

NUMTOYMINTERVAL(integer, unit) : Converts the specified integer to a YEAR TO MONTH interval where the integer represents the number of units.
 SELECT NUMTOYMINTERVAL(2, 'MONTH')  FROM   dual;
NUMTODSINTERVAL(integer, unit) : Converts the specified integer to DAY TO SECOND interval where the integer represents the number of units.
SELECT NUMTODSINTERVAL(2, 'HOUR') FROM   dual;
TO_YMINTERVAL(interval_string) - Converts a string representing an interval into a YEAR TO MONTH interval 
SELECT TO_YMINTERVAL('3-10') FROM   dual;
TO_DSINTERVAL(interval_string) : Converts a string representing an interval into a DAY TO SECOND interval.
SELECT TO_DSINTERVAL('2 10:3:45.123') FROM   dual;
EXTRACT(datepart FROM interval) : Extracts the specified datepart from the specified interval.
SELECT EXTRACT(HOUR FROM NUMTODSINTERVAL(2, 'HOUR')) FROM   dual;

SELECT EXTRACT(YEAR FROM sysdate) FROM   dual;
SELECT EXTRACT(YEAR FROM systimestamp) FROM   dual;
SELECT EXTRACT(HOUR FROM sysdate) FROM   dual; -- Invalid extract field for extract source
SELECT EXTRACT(HOUR FROM systimestamp) FROM   dual; -- Invalid extract field for extract source

select * from NLS_SESSION_PARAMETERS where parameter='NLS_TIMESTAMP_TZ_FORMAT';

select 
    systimestamp, 
    systimestamp at time zone 'UTC' utc, 
    systimestamp at time zone '+01:00' bst, 
    current_timestamp, 
    localtimestamp, 
    sessiontimezone, 
    dbtimezone 
from dual;
-- Output format depends on NLS_TIMESTAMP_TZ_FORMAT
-- systimestamp: The return type is TIMESTAMP WITH TIME ZONE.
-- current_timestamp: current date and time in the session time zone, in timestamp with time zone format
-- localtimestamp: returns a TIMESTAMP value in session timezone
-- sessiontimezone: ckient session timezone
-- dbtimezone: database timezone as specified during create database

-- TZR is timezone region , TZD is timezone daylight saving
select 
    to_char(systimestamp, 'yyyy-mm-dd hh24:mi:ss TZR TZD') sys_ts, 
    to_char(systimestamp at time zone 'Asia/Kolkata', 'yyyy-mm-dd hh24:mi:ss TZR:TZD')  tzd_kol,
    to_char(current_timestamp, 'yyyy-mm-dd hh24:mi:ss TZR TZD')  current_ts,
    to_char(TO_TIMESTAMP_TZ('2022-11-25 11:00:00 -04:00','YYYY-MM-DD HH24:MI:SS TZH:TZM'),'yyyy-mm-dd hh24:mi:ss TZR TZD')  tzh_tzm,
    to_char(TO_TIMESTAMP_TZ('2022-11-01 11:00:00 US/Pacific','YYYY-MM-DD HH24:MI:SS TZR'),'yyyy-mm-dd hh24:mi:ss TZR TZD')  tzd_pacific_pdt,
    to_char(TO_TIMESTAMP_TZ('2022-11-01 11:00:00 US/Eastern','YYYY-MM-DD HH24:MI:SS TZR'),'yyyy-mm-dd hh24:mi:ss TZR TZD')  tzd_eastern_edt,
    to_char(TO_TIMESTAMP_TZ('2022-11-01 11:00:00 US/Pacific','YYYY-MM-DD HH24:MI:SS TZR'),'yyyy-mm-dd hh24:mi:ss TZR TZD')  tzd_pacific_pst,
    to_char(TO_TIMESTAMP_TZ('2022-11-01 11:00:00 US/Eastern','YYYY-MM-DD HH24:MI:SS TZR'),'yyyy-mm-dd hh24:mi:ss TZR TZD')  tzd_eastern_est,
    to_char(TO_TIMESTAMP_TZ('2015-11-01 11:00:00 US/Pacific','YYYY-MM-DD HH24:MI:SS TZR'),'yyyy-mm-dd hh24:mi:ss TZR TZD')  tzd_pacific_2015,
    to_char(TO_TIMESTAMP_TZ('2015-11-01 11:00:00 US/Eastern','YYYY-MM-DD HH24:MI:SS TZR'),'yyyy-mm-dd hh24:mi:ss TZR TZD')  tzd_eastern_2015, 
    to_char(TO_TIMESTAMP_TZ('2022-10-01 11:00:00 Europe/London','YYYY-MM-DD HH24:MI:SS TZR'), 'yyyy-mm-dd hh24:mi:ss TZR TZD')  tzd_lon_oct_bst,
    to_char(TO_TIMESTAMP_TZ('2022-12-01 11:00:00 Europe/London','YYYY-MM-DD HH24:MI:SS TZR'), 'yyyy-mm-dd hh24:mi:ss TZR TZD')  tzd_lon_dec_gmt,
    to_char(TO_TIMESTAMP_TZ('2022-12-01 11:00:00 America/New_York','YYYY-MM-DD HH24:MI:SS TZR'), 'yyyy-mm-dd hh24:mi:ss TZR TZD')  tzd_ny_dec,
    1 ignore_this
from dual;

Data Types
DATE : This is the classic we all know and have used for years

TIMESTAMP : Like DATE, TIMESTAMP does not include time zone information, so it also does not describe a moment in time.
TIMESTAMP(0) is essentially the same as DATE
TIMESTAMP(6) with a millionth of a second accuracy is the highest precision that most operating systems support

TIMESTAMP WITH TIME ZONE (TSTZ): Here, we have a datatype that captures a moment in time. Because TSTZ includes the date + time (optionally to the fraction of a second) + time zone, 
 it does capture a moment in time. The ability to capture a moment in time is critical when scheduling anything, and recording most actions (created_date, publish_date, etc.).
TSTZ, however, really should only be used if knowing the time zone that something occurred in is important information.
In most cases, if we normalize all of our TIMESTAMPs to UTC (or any arbitrary time zone), that is sufficient. 


TIMESTAMP WITH LOCAL TIME ZONE (TSLTZ): Finally, the datatype we have all been waiting for! TSLTZ automatically normalizes the TIMESTAMP to the time zone of the database when it stores the data, 
 and converts it back to the session time zone when it is selected out of the database.

declare

l_tsltz timestamp with local time zone := systimestamp;
begin
  dbms_output.put_line('Database:        ' || to_char(l_tsltz,'YYYY-MM-DD HH24-MI-SS TZR TZD'));

  execute immediate 'alter session set time_zone=''US/Eastern''';
  dbms_output.put_line('US/Eastern:      ' || to_char(l_tsltz,'YYYY-MM-DD HH24-MI-SS TZR TZD'));

  execute immediate 'alter session set time_zone=''AMERICA/CHICAGO''';
  dbms_output.put_line('AMERICA/CHICAGO: ' || to_char(l_tsltz,'YYYY-MM-DD HH24-MI-SS TZR TZD'));

  execute immediate 'alter session set time_zone=''US/PACIFIC''';
  dbms_output.put_line('US/PACIFIC:      ' || to_char(l_tsltz,'YYYY-MM-DD HH24-MI-SS TZR TZD'));
end;
/

Database:        2022-10-27 10-19-37 AMERICA/NEW_YORK EDT
US/Eastern:      2022-10-27 10-19-37 US/EASTERN EDT
AMERICA/CHICAGO: 2022-10-27 09-19-37 AMERICA/CHICAGO CDT
US/PACIFIC:      2022-10-27 07-19-37 US/PACIFIC PDT

The TIMESTAMP WITH LOCAL TIME ZONE datatype normalizes to the database time zone. Hence there is no need to store a time zone with the data–it is, by definition, the database time zone.

Oracle recommends that the database time zone be set to UTC (and never changed). In practice, it does not matter what the database time zone is, so long as it never changes. TIMESTAMP WITH LOCAL TIME ZONE  data will always normalize on the way into the field and convert to the session time zone on the way out.

