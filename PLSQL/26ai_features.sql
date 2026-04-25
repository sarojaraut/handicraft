
-- 26ai Date functions
select 
    sysdate                    today --25-APR-26
    ,calendar_year(sysdate)    calendar_year-- 2026
    ,calendar_quarter(sysdate) calendar_quarter-- Q2-2026
    ,calendar_month(sysdate)   calendar_month-- APR-2026
    ,calendar_week(sysdate)    calendar_week-- W17-2026
    ,calendar_day(sysdate)     calendar_day-- 25-APR-2026
    --
    ,calendar_year_number(sysdate)        as calendar_year_number       -- 2026
    --
    ,calendar_quarter_of_year(sysdate)    as calendar_quarter_of_year   -- 2
    ,calendar_month_of_year(sysdate)      as calendar_month_of_year     -- 4
    ,calendar_month_of_quarter(sysdate)   as calendar_month_of_quarter  -- 1
    ,calendar_week_of_year(sysdate)       as calendar_week_of_year      -- 17
    ,calendar_day_of_year(sysdate)        as calendar_day_of_year       -- 115
    ,calendar_day_of_quarter(sysdate)     as calendar_day_of_quarter    -- 25
    ,calendar_day_of_month(sysdate)       as calendar_day_of_month      -- 25
    ,calendar_day_of_week(sysdate)        as calendar_day_of_week       -- 6
    
    ,calendar_year_start_date(sysdate)     as calendar_year_start_date       -- 01-JAN-26
    ,calendar_quarter_start_date(sysdate)  as calendar_quarter_start_date    -- 01-APR-26
    ,calendar_month_start_date(sysdate)    as calendar_month_start_date      -- 01-APR-26
    ,calendar_week_start_date(sysdate)     as calendar_week_start_date       -- 23-APR-26
    --
    ,calendar_year_end_date(sysdate)       as calendar_year_end_date         -- 31-DEC-26
    ,calendar_quarter_end_date(sysdate)    as calendar_quarter_end_date      -- 30-JUN-26
    ,calendar_month_end_date(sysdate)      as calendar_month_end_date        -- 30-APR-26
    ,calendar_week_end_date(sysdate)       as calendar_week_end_date         -- 29-APR-26
from dual;

-- https://docs.oracle.com/en/database/oracle/oracle-database/26/sqlrf/calendar_start_end.html

