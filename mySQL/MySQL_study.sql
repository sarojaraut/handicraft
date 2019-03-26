-- ! alert
-- ? question / queries
-- * high lighted
-- TODO 
InooDB Locking

A shared (S) lock permits the transaction that holds the lock to read a row.
An exclusive (X) lock permits the transaction that holds the lock to update or delete a row.

If a transaction T1 holds an exclusive (X) lock on row r, a request from some distinct transaction T2 for a lock of either type on r cannot be granted immediately. Instead, transaction T2 has to wait for transaction T1 to release its lock on row r.

Intention locks are table-level locks that indicate which type of lock (shared or exclusive) a transaction requires later for a row in a table. There are two types of intention locks:

An intention shared lock (IS) indicates that a transaction intends to set a shared lock on individual rows in a table.

An intention exclusive lock (IX) indicates that that a transaction intends to set an exclusive lock on individual rows in a table.

For example, SELECT ... LOCK IN SHARE MODE sets an IS lock, and SELECT ... FOR UPDATE sets an IX lock.

The intention locking protocol is as follows:

Before a transaction can acquire a shared lock on a row in a table, it must first acquire an IS lock or stronger on the table.

Before a transaction can acquire an exclusive lock on a row in a table, it must first acquire an IX lock on the table.


LOCK TABLES ... WRITE -- Table level exclusive lock
SELECT ... LOCK IN SHARE MODE  -- Table level shared lock
SELECT ... FOR UPDATE -- Table level exclusive lock 

SHOW ENGINE INNODB STATUS
/*
InnoDB, , 
=====================================
2019-02-17 14:23:56 0x2b4763753700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 51 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 1616252 srv_active, 0 srv_shutdown, 1579531 srv_idle
srv_master_thread log flush and writes: 0
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 106475
OS WAIT ARRAY INFO: signal count 105235
RW-shared spins 0, rounds 86847, OS waits 42787
RW-excl spins 0, rounds 10820, OS waits 659
RW-sx spins 226, rounds 6726, OS waits 181
Spin rounds per wait: 86847.00 RW-shared, 10820.00 RW-excl, 29.76 RW-sx
------------------------
LATEST DETECTED DEADLOCK
------------------------
2019-01-14 12:10:41 0x2b47af487700
*** (1) TRANSACTION:
TRANSACTION 145743634, ACTIVE 1 sec inserting
mysql tables in use 1, locked 1
LOCK WAIT 12 lock struct(s), heap size 1136, 5 row lock(s), undo log entries 7
MySQL thread id 13034, OS thread handle 47585611298560, query id 1893684 10.200.88.192 orderhistory update
INSERT INTO order_consignment (`shipment_id`, `code`, `carrier_service_type`) VALUES ('13e4696e-b2af-4c76-983b-f755dc85e196','DMC07V1H6VJ5','GENERIC') ON DUPLICATE KEY UPDATE shipment_id = values(shipment_id)
*** (1) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 298 page no 36 n bits 0 index unique_code of table `entry_order_history`.`order_consignment` trx id 145743634 lock_mode X locks gap before rec insert intention waiting
Record lock, heap no 163 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
 0: len=12; bufptr=0x2b477c446256; hex= 444d433037564336354c4249; asc DMC07VC65LBI;;
 1: len=30; bufptr=0x2b477c446262; hex= 61383464396639382d633033312d343166332d383336322d623036393861; asc a84d9f98-c031-41f3-8362-b0698a; (total 36 bytes);

*** (2) TRANSACTION:
TRANSACTION 145743633, ACTIVE 1 sec inserting
mysql tables in use 1, locked 1
LOCK WAIT 13 lock struct(s), heap size 1136, 7 row lock(s), undo log entries 9
MySQL thread id 13035, OS thread handle 47585610233600, query id 1893678 10.200.89.12 orderhistory update
INSERT INTO order_consignment (`shipment_id`, `code`, `carrier_service_type`) VALUES ('e5aa0b4c-899a-4dde-8185-0a7ba4e18a41','DMC07V1H6VGY','GENERIC') ON DUPLICATE KEY UPDATE shipment_id = values(shipment_id)
*** (2) HOLDS THE LOCK(S):
RECORD LOCKS space id 298 page no 36 n bits 0 index unique_code of table `entry_order_history`.`order_consignment` trx id 145743633 lock_mode X locks gap before rec
Record lock, heap no 163 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
 0: len=12; bufptr=0x2b477c446256; hex= 444d433037564336354c4249; asc DMC07VC65LBI;;
 1: len=30; bufptr=0x2b477c446262; hex= 61383464396639382d633033312d343166332d383336322d623036393861; asc a84d9f98-c031-41f3-8362-b0698a; (total 36 bytes);

*** (2) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 298 page no 36 n bits 0 index unique_code of table `entry_order_history`.`order_consignment` trx id 145743633 lock_mode X locks gap before rec insert intention waiting
Record lock, heap no 163 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
 0: len=12; bufptr=0x2b477c446256; hex= 444d433037564336354c4249; asc DMC07VC65LBI;;
 1: len=30; bufptr=0x2b477c446262; hex= 61383464396639382d633033312d343166332d383336322d623036393861; asc a84d9f98-c031-41f3-8362-b0698a; (total 36 bytes);

------------
TRANSACTIONS
------------
Trx id counter 148902820
Purge done for trx's n:o < 148902820 undo n:o < 0 state: running but idle
History list length 2912
--------
FILE I/O
--------
I/O thread 0 state: waiting for i/o request (insert buffer thread)
I/O thread 1 state: waiting for i/o request (log thread)
I/O thread 2 state: waiting for i/o request (read thread)
I/O thread 3 state: waiting for i/o request (read thread)
I/O thread 4 state: waiting for i/o request (read thread)
I/O thread 5 state: waiting for i/o request (read thread)
I/O thread 6 state: waiting for i/o request (write thread)
I/O thread 7 state: waiting for i/o request (write thread)
I/O thread 8 state: waiting for i/o request (write thread)
I/O thread 9 state: waiting for i/o request (write thread)
Pending normal aio reads: [0, 0, 0, 0] , aio writes: [0, 0, 0, 0] ,
 ibuf aio reads:, log i/o's:, sync i/o's:
Pending flushes (fsync) log: 0; buffer pool: 0
59 OS file reads, 87 OS file writes, 28 OS fsyncs
0.00 reads/s, 0 avg bytes/read, 0.00 writes/s, 0.00 fsyncs/s
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 0, seg size 2, 28 merges
merged operations:
 insert 0, delete mark 0, delete 0
discarded operations:
 insert 0, delete mark 0, delete 0
Hash table size 181421, node heap has 0 buffer(s)
Hash table size 181421, node heap has 0 buffer(s)
Hash table size 181421, node heap has 0 buffer(s)
Hash table size 181421, node heap has 0 buffer(s)
Hash table size 181421, node heap has 0 buffer(s)
Hash table size 181421, node heap has 0 buffer(s)
Hash table size 181421, node heap has 0 buffer(s)
Hash table size 181421, node heap has 0 buffer(s)
0.00 hash searches/s, 1.02 non-hash searches/s
---
LOG
---
Log sequence number 8204
Log flushed up to   0
Pages flushed up to 8204
Last checkpoint at  8192
0 pending log flushes, 0 pending chkp writes
0 log i/o's done, 0.00 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 0
Dictionary memory allocated 2386270
Buffer pool size   44771
Free buffers       1024
Database pages     43747
Old database pages 16128
Modified db pages  0
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 1207948, not young 1410168
0.00 youngs/s, 0.00 non-youngs/s
Pages read 293450, created 37267, written 37786
0.00 reads/s, 0.00 creates/s, 0.00 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 43747, unzip_LRU len: 0
I/O sum[0]:cur[0], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
0 read views open inside InnoDB
Process ID=15830, Main thread ID=47586877130496, state: sleeping
Number of rows inserted 1697719, updated 1681050, deleted 964, read 32517463
0.00 inserts/s, 0.51 updates/s, 0.00 deletes/s, 0.51 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================

*/


Gap Locks
A gap lock is a lock on a gap between index records, or a lock on the gap before the first or after the last index record. 
Gap locking is not needed for statements that lock rows using a unique index to search for a unique row. (This does not include the case that the search condition includes only some columns of a multiple-column unique index; in that case, gap locking does occur.) 

SELECT * FROM child WHERE id = 100;

If id is not indexed or has a nonunique index, the statement does lock the preceding gap.

Gap locks in InnoDB are “purely inhibitive”, which means that their only purpose is to prevent other transactions from inserting to the gap. Gap locks can co-exist. A gap lock taken by one transaction does not prevent another transaction from taking a gap lock on the same gap. There is no difference between shared and exclusive gap locks. They do not conflict with each other, and they perform the same function.

Next-Key Locks

A next-key lock is a combination of a record lock on the index record and a gap lock on the gap before the index record.

InnoDB performs row-level locking in such a way that when it searches or scans a table index, it sets shared or exclusive locks on the index records it encounters. Thus, the row-level locks are actually index-record locks. A next-key lock on an index record also affects the “gap” before that index record. That is, a next-key lock is an index-record lock plus a gap lock on the gap preceding the index record. If one session has a shared or exclusive lock on record R in an index, another session cannot insert a new index record in the gap immediately before R in the index order.



Insert Intention Locks
An insert intention lock is a type of gap lock set by INSERT operations prior to row insertion. This lock signals the intent to insert in such a way that multiple transactions inserting into the same index gap need not wait for each other if they are not inserting at the same position within the gap. Suppose that there are index records with values of 4 and 7. Separate transactions that attempt to insert values of 5 and 6, respectively, each lock the gap between 4 and 7 with insert intention locks prior to obtaining the exclusive lock on the inserted row, but do not block each other because the rows are nonconflicting.

Client A creates a table containing two index records (90 and 102) and then starts a transaction that places an exclusive lock on index records with an ID greater than 100. The exclusive lock includes a gap lock before record 102:

mysql> CREATE TABLE child (id int(11) NOT NULL, PRIMARY KEY(id)) ENGINE=InnoDB;
mysql> INSERT INTO child (id) values (90),(102);

mysql> START TRANSACTION;
mysql> SELECT * FROM child WHERE id > 100 FOR UPDATE;
+-----+
| id  |
+-----+
| 102 |
+-----+
Client B begins a transaction to insert a record into the gap. The transaction takes an insert intention lock while it waits to obtain an exclusive lock.

mysql> START TRANSACTION;
mysql> INSERT INTO child (id) VALUES (101);
Transaction data for an insert intention lock appears similar to the following in SHOW ENGINE INNODB STATUS and InnoDB monitor output:

RECORD LOCKS space id 31 page no 3 n bits 72 index `PRIMARY` of table `test`.`child`
trx id 8731 lock_mode X locks gap before rec insert intention waiting
Record lock, heap no 3 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80000066; asc    f;;
 1: len 6; hex 000000002215; asc      ;;
 2: len 7; hex 9000000172011c; asc     r  ;;...

AUTO-INC Locks
An AUTO-INC lock is a special table-level lock taken by transactions inserting into tables with AUTO_INCREMENT columns. In the simplest case, if one transaction is inserting values into the table, any other transactions must wait to do their own inserts into that table, so that rows inserted by the first transaction receive consecutive primary key values.

https://dev.mysql.com/doc/refman/5.7/en/innodb-locking.html#innodb-insert-intention-locks

------------
First, create the user mysql (note that the first forward slash symbol (/) stands by itself
on the line):
$ sudo niutil -create / /users/mysql
and assign invalid (and therefore relatively secure) values for the home directory and
login shell:
$ sudo niutil -createprop / /users/mysql home /var/empty
$ sudo niutil -createprop / /users/mysql shell /usr/bin/false
Next, create the group mysql:
$ sudo niutil -create / /groups/mysql

Verifying that the mysql group exists

$ sudo niutil -createprop / /groups/mysql gid 74
$ sudo niutil -createprop / /users/mysql uid 74
Finally, associate the mysql user with the mysql group:
$ sudo niutil -createprop / /users/mysql gid 74

$mysql \
--host=server_host_name \
--port=server_port \
--user=root \
--password=the_mysql_root_password

SELECT VERSION(); -- 5.7.12-log

SHOW DATABASES;

SHOW COLUMNS FROM order_consignment;

'code','varchar(50)','NO','PRI',NULL,''
'carrier_service_type','varchar(50)','NO','','',''
'shipment_id','varchar(100)','NO','PRI',NULL,''
'created','timestamp(3)','NO','','CURRENT_TIMESTAMP(3)',''
'updated','timestamp(3)','NO','','CURRENT_TIMESTAMP(3)','on update CURRENT_TIMESTAMP(3)'


INSERT INTO artist VALUES (7, "Barry Adamson");

You might be tempted to try out something like this:
mysql> INSERT INTO artist
VALUES((SELECT 1+MAX(artist_id) FROM artist), "Barry Adamson");
However, this won’t work because you can’t modify a table while you’re reading from
it.

This works in 5.7.2 : insert into t1 select * from t1;

insert into t1 values (8), (9);

SELECT * FROM t1 ORDER BY c1 DESC LIMIT 1;

TRUNCATE TABLE played;

UPDATE artist SET artist_name = UPPER(artist_name);

UPDATE played SET played = NULL ORDER BY played DESC LIMIT 10;

SHOW DATABASES LIKE "m%";

SHOW CREATE DATABASE music;

SHOW TABLES FROM music;

SHOW TABLES;
/*
'order_consignment'
'order_customer'
'order_external_id'
'order_feature_flag'
'order_header'
'order_location'
'order_metadata'
'order_parcel'
'order_payment'
'order_payment_address'
'order_payment_credit_card_instrument'
'order_payment_gift_card_instrument'
'order_payment_paypal_instrument'
'order_payment_transaction'
'order_payment_transaction_status'
'order_payment_transaction_total'
'order_previous_parcel_barcode'
'order_product_line_item'
'order_product_line_item_price_adjustment'
'order_product_line_item_status'
'order_shipment'
'order_shipment_address'
'order_shipment_price_adjustment'
'order_shipment_status'
'order_shipment_total'
'order_shipment_tracking'
'order_status'
'order_total'
'order_transaction_gift_card_refund'
'schema_migrations'

*/

mysqlshow --user=root --password=the_mysql_root_password music track

mysql> USE lucy;
Database changed

CREATE DATABASE IF NOT EXISTS lucy;

mysql> CREATE TABLE artist (
-> artist_id SMALLINT(5) NOT NULL DEFAULT 0,
-> artist_name CHAR(128) DEFAULT NULL,
-> PRIMARY KEY (artist_id)
-> );

INSERT INTO artist SET artist_name = "Duran Duran";

Column names have fewer restrictions than database and table names. What’s more,
they’re not dependent on the operating system: the names are case-insensitive and
portable across all platforms. All characters are allowed in column names, though if
you want terminate them with whitespace or include periods (or other special characters
such as the semicolon), you’ll need to enclose the name with a backtick symbol
(`) on either side.

SHOW CHARACTER SET;

SHOW COLLATION;

CREATE DATABASE rose DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_cs;

CREATE TABLE IF NOT EXISTS artist (
-> artist_id SMALLINT(5) NOT NULL DEFAULT 0,
-> artist_name CHAR(128) DEFAULT NULL,
-> PRIMARY KEY (artist_id)
-> );

Query OK, 0 rows affected (0.00 sec)

It’s actually hard to tell success from failure here: zero rows are affected whether or not
the table exists, and no warning is reported when the table does exist.

My assumption/theory to explain this scenario is : items got cancelled after despatch and before collected

50579654, 50522044, 50029870, 51093233

CREATE DATABASE d1;
USE d1;
CREATE TABLE t1 (c1 INT);
CREATE TABLE t2 (c1 INT);
CREATE FUNCTION f1(p1 INT) RETURNS INT
  BEGIN
    INSERT INTO t2 VALUES (p1);
    RETURN p1;
  END;

-- Settings View

SELECT @@TX_ISOLATION;
SELECT @@GLOBAL.tx_isolation, @@SESSION.tx_isolation;

SELECT * FROM INFORMATION_SCHEMA.INNODB_LOCKS;

SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED -- [GLOBAL | SESSION] 
-- Observation 
With default repeatable read isolation level and autocommit off. you can clearly see readers block the writers. If you fire a select query and try to reuncate the table from another session that would be blocked. 

auto commit is crucial

--Experiment
CREATE TABLE child (id int(11) NOT NULL, PRIMARY KEY(id)) ENGINE=InnoDB;

set autocommit=0;
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;-- READ COMMITTED , READ UNCOMMITTED, SERIALIZABLE
drop table order_nonidx;
truncate table order_nonidx;
CREATE TABLE order_nonidx (ordernumber INT NOT NULL, totalcost INT) ENGINE = InnoDB;
INSERT INTO order_nonidx VALUES (1,10),(2,20),(3,30),(4,40),(5,50);

Session-1
set autocommit=0;
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
update order_nonidx set totalcost=100 where ordernumber=1;

Session-2
set autocommit=0;
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
update order_nonidx set totalcost=200 where ordernumber=2;
--This session is now blocked, setting to READ COMMITTED fixes this problem also creating index on ordernumber fixes this problem. composite problem might not fix the problem.

CREATE TABLE order_idx (ordernumber INT NOT NULL, totalcost INT, index(ordernumber)) ENGINE = InnoDB;
INSERT INTO order_idx VALUES (1,10),(2,20),(3,30),(4,40),(5,50);

update order_idx set totalcost=100 where ordernumber=1;
update order_idx set totalcost=200 where ordernumber=2;

SELECT * FROM order_idx WHERE ordernumber = 1 LOCK IN SHARE MODE;
-- Two sessions can have this lock, but once one sesion have this shared lock ohter session can not have exclusive lock for update/delete 
-- Sets a shared mode lock on any rows that are read. Other sessions can read the rows, but cannot modify them until your transaction commits.

SELECT * FROM order_idx WHERE ordernumber = 1  FOR UPDATE;

--For index records the search encounters, locks the rows and any associated index entries, the same as if you issued an UPDATE statement for those rows. Other transactions are blocked from updating those rows, from doing SELECT ... LOCK IN SHARE MODE

If a FOREIGN KEY constraint is defined on a table, any insert, update, or delete that requires the constraint condition to be checked sets shared record-level locks on the records that it looks at to check the constraint. InnoDB also sets these locks in the case where the constraint fails.

Mysql-5
docker run --name mysqldb -e MYSQL_ROOT_PASSWORD=mysqlroot -p 3305:3306 -d mysql

mysql -h localhost -pmysqlroot -u root
CREATE DATABASE mydb;
CREATE USER 'mysql'@'localhost' IDENTIFIED BY 'mysql';
CREATE USER 'mysql'@'127.0.0.1' IDENTIFIED BY 'mysql';
CREATE USER 'mysql'@'172.17.0.1' IDENTIFIED BY 'mysql'; -- this is the one working
GRANT ALL PRIVILEGES ON mydb.* TO 'mysql'@'localhost';
GRANT ALL PRIVILEGES ON mydb.* TO 'mysql'@'127.0.0.1';
GRANT ALL PRIVILEGES ON mydb.* TO 'mysql'@'172.17.0.1';

GRANT SELECT, PROCESS ON *.* TO 'mysql'@'172.17.0.1';

17:19:08	show engine innodb status	Error Code: 1227. Access denied; you need (at least one of) the PROCESS privilege(s) for this operation	0.0014 sec
GRANT SELECT, PROCESS ON *.* TO 'mysql'@'172.17.0.1'; -- and refresh the connection
GRANT SELECT, PROCESS, SUPER ON *.* TO 'mysql'@'172.17.0.1'; -- and refresh the connection

mysql-8
docker run --name mysqldb8013 -e MYSQL_ROOT_PASSWORD=temppass -p 3305:3306 33060:33060 -d mysql:8.0.13

mysql -h localhost -ptemppass -u root

CREATE USER 'sampadm'@'localhost' IDENTIFIED BY 'sampadm';
GRANT ALL ON sampdb.* TO 'sampadm'@'localhost';

mysql -h localhost -psampadm -u sampadm sampdb

SELECT NOW();
SELECT NOW()\g -- antoher way of terminating statement without ;

SELECT NOW(), USER(), VERSION(), database();

output on three separate lines
SELECT NOW();SELECT USER();SELECT VERSION();

SHOW TABLES;

SHOW DATABASES;

mysql < myscript.sql

CREATE DATABASE sampdb;
USE sampdb;
SELECT DATABASE();

--without sampdb select database show null

mysql sampdb < create_president.sql

CREATE TABLE president
(
  last_name VARCHAR(15) NOT NULL,
  first_name VARCHAR(15) NOT NULL,
  suffix VARCHAR(5) NULL,
  city VARCHAR(20) NOT NULL,
  state VARCHAR(2) NOT NULL,
  birth DATE NOT NULL,
  death DATE NULL
);

The following statements all are synonymous:
DESCRIBE president;
DESC president;
EXPLAIN president;
SHOW COLUMNS FROM president;
SHOW FIELDS FROM president;

CREATE TABLE member
(
    member_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (member_id),
    last_name VARCHAR(20) NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    suffix VARCHAR(5) NULL,
    expiration DATE NULL,
    email VARCHAR(100) NULL,
    street VARCHAR(50) NULL,
    city VARCHAR(50) NULL,
    state VARCHAR(2) NULL,
    zip VARCHAR(10) NULL,
    phone VARCHAR(20) NULL,
    interests VARCHAR(255) NULL
);

CREATE TABLE student
(
name VARCHAR(20) NOT NULL,
sex ENUM('F','M') NOT NULL,
student_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
PRIMARY KEY (student_id)
) ENGINE = InnoDB;

DESCRIBE student 'sex';

If you omit the ENGINE clause, MySQL picks a default engine, which usually is MyISAM.“ISAM” stands for “indexed sequential access method,” and the MyISAM engine is based on that access method with some MySQL-specific stuff added.

CREATE TABLE grade_event
(
date DATE NOT NULL,
category ENUM('T','Q') NOT NULL,
event_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
PRIMARY KEY (event_id)
) ENGINE = InnoDB;

CREATE TABLE score
(
student_id INT UNSIGNED NOT NULL,
event_id INT UNSIGNED NOT NULL,
score INT NOT NULL,
PRIMARY KEY (event_id, student_id),
INDEX (student_id),
FOREIGN KEY (event_id) REFERENCES grade_event (event_id),
FOREIGN KEY (student_id) REFERENCES student (student_id)
) ENGINE = InnoDB;

INSERT INTO student VALUES('Kyle','M',NULL);
INSERT INTO grade_event VALUES('2008-09-03','Q',NULL);

You can quote string and date values in MySQL using either single or double quotes, but single quotes are more standard.

mysql> source insert_president.sql;
If you have the rows stored in a file as raw data values rather than as INSERT statements, you can load them with the LOAD DATA statement or with the mysqlimport client program.
mysql> LOAD DATA LOCAL INFILE 'member.txt' INTO TABLE member;

By default, the LOAD DATA statement assumes that column values are separated by tabs and that lines end with newlines (also known as “linefeeds”). The keyword LOCAL in the LOAD DATA statement causes the data file to be read by the client program (in this case mysql) and sent to the server to be loaded.

SELECT last_name, first_name FROM president WHERE death IS NULL;
SELECT last_name, first_name FROM president ORDER BY last_name;
SELECT last_name, first_name FROM president ORDER BY last_name DESC;
SELECT last_name, first_name, death FROM president ORDER BY IF(death IS NULL,0,1), death DESC;
SELECT last_name, first_name, birth FROM president ORDER BY birth LIMIT 5;
The following query is similar to the previous one but returns 5 rows after skipping the first 10:
mysql> SELECT last_name, first_name, birth FROM president ORDER BY birth DESC LIMIT 10, 5;
To pull a randomly selected row or set of rows from a table, use ORDER BY RAND() in conjunction with LIMIT:
mysql> SELECT last_name, first_name FROM president ORDER BY RAND() LIMIT 1;
mysql> SELECT CONCAT(first_name,' ',last_name),CONCAT(city,', ',state) FROM president;
mysql> SELECT CONCAT(first_name,' ',last_name) AS Name, CONCAT(city,', ',state) AS Birthplace FROM president;

The principal thing to keep in mind when using dates in MySQL is that it always expects dates with the year first.To write July 27, 2008, use '2008-07-27'.

SELECT * FROM grade_event WHERE date = '2008-10-01';
SELECT last_name, first_name, birth FROM president WHERE MONTH(birth) = 3;
SELECT last_name, first_name, birth FROM president WHERE MONTHNAME(birth) = 'March';
SELECT last_name, first_name, birth FROM president WHERE MONTH(birth) = 3 AND DAYOFMONTH(birth) = 29;
SELECT last_name, first_name, birth FROM president WHERE MONTH(birth) = MONTH(CURDATE()) AND DAYOFMONTH(birth) = DAYOFMONTH(CURDATE());

SELECT last_name, first_name, birth, death, TIMESTAMPDIFF(YEAR, birth, death) AS age FROM president WHERE death IS NOT NULL ORDER BY age DESC LIMIT 5;

The TIMESTAMPDIFF() function is useful here because it takes an argument for specifying the unit in which to express the result (YEAR in this case):

SELECT last_name, first_name, expiration FROM member WHERE (TO_DAYS(expiration) - TO_DAYS(CURDATE())) < 60;

The equivalent statement using TIMESTAMPDIFF() looks like this:

SELECT last_name, first_name, expiration FROM member WHERE TIMESTAMPDIFF(DAY, CURDATE(), expiration) < 60;

To calculate one date from another, you can use DATE_ADD() or DATE_SUB().These functions take a date and an interval and produce a new date. For example:
mysql> SELECT DATE_ADD('1970-1-1', INTERVAL 10 YEAR);
mysql> SELECT DATE_SUB('1970-1-1', INTERVAL 10 YEAR);
SELECT last_name, first_name, expiration FROM member WHERE expiration < DATE_ADD(CURDATE(), INTERVAL 60 DAY);

SELECT last_name, first_name, last_visit FROM patient WHERE last_visit < DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

SELECT last_name, first_name FROM president WHERE last_name LIKE 'W%';

This pattern matches last names that contain exactly four characters:
mysql> SELECT last_name, first_name FROM president WHERE last_name LIKE '____';

MySQL enables you to define your own variables.These can be set using query results, User variables are named using @var_name syntax and assigned a value in a SELECT statement using an expression of the form @var_name: = value.
SELECT @birth := birth FROM president WHERE last_name = 'Jackson' AND first_name = 'Andrew';
SELECT last_name, first_name, birth FROM president WHERE birth < @birth ORDER BY birth;

Variables also can be assigned using a SET statement. In this case, either = or := are allowable as the assignment operator:
mysql> SET @today = CURDATE();
mysql> SET @one_week_ago := DATE_SUB(@today, INTERVAL 7 DAY);
mysql> SELECT @today, @one_week_ago;


SELECT DISTINCT state FROM president ORDER BY state;
SELECT COUNT(*) FROM grade_event WHERE category = 'Q';
COUNT(*) counts every row selected. By contrast, COUNT(col_name) counts only non-NULL values.
SELECT COUNT(DISTINCT state) FROM president;
SELECT state, COUNT(*) FROM president GROUP BY state;
SELECT state, COUNT(*) FROM president GROUP BY state ORDER BY 2 DESC;
SELECT sex, COUNT(*) FROM student GROUP BY sex WITH ROLLUP;

mysql> SELECT
-> student.name, grade_event.date, score.score, grade_event.category
-> FROM grade_event INNER JOIN score INNER JOIN student
-> ON grade_event.event_id = score.event_id
-> AND score.student_id = student.student_id
-> WHERE grade_event.date = '2008-09-23';


mysql> SELECT student.student_id, student.name,
-> COUNT(absence.date) AS absences
-> FROM student LEFT JOIN absence
-> ON student.student_id = absence.student_id
-> GROUP BY student.student_id;

mysql> SELECT p1.last_name, p1.first_name, p1.city, p1.state
-> FROM president AS p1 INNER JOIN president AS p2
-> ON p1.city = p2.city AND p1.state = p2.state
-> WHERE (p1.last_name <> p2.last_name OR p1.first_name <> p2.first_name)
-> ORDER BY state, city, last_name;

mysql> SELECT * FROM student
-> WHERE student_id NOT IN (SELECT student_id FROM absence);

DELETE FROM president WHERE state='OH';

mysql> UPDATE member
-> SET expiration='2009-7-20'
-> WHERE last_name='York' AND first_name='Jerome';

Under Unix, you set up an option file by creating a file named ~/.my.cnf (that is, a file named .my.cnf in your home directory). Under Windows, create an option file named my.ini in your MySQL installation directory, or in the root directory of the C drive (that is, C:\my.ini).

[client]
host=server_host
user=your_name
password=your_pass

% chmod 600 .my.cnf
% chmod u=rw,go-rwx .my.cnf

--sql-mode="TRADITIONAL"
--sql-mode="ANSI_QUOTES,PIPES_AS_CONCAT"

Any client can set its own session-specific SQL mode:
SET sql_mode = 'TRADITIONAL';
To set the SQL mode globally, add the GLOBAL keyword:
SET GLOBAL sql_mode = 'TRADITIONAL';

Keywords and function names are not case sensitive. They can be given in any lettercase.

Database, table, and view names. MySQL represents databases and tables using directories and files in the underlying filesystem on the server host. As a result, the default case sensitivity of database and table names depends on the way the operating system on that host treats filenames.

Stored program names. Stored function and procedure names and event names are not case sensitive.Trigger names are case sensitive, which differs from standard SQL.

Column and index names. Column and index names are not case sensitive in MySQL.

Alias names. By default, table aliases are case sensitive.

String values. Case sensitivity of a string value depends on whether it is a binary or non-binary string,

To force creation of databases and tables with lowercase names even if not specified that way in CREATE statements, configure the server by setting the lower_case_table_names system variable.
MySQL character set support provides the following features:
. The server allows simultaneous use of multiple character sets.
. You can specify character sets at the server, database, table, column, and string constant level:
. SHOW statements and INFORMATION_SCHEMA tables provide information about the available character sets and collations.

CREATE DATABASE db_name CHARACTER SET charset COLLATE collation;
CREATE DATABASE mydb CHARACTER SET utf8 COLLATE utf8_icelandic_ci;
CREATE TABLE tbl_name (...) CHARACTER SET charset COLLATE collation;
c CHAR(10) CHARACTER SET charset COLLATE collation

SELECT c FROM t ORDER BY c COLLATE latin1_spanish_ci;

SHOW CHARACTER SET;
SHOW COLLATION;

SHOW CHARACTER SET LIKE 'latin%';
SHOW COLLATION LIKE 'utf8%';

collation names always begin with the character set name. e.g charset=utf8, collate=utf8_bin , utf8_unicode_ci etc

CREATE DATABASE [IF NOT EXISTS] db_name [CHARACTER SET charset] [COLLATE collation];

SHOW CREATE DATABASE mydb;

DROP DATABASE db_name;

ALTER DATABASE [db_name] [CHARACTER SET charset] [COLLATE collation];

MySQL Storage Engines
Storage  : Engine Description
ARCHIVE : Archival storage (no modification of rows after insertion)
BLACKHOLE : Engine that discards writes and returns empty reads
CSV : Storage in comma-separated values format
EXAMPLE : Example (“stub”) storage engine
Falcon : Transactional engine
FEDERATED : Engine for accessing remote tables
InnoDB : Transactional engine with foreign keys
MEMORY : In-memory tables
MERGE : Manages collections of MyISAM tables
MyISAM : The default storage engine
NDB : The engine for MySQL Cluster

SHOW ENGINES;

SELECT ENGINE FROM INFORMATION_SCHEMA.ENGINES WHERE TRANSACTIONS = 'YES';



---My experiment ---

SELECT VERSION();

SHOW DATABASES;

select 5 DIV 2, ABS(2), CEILING(1.23), FLOOR(1.23), MOD(34.5,3), FLOOR(7 + (RAND() * 5))

-- to obtain a random integer in the range the range 7 <= R < 12, FLOOR(7 + (RAND() * 5))

--CTE--
Introduction to MySQL recursive CTE( common table expression), CTE only available in MySQL version 8.0 or later.

WITH RECURSIVE cte_name AS (
    initial_query  -- anchor member
    UNION ALL
    recursive_query -- recursive member that references to the CTE name
)
SELECT * FROM cte_name;

WITH RECURSIVE cte_count (n) 
AS (
      SELECT 1       --Anchoe member
      UNION ALL
      SELECT n + 1 
      FROM cte_count -- recursive clause
      WHERE n < 3    -- termination condition
    )
SELECT n 
FROM cte_count;

WITH RECURSIVE employee_paths AS ( 
  SELECT 
      employeeNumber,
      reportsTo managerNumber,
      officeCode, 
      1 lvl
  FROM employees
  WHERE reportsTo IS NULL
  UNION ALL
  SELECT 
      e.employeeNumber,
      e.reportsTo,
      e.officeCode,
      lvl+1
  FROM employees e
  INNER JOIN employee_paths ep 
  ON ep.employeeNumber = e.reportsTo 
)
SELECT 
    employeeNumber,
    managerNumber,
    lvl,
    city
FROM employee_paths ep
INNER JOIN offices o 
USING (officeCode)
ORDER BY lvl, city;

---- SOngs
Love song - tere dur dur jana : kamal khan
Dil main ho tum : Cheat India : Armaan Malik
Tere bin : Simmba
Naina : Ankit Tiwari
Chhod Diya : Baazaar