-- *Detecting Disk Space Issues : df –h
Above command would list al mount poitns and their percentage disk usage.
Command to know the largest file under a mount point : find . -ls | sort -nrk7 | head -10
Largest space consumign directories : du -S . | sort -nr | head -10

--* Identifying System Bottlenecks
-- Use vmstat to determine where the system is resource-constrained. The vmstat (virtual memory statistics) tool helps quickly identify bottlenecks on your server

$ vmstat 5 
-- generates a report every 5 seconds, ctrl+x to come out of it. also you can run like vmstat 5 10 to generate 10 reports every 5 seconds
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 1  0  18352 1292672 186960 3708032    0    1    86    74  816 1075 24  7 68  1  0
 0  0  18352 1316840 186976 3695796    0    0     1    36  980 1294 16  0 83  0  0
 0  0  18352 1317348 186984 3695676    0    0     1    19  827 1286  1  0 98  1  0
 0  0  18352 1316604 186992 3695660    0    0     0    22  792 1192  1  1 98  0  0
 0  0  18352 1319084 187000 3693520    0    0     0    16  805 1258  1  0 98  1  0
 0  0  18352 1319084 187008 3693528    0    0     0     9  796 1238  1  0 98  0  0

If b (processes sleeping) is consistently greater than 0, then you may be using more CPU thanavailable.
If so (memory swapped out to disk) and si (memory swapped in from disk) are consistently greater than 0, you may have a memory bottleneck. Paging and swapping occur when there isn’t enough physical memory to accommodate the memory needs of the processes on the server.
If the wa (time waiting for I/O) column is high, this is usually an indication that the storage subsystem is overloaded.

--* Determining Top System-Resource-Consuming Processes
$ top

top - 19:19:18 up  6:50,  1 user,  load average: 1.33, 1.52, 1.43
Tasks: 296 total,   1 running, 295 sleeping,   0 stopped,   0 zombie
%Cpu(s):  1.0 us,  0.5 sy,  0.0 ni, 98.2 id,  0.3 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :   7857.8 total,   1042.8 free,   2780.3 used,   4034.8 buff/cache
MiB Swap:   2930.0 total,   2912.1 free,     17.9 used.   2875.2 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND                          
 2904 ranjan    20   0  545496 130944  96800 S   1.3   1.6  14:13.40 Xorg  
  778 systemd+  20   0   54776   8268   6972 S   0.7   0.1   0:05.32 systemd-resolve                  
 1142 root      20   0  239052   6000   5128 D   0.7   0.1   3:14.51 iio-sensor-prox                  
 1765 ranjan    20   0 1765720 279864  90128 S   0.7   3.5   1:42.47 code  
 7141 ranjan    20   0   35088   3820   3104 R   0.7   0.0   0:00.03 top   
18943 ranjan    20   0 4501716 644700  29168 S   0.7   8.0   4:37.99 java  
  393 root     -51   0       0      0      0 S   0.3   0.0   0:24.50 irq/130-iwlwifi                  
 1703 ranjan    20   0 1491380 144512  91744 S   0.3   1.8   0:38.20 code  
 1854 ranjan    20   0 1031044  64648  39364 S   0.3   0.8   0:05.62 code  
 2572 ranjan    20   0  563776  38016  27036 S   0.3   0.5   0:05.22 gnome-terminal-                  
 3644 ranjan    20   0 3388644 239532  76724 S   0.3   3.0  13:50.27 gnome-shell                      
 6366 root      20   0       0      0      0 I   0.3   0.0   0:00.22 kworker/1:2-mm_percpu_wq         
 6650 root      20   0       0      0      0 I   0.3   0.0   0:00.06 kworker/0:0-mm_percpu_wq         
 6865 54321     20   0 2042284  95624  91972 S   0.3   1.2   0:00.43 ora_m000_xe                      
13566 ranjan    20   0  924148 159680  55400 S   0.3   2.0   2:04.30 evince
16794 54321     20   0 2164352  82808  76556 S   0.3   1.0   0:09.49 ora_scmn_xe                      
16805 54321     20   0 2059920 121660 115924 S   0.3   1.5   0:29.95 ora_dbrm_xe                      
16807 54321     20   0 2042544  66100  62328 S   0.3   0.8   1:13.06 ora_vkrm_xe                      
16813 54321     20   0 2045744  78544  71660 S   0.3   1.0   0:14.46 ora_dia0_xe                      
16893 54321     20   0 2068280 251848 237880 S   0.3   3.1   1:20.15 ora_cjq0_xe                      
17235 root      20   0 4076324 382156  17016 S   0.3   4.7   1:01.09 java  
30663 54321     20   0 2047200 134492 128260 S   0.3   1.7   0:09.29 ora_m001_xe 

--* Identifying Processes Consuming CPU and Memory
The ps (process status) command is handy for quickly identifying top resource-consuming processes. For example, this command displays the top 10 CPU-consuming resources on the box:
$ ps -e -o pcpu,pid,user,tty,args | sort -n -k 1 -r | head

SELECT
    'USERNAME       : '||s.username  || CHR(10) ||
    'SCHEMA         : '||s.schemaname|| CHR(10) ||
    'OSUSER         : '||s.osuser    || CHR(10) ||
    'MODUEL         : '||s.program   || CHR(10) ||
    'ACTION         : '||s.schemaname|| CHR(10) ||
    'CLIENT_INFO    : '||s.osuser    || CHR(10) ||
    'PROGRAM        : '||s.program   || CHR(10) ||
    'SPID           : '||p.spid      || CHR(10) ||
    'SID            : '||s.sid       || CHR(10) ||
    'SERIAL#        : '||s.serial#   || CHR(10) ||
    'KILL STRING    : '||'''' || s.sid || ',' || s.serial# || ''''
    'MACHINE        : '||s.machine   || CHR(10) ||
    'TYPE           : '||s.type      || CHR(10) ||
    'TERMINAL       : '||s.terminal  || CHR(10) ||
    'SQL ID         : '||q.sql_id    || CHR(10) ||
    'CHILD_NUM      : '||q.child_number || CHR(10) ||
    'SQL TEXT       : '||q.sql_text     || CHR(10) ||
FROM 
    v$session  s
    ,v$process  p
    ,v$sql  q
WHERE s.paddr = p.addr
AND p.spid = '&PID_FROM_OS'
AND s.sql_id = q.sql_id(+)
AND s.status = 'ACTIVE';

We can view the execution plan of the running statement

SELECT * FROM table(DBMS_XPLAN.DISPLAY_CURSOR('&sql_id',&child_num));

alter system kill session '1177,38583';

kill -9 6254






































