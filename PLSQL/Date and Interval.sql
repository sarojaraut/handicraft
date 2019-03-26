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


