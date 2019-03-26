Programs written in a declarative programming language describe what computation should be performed but not how to compute it. SQL is considered a declarative programming language. Compare SQL with imperative programming languages like C, Visual Basic, or even PL/SQL that specify each step of the computation.

if you want to log the sql id of previously executed statement inside a plsql block.

SELECT prev_sql_id 
INTO sql_id
FROM v$session
WHERE sid = SYS_CONTEXT ('USERENV', 'SID');

V$SQL contains information about statements that are currently running or have recently completed. V$SQL contains the following three columns, among others:
• SQL_ID is the SQL_ID of the statement.
• SQL_FULLTEXT is a CLOB column containing the text of the SQL statement.
• SQL_TEXT is a VARCHAR2 column that contains a potentially truncated variant of SQL_FULLTEXT.

An SQL_ID is a base 32 number represented as a string of 13 characters, each of which may be a digit or one of 22 lowercase letters. The SQL_ID is actually a hash generated from the characters in the SQL statement. So assuming that case and whitespace are preserved, the same SQL statement will have the same SQL_ID on any database on which it is used. remember that SQL_IDs are the same on all databases irrespective of database version!

If you have access to the SYS account of a database running 11.2 or later, you can use the below approach to identify the SQL_ID of a statement.

SELECT sys.dbms_sqltune_util0.sqltext_to_sqlid (
q'[SELECT 'LITERAL 1' FROM DUAL]' || CHR (0))
FROM DUAL;

It is necessary to append a NUL character to the end of the text

Sometimes SQL statement will likely have disappeared from the cursor cache, and a lookup using V$SQL will not work. In this case, you need to use DBA_HIST_SQLTEXT.

SELECT * FROM v$sql WHERE sql_fulltext LIKE '%''LITERAL1''%';
SELECT * FROM dba_hist_sqltext WHERE sql_text LIKE '%''LITERAL1''%';

Caution - The use of the views V$ACTIVE_SESSION_HISTORY and views beginning with the characters DBA_HIST_ require enterprise edition with the diagnostic pack.

Array Interface

DECLARE
    TYPE char_table_type IS TABLE OF t1.n1%TYPE;
    n1_array char_table_type;
n2_array char_table_type;
BEGIN
    DELETE FROM t1
        RETURNING n1, n2
        BULK COLLECT INTO n1_array, n2_array;
        
    FORALL i IN 1 .. n1_array.COUNT
    MERGE INTO t2
    USING DUAL
    ON (t2.n1 = n1_array (i))
    WHEN MATCHED
    THEN
        UPDATE SET t2.n2 = n2_array (i)
    WHEN NOT MATCHED
    THEN
        INSERT (n1, n2)
        VALUES (n1_array (i), n2_array (i));
END;
/

It is easy to think that the PL/SQL FORALL syntax represents a loop but actually It does not. It is just a way to invoke the array interface when passing array data into a Data Manipulation Language (DML) statement, just as BULK COLLECT is used to invoke the array interface when retrieving data.

The array interface is particularly important for code issued from an application server because it avoids multiple round trips between the client and the server, so the impact can be dramatic.

Subquery Factoring - with temp as (select * from dual) select * from temp
Benefit is redability, avoid temporary table

Joins

CREATE TABLE t1 AS
SELECT ROWNUM c1
FROM all_objects
WHERE ROWNUM <= 5;

CREATE TABLE t2 AS SELECT c1 + 1 c2 FROM t1; 
CREATE TABLE t3 AS SELECT c2 + 1 c3 FROM t2;
CREATE TABLE t4 AS SELECT c3 + 1 c4 FROM t3;


Rows in the tables will be
T1 : 1 2 3 4 5
T2 : 2 3 4 5 6
T3 : 3 4 5 6 7
T4 : 4 5 6 7 8

SELECT * FROM t1 LEFT OUTER JOIN t2 ON t1.c1 = t2.c2 AND t1.c1 > 4 -- keyword OUTER is optional
WHERE t1.c1 > 3
ORDER BY t1.c1;

Output will be

C1   C2
-------
4
5    5

The left operand of the join is called the preserved row source and the right operand the optional row source.

What this query (logically) says is:
• Identify combinations of rows in T1 and T2 that match the criteria T1.C1 = T2.C2 AND T1.C1 > 4.
• For all rows in T1 that do not match any rows in T2, output them with NULL for the columns in T2.
• Eliminate all rows from the result set that do not match the criteria T1.C1 > 3.

Notice that there is a big difference between a selection predicate and a join predicate. The selection predicate T1.C1 > 3 resulted in the elimination of rows from the result set, but the join predicate T1.C1 > 4 just resulted in the loss of column values from T2.
Not only is there now a big difference between a join predicate and a selection predicate, but the CBO doesn’t have complete freedom to reorder joins. CBO always uses the left operand of the left outer join (the preserved row source) as the driving row source in the join. 

In traditional proprietary syntax, the notation is severely limited in its ability, prior to 12cR1, a table can be the optional row source in at most one join, full and partitioned join are not supported.

The new syntax has been endorsed by the ANSI and is usually referred to as ANSI join syntax. This syntax is supported by all major database vendors and supports inner joins as well.

Right Outer Joins
A right outer join is just syntactic sugar. A right outer join preserves rows on the right instead of the left. Below shows how difficult queries can be to read without the right outer join syntax.

SELECT c1, c2, c3
FROM t1
    LEFT JOIN
    t2
    LEFT JOIN
    t3
    ON t2.c2 = t3.c3
    ON t1.c1 = t3.c3
ORDER BY c1;

SELECT c1, c2, c3
FROM t2
    LEFT JOIN t3
    ON t2.c2 = t3.c3
    RIGHT JOIN t1
    ON t1.c1 = t3.c3
ORDER BY c1;

I find the latter syntax easier to read, but it makes no difference to either the execution plan or the results.

Partitioned Outer Joins : Both left and right outer joins can be partitioned. This term is somewhat overused. To be clear, its use here has nothing to do with the partitioning option, which relates to a physical database design feature.

To explain partitioned outer joins, lets take SALES table from the SH example schema. To keep the result set small, I am just looking at sales made to countries in Europe between 1998 and 1999. For each year, I want to know the total sold per country vs. the average number of sales per country made to customers born in 1976.

First Attempt

WITH sales_q
AS (SELECT s.*, EXTRACT (YEAR FROM time_id) sale_year FROM sh.sales s)
SELECT sale_year
    ,country_name
    ,NVL (SUM (amount_sold), 0) amount_sold
    ,AVG (NVL (SUM (amount_sold), 0)) OVER (PARTITION BY sale_year)
    avg_sold
FROM sales_q s
    JOIN sh.customers c USING (cust_id) -- PARTITION BY (sale_year)
    RIGHT JOIN sh.countries co
    ON c.country_id = co.country_id AND cust_year_of_birth = 1976
WHERE (sale_year IN (1998, 1999) OR sale_year IS NULL)
    AND country_region = 'Europe'
GROUP BY sale_year, country_name
ORDER BY 1, 2;

If you uncomment the partiotion by clause the result will be different, test and understand??? 
The problem that partitioned outer joins solves is known as data densification.

Chapter - 2 The Cost-Based Optimizer

The vast majority of the CBO’s work revolves around optimizing queries or the subqueries embedded in DML or Data Definition Language (DDL) statements.
Fortunately, or unfortunately, the CBO has a very simple view of what constitutes optimal: the optimal execution plan is the one that runs the quickest.

Unfortunately, for historical reasons, the unit of cost is defined as the length of time that a single block read takes to complete! So, if the CBO thinks that a query will take 5 seconds to run and that a single block read takes 10 milliseconds, then the assigned cost will be 500 as this is 5,000 milliseconds divided by 10 milliseconds.

To arrive at the cost of an execution plan, the CBO doesn’t just estimate the number of single block reads. It also tries to work out how long any multiblock read operations in the plan will take and how long central processing unit (CPU)-related operations, such as in-memory sorts, take to run, and it incorporates these times in the overall cost. Oddly enough, though, it translates all these times into equivalent single block reads. Here’s an example. Suppose that a particular plan is estimated to involve:
• 400 single block reads
• 300 multiblock reads
• 5 seconds of CPU processing

Let’s further assume that the CBO estimates that:
• A single block read takes 10 milliseconds
• A multiblock read takes 30 milliseconds
The cost of this plan is calculated as: ((400 x 10) + (300 x 30) + 5,000)/10 = 1800

These days, execution plans are typically printed with both a cost and an estimated elapsed time in hours, minutes, and seconds, so you don’t have to do quite as much math as you used to!

The main inputs to the CBO’s estimating process are the object statistics that are held in the data dictionary. These statistics will indicate, for example, how many blocks are in a table and, therefore, how many multiblock reads would be required to read it in its entirety. Statistics are also held for indexes, so the CBO has some basis for estimating how many single block reads will be required to read data from a table using an index.
Object statistics are the most important inputs to the CBO’s costing algorithm but by no means the only ones. Initialization parameter settings, system statistics, dynamic sampling, SQL profiles, and SQL baselines are all examples of other things the CBO considers when making its cost estimates.

