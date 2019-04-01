Do You Have a Wait Problem?

select metric_name, value
from v$sysmetric
where metric_name in (
    'Database CPU Time Ratio',
    'Database Wait Time Ratio') 
and intsize_csec = (select max(INTSIZE_CSEC) from V$SYSMETRIC);

some the most common wait events are the following:
• Buffer busy waits: These occur when multiple processes attempt to concurrently access the same buffers in the buffer cache.
• Free buffer waits: These waits occur when a server process posts the database writer process to write out dirty buffers in order to make free buffers available.
• Db file scattered read: These are waits incurred by an user process for a physical I/O to return when reading buffers into the SGA buffer cache. The scattered reads are multiblock reads and can occur because of a full table scan or a fast full scan of an index.
• Db file sequential read: These are waits incurred by an user process for a physical I/O to return when reading buffers into the SGA buffer cache. The reads are single block reads and are usually because of indexed reads.
• Enqueue waits: These are waits on Oracle locking mechanisms that control access to internal database resources and that occur when a session waits on a lock held by another session. You actually won’t see a wait event named enqueue (or enq) because the enqueue wait event types are always held for a specific purpose, such as enq: TX – contention, enq:TX – index contention, and enq:TX – row lock contention.
• Log buffer space: These are waits caused by server processes waiting for free space in the log buffer.
• Log file sync: These are waits by server processes that are performing a commit (or rollback) for the LGWR to complete its write to the redo log file.

The STATE column in V$SESSION_WAIT captures the wait state, which could be one of the following:
• WAITING: Session is currently waiting
• WAITED UNKNOWN TIME: Duration of the last wait is unknown (value when you set the parameter TIMED_STATISTICS to false)
• WAITED SHORT TIME: Last wait was less than 100th of a second
• WAITED KNOWN TIME: Duration of the last wait is specified in the WAIT_TIME column

Finding Out Who’s Holding a Blocking Lock

select 
s1.username || '@' || s1.machine
|| ' ( SID=' || s1.sid || ' ) is blocking '
|| s2.username || '@' || s2.machine || ' ( SID=' || s2.sid || ' ) ' AS blocking_status
from v$lock l1, 
    v$session s1, 
    v$lock l2, 
    v$session s2
where s1.sid=l1.sid and s2.sid=l2.sid
and l1.BLOCK > 0 and l2.request > 0
and l1.id1 = l2.id1
and l2.id2 = l2.id2 ;

select sid,type,lmode,request,ctime,block, id1 from v$lock; 
-- LMODE=6 and TYPE=TX is row exclusive, TM=Object lavel lock, id1 is the object id of the locked object
-- Each time a transaction modifies data, it invokes a TX lock, which is a row transaction lock. The DML lock, TM, on the other hand, is acquired once for each object that’s being changed by a DML statement. The LMODE column shows the lock mode, with a value of 6 indicating

If you want to find out the wait class and for how long a blocking session has been blocking others, you can do so by querying the V$SESSION view, as shown here:
select blocking_session, sid, wait_class,seconds_in_wait
from v$session
where blocking_session is not NULL
order by blocking_session;
-- The waits on the enq: TM – contention event for the sessions that are waiting to perform insert operations are almost always because of an unindexed foreign key constraint.

--* Analyzing Recent Wait Events in a Database
-- Query the V$ACTIVE_SESSION_HISTORY view to get information about the most common wait events and the SQL statements, database objects, and users responsible for those waits.

select event,
sum(wait_time +
time_waited) total_wait_time
from v$active_session_history
where sample_time between
sysdate –15/1440 and sysdate
group by event
order by total_wait_time desc
