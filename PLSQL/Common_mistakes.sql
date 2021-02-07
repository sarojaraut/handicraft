select 
    validate_conversion('123a' as number) first_check
    ,validate_conversion('123' as number) second_check
    ,cast('123' as number) third_check -- throws exception if can't be casted
    ,cast('123x' as number default -1 on conversion error) fourth_check -- add default clause
from dual;

select
    sql_text
    ,buffer_gets
    ,executions
from v$sqlstats
order by buffer_gets desc;
-- Querying v$sql can be bit costly better use v$sqlstats as it uses separate memory structure

-- infinity times anything is infinity
-- using pseudo function user within trigger has a cost as it's not natively implemented in plsql
-- behind the scene that getting converted into select user from dual
-- it's the flip flopping of sql and plsql engine that can be very cpu intensive
-- as an alternative get it from context sys_context('userenv','session_user')
-- you can do a sql trace and do resonable performance testing and see the tkprof
-- better always do a trace and find out that hidden cost
-- v$sqlstats you can see the converted sqls (from plsql) in uppercase

-- DIY integrity = No integrity
-- if you are trying to implement parent child using trigger think about conssistent model
-- in between you ceheck , insert and commit another user has deleted the parent
-- DI seeme trivial but it's complex, requires specialised locking within the kernel 

-- Data copy based on timestamp field and last run date
-- some records may slip through this pattern specially edge cases inserted after the process starts
-- and commited after process ends
-- because we update the control table with hwm and those records will miss the boat because sliding window
-- be congnigent of oracle consistent model and if system being used actively be carefull about this
-- make sure don't introduce DI unintentionally 

-- cardinality is sverything
-- imagine a shopping cart checkout of physical store
-- look for all checkout lines with fewer customers in the queue
-- but what if you choose a queue with one person but bagfull of items taking more time than other queue with fewer people
-- Optimiser behaves similar way .. it estimates the best case but if reality does not match the estimates then drama happens
-- I thought I'll go fastes choosing that lane but I was wrong
