table_reference ::=
  {only (query_table_expression) | query_table_expression }[flashback_query_clause]
   [pivot_clause|unpivot_clause|row_pattern_recognition_clause] [t_alias]

row_pattern_recognition_clause ::=
  MATCH_RECOGNIZE (
   [row_pattern_partition_by ]
   [row_pattern_order_by ]
   [row_pattern_measures ]
   [row_pattern_rows_per_match ]
   [row_pattern_skip_to ]
   PATTERN (row_pattern)
   [ row_pattern_subset_clause]
   DEFINE row_pattern_definition_list
   )

row_pattern_partition_by ::=
   PARTITION BY column[, column]...

row_pattern_order_by ::=
   ORDER BY column[, column]...

row_pattern_measures ::=
   MEASURES row_pattern_measure_column[, row_pattern_measure_column]...

    row_pattern_measure_column ::=
        expression AS c_alias

row_pattern_rows_per_match ::=
   ONE ROW PER MATCH
  | ALL ROWS PER MATCH

row_pattern_skip_to ::=
   AFTER MATCH {
    SKIP TO NEXT ROW
   | SKIP PAST LAST ROW
   | SKIP TO FIRST variable_name
   | SKIP TO LAST variable_name
   | SKIP TO variable_name}

row_pattern ::=
   row_pattern_term
  | row_pattern "|" row_pattern_term

row_pattern_term ::=
   row_pattern_factor
  | row_pattern_term row_pattern_factor

row_pattern_factor ::=
   row_pattern_primary [row_pattern_quantifier]

row_pattern_quantifier ::=
    *[?]
   |+[?]
   |?[?]
   |"{"[unsigned_integer ],[unsigned_integer]"}"[?]
   |"{"unsigned_integer "}"

row_pattern_primary ::=
   variable_name
   |$
   |^
   |([row_pattern])
   |"{-" row_pattern"-}"
   | row_pattern_permute

row_pattern_permute ::=
   PERMUTE (row_pattern [, row_pattern] ...)

row_pattern_subset_clause ::=
   SUBSET row_pattern_subset_item [, row_pattern_subset_item] ...

row_pattern_subset_item ::=
   variable_name = (variable_name[ , variable_name]...)

row_pattern_definition_list ::=
   row_pattern_definition[, row_pattern_definition]...

row_pattern_definition ::=
   variable_name AS condition

CREATE TABLE sales_history (
  id            NUMBER,
  product       VARCHAR2(20),
  tstamp        TIMESTAMP,
  units_sold    NUMBER,
  CONSTRAINT sales_history_pk PRIMARY KEY (id)
);

CREATE TABLE sales_audit (
  id            NUMBER,
  product       VARCHAR2(20),
  tstamp        TIMESTAMP,
  CONSTRAINT sales_audit_pk PRIMARY KEY (id)
);

ALTER SESSION SET nls_timestamp_format = 'DD-MON-YYYY';

INSERT INTO sales_history VALUES ( 1, 'TWINKIES', '01-OCT-2014', 17);
INSERT INTO sales_history VALUES ( 2, 'TWINKIES', '02-OCT-2014', 19);
INSERT INTO sales_history VALUES ( 3, 'TWINKIES', '03-OCT-2014', 23);
INSERT INTO sales_history VALUES ( 4, 'TWINKIES', '04-OCT-2014', 23);
INSERT INTO sales_history VALUES ( 5, 'TWINKIES', '05-OCT-2014', 16);
INSERT INTO sales_history VALUES ( 6, 'TWINKIES', '06-OCT-2014', 10);
INSERT INTO sales_history VALUES ( 7, 'TWINKIES', '07-OCT-2014', 14);
INSERT INTO sales_history VALUES ( 8, 'TWINKIES', '08-OCT-2014', 16);
INSERT INTO sales_history VALUES ( 9, 'TWINKIES', '09-OCT-2014', 15);
INSERT INTO sales_history VALUES (10, 'TWINKIES', '10-OCT-2014', 17);
INSERT INTO sales_history VALUES (11, 'TWINKIES', '11-OCT-2014', 23);
INSERT INTO sales_history VALUES (12, 'TWINKIES', '12-OCT-2014', 30);
INSERT INTO sales_history VALUES (13, 'TWINKIES', '13-OCT-2014', 31);
INSERT INTO sales_history VALUES (14, 'TWINKIES', '14-OCT-2014', 29);
INSERT INTO sales_history VALUES (15, 'TWINKIES', '15-OCT-2014', 25);
INSERT INTO sales_history VALUES (16, 'TWINKIES', '16-OCT-2014', 21);
INSERT INTO sales_history VALUES (17, 'TWINKIES', '17-OCT-2014', 35);
INSERT INTO sales_history VALUES (18, 'TWINKIES', '18-OCT-2014', 46);
INSERT INTO sales_history VALUES (19, 'TWINKIES', '19-OCT-2014', 45);
INSERT INTO sales_history VALUES (20, 'TWINKIES', '20-OCT-2014', 30);

ALTER SESSION SET nls_timestamp_format = 'DD-MON-YYYY HH24:MI:SS';
INSERT INTO sales_audit VALUES ( 1, 'TWINKIES', '01-OCT-2014 12:00:01');
INSERT INTO sales_audit VALUES ( 2, 'TWINKIES', '01-OCT-2014 12:00:02');
INSERT INTO sales_audit VALUES ( 3, 'DINGDONGS', '01-OCT-2014 12:00:03');
INSERT INTO sales_audit VALUES ( 4, 'HOHOS', '01-OCT-2014 12:00:04');
INSERT INTO sales_audit VALUES ( 5, 'HOHOS', '01-OCT-2014 12:00:05');
INSERT INTO sales_audit VALUES ( 6, 'TWINKIES', '01-OCT-2014 12:00:06');
INSERT INTO sales_audit VALUES ( 7, 'TWINKIES', '01-OCT-2014 12:00:07');
INSERT INTO sales_audit VALUES ( 8, 'DINGDONGS', '01-OCT-2014 12:00:08');
INSERT INTO sales_audit VALUES ( 9, 'DINGDONGS', '01-OCT-2014 12:00:09');
INSERT INTO sales_audit VALUES (10, 'HOHOS', '01-OCT-2014 12:00:10');
INSERT INTO sales_audit VALUES (11, 'HOHOS', '01-OCT-2014 12:00:11');
INSERT INTO sales_audit VALUES (12, 'TWINKIES', '01-OCT-2014 12:00:12');
INSERT INTO sales_audit VALUES (13, 'TWINKIES', '01-OCT-2014 12:00:13');
INSERT INTO sales_audit VALUES (14, 'DINGDONGS', '01-OCT-2014 12:00:14');
INSERT INTO sales_audit VALUES (15, 'DINGDONGS', '01-OCT-2014 12:00:15');
INSERT INTO sales_audit VALUES (16, 'HOHOS', '01-OCT-2014 12:00:16');
INSERT INTO sales_audit VALUES (17, 'TWINKIES', '01-OCT-2014 12:00:17');
INSERT INTO sales_audit VALUES (18, 'TWINKIES', '01-OCT-2014 12:00:18');
INSERT INTO sales_audit VALUES (19, 'TWINKIES', '01-OCT-2014 12:00:19');
INSERT INTO sales_audit VALUES (20, 'TWINKIES', '01-OCT-2014 12:00:20');
COMMIT;

SELECT id,
       product,
       tstamp,
       units_sold,
       RPAD('#', units_sold, '#') AS graph
FROM   sales_history
ORDER BY id;

-- Check for peaks/spikes in sale
-- pattern we are searching for is 1-Many UPs, optionally leveling off, followed by 1-Many Downs.
-- The measures displayed are the start of the pattern (STRT.tstamp), the top of the peak (LAST(UP.tstamp)) and the bottom of the drop (LAST(DOWN.tstamp)), 
--   with a single row for each match. We are also displaying the MATCH_NUMBER()
-- The output tells us there were 4 distinct peaks/spikes in the sales, giving us the location of the start, peak and end of the pattern.
SELECT *
FROM   sales_history 
    MATCH_RECOGNIZE (
        PARTITION BY product
        ORDER BY tstamp
        MEASURES  
            STRT.tstamp       AS start_tstamp,
            LAST(UP.tstamp)   AS peak_tstamp,
            LAST(DOWN.tstamp) AS end_tstamp,
            MATCH_NUMBER()    AS mno
        ONE ROW PER MATCH
        AFTER MATCH SKIP TO LAST DOWN
        PATTERN (STRT UP+ FLAT* DOWN+)
        DEFINE
            UP   AS UP.units_sold > PREV(UP.units_sold),
            FLAT AS FLAT.units_sold = PREV(FLAT.units_sold),
            DOWN AS DOWN.units_sold < PREV(DOWN.units_sold)
    ) MR
ORDER BY MR.product, MR.start_tstamp;

--
-- Similar to above output but shows all the rows for the match and includes the CLASSIFIER()
--      function to indicate which pattern variable is relevant for each row. 
-- Notice how some rows are duplicated, as they represent the end of one pattern and the start of the next.
SELECT *
FROM   sales_history MATCH_RECOGNIZE (
         PARTITION BY product
         ORDER BY tstamp
         MEASURES  STRT.tstamp       AS start_tstamp,
                   LAST(UP.tstamp)   AS peak_tstamp,
                   LAST(DOWN.tstamp) AS end_tstamp,
                   MATCH_NUMBER()    AS mno,
                   CLASSIFIER()      AS cls
         ALL ROWS PER MATCH
         AFTER MATCH SKIP TO LAST DOWN
         PATTERN (STRT UP+ FLAT* DOWN+)
         DEFINE
           UP   AS UP.units_sold > PREV(UP.units_sold),
           FLAT AS FLAT.units_sold = PREV(FLAT.units_sold),
           DOWN AS DOWN.units_sold < PREV(DOWN.units_sold)
       ) MR
ORDER BY MR.product, MR.start_tstamp;

-- from Live SQL
create table t(test_case, order_by, condition, description) as select 
1, 1, 'A', 'One match covers the entire partition' from dual union all select 
1, 2, 'B', '' from dual union all select 
2, 1, 'A', 'Match 1 starts partition' from dual union all select 
2, 2, 'B', '' from dual union all select 
2, 3, 'A', 'Match 2 immediately after 1, ends partition' from dual union all select 
2, 4, 'B', '' from dual union all select 
3, 1, 'A', 'Match 1 starts partition' from dual union all select 
3, 2, 'B', '' from dual union all select 
3, 3, 'A', 'Second "match" bad: intermediate row' from dual union all select 
3, 4, 'X', 'This is the intermediate row' from dual union all select 
3, 5, 'B', '' from dual union all select 
4, 1, 'X', 'Non-matching row starts partition' from dual union all select 
4, 2, 'A', 'Match 1' from dual union all select 
4, 3, 'B', '' from dual union all select 
4, 4, 'X', 'Non-matching row between matches' from dual union all select 
4, 5, 'A', 'Match 2' from dual union all select 
4, 6, 'B', '' from dual union all select 
4, 7, 'X', 'Non-matching row ends partition' from dual;

create table headers(TEST_CASE, ORDER_BY, MN, CONDITION, DESCRIPTION) as 
select test_case, cast(null as number), cast(null as number), 
null, 'INPUT------------' from t 
union 
select test_case, null, 1, null, 'OUTPUT-----------' from t 
union all 
select TEST_CASE, ORDER_BY, null, CONDITION, DESCRIPTION from t;

select * from headers 
union all 
SELECT * FROM t 
match_recognize( 
  PARTITION BY test_case 
  ORDER BY order_by 
  MEASURES 
    MATCH_NUMBER() mn 
  ALL ROWS PER MATCH 
  PATTERN( A B ) 
  DEFINE A AS condition = 'A', 
         B AS condition = 'B' 
)
order by 1, 3 nulls first, 2 nulls first;

select order_by, test_case, condition, descrption from t; 

https://livesql.oracle.com/apex/livesql/file/tutorial_EG95N4HMCYSL1A0Y6J80UHNHB.html

SELECT *
FROM Ticker 
    MATCH_RECOGNIZE (
        PARTITION BY symbol
        ORDER BY tstamp
        MEASURES 
            FIRST(DOWN.tstamp) AS start_ts,
            LAST(DOWN.tstamp)  AS bottom_ts,
            LAST(UP.tstamp)    AS end_ts
        ONE ROW PER MATCH
        AFTER MATCH SKIP PAST LAST ROW
--        AFTER MATCH SKIP TO LAST UP
        PATTERN (STRT DOWN+ UP+)
        DEFINE
            DOWN AS price < PREV(price), 
            UP   AS price > PREV(price)
) MR
ORDER BY MR.symbol, MR.start_ts;
-- AFTER MATCH SKIP TO LAST ROW : means that whenever we find a match, we restart the search process for the next match at the next row after the last row mapped to the UP pattern variable. This is the default behavior.

--  Lets try AFTER MATCH SKIP TO LAST UP and see what happens : You will now find that more rows are returned because we are starting our search for the next match at a point where we a guaranteed to find that the price of next row is lower than the price of the previous row. The STRT variable is mapped to the last row mapped to up - in effect we have a row being double mapped.
-- Other options are
-- AFTER MATCH SKIP TO NEXT ROW - Resume pattern matching at the row after the first row of the current match.
-- AFTER MATCH SKIP PAST LAST ROW - Resume pattern matching at the next row after the last row of the current match.
-- AFTER MATCH SKIP TO FIRST pattern_variable - Resume pattern matching at the first row that is mapped to the pattern variable.
-- AFTER MATCH SKIP TO LAST pattern_variable - Resume pattern matching at the last row that is mapped to the pattern variable.
-- AFTER MATCH SKIP TO pattern_variable - The same as AFTER MATCH SKIP TO LAST pattern_variable.

-- The PATTERN clause defines a regular expression in similar way to the existing Oracle regular expression functions. However, within this clause we have create a completely new a highly expressive way to search for patterns.
    -- PATTERN (STRT DOWN+ UP+) 
    -- this syntax indicates that the pattern we are searching for has three pattern variables: STRT, DOWN, and UP. The plus sign (+) after DOWN and UP means that at least one row must be mapped to each of them.
    -- The plus sign (+) is known as a "quantifier" and there is a large library of quantifiers available to help you define your own patterns. Quantifiers define the number of iterations accepted for a match. Use the link below to access the documentation to learn more about quantifiers.
-- The DEFINE keyword gives us the conditions that must be met for a row to map to your row pattern variables STRT, DOWN, and UP. Because there is no condition for STRT, any row can be mapped to STRT. It is in effect and "always-true" event.

-- Finding Q pattern
SELECT *
FROM Ticker MATCH_RECOGNIZE (
 PARTITION BY symbol ORDER BY tstamp
 MEASURES STRT.tstamp AS start_w,
          LAST(z.tstamp) AS end_w
 ONE ROW PER MATCH
 AFTER MATCH SKIP PAST LAST ROW
 PATTERN (STRT x+ y+ w+ z+)
DEFINE
  x AS x.price <= PREV(x.price),
  y AS y.price >= PREV(y.price),
  w AS w.price <= PREV(w.price),
  z AS z.price >= PREV(z.price) 
) MR
WHERE symbol='ACME'
ORDER BY symbol, MR.start_w;

-- Example 2
-- Solution to break the listagg strings at the length 
-- 

CREATE OR REPLACE VIEW emp_mr AS
SELECT * 
FROM emp 
    MATCH_RECOGNIZE(
    PARTITION BY deptno 
    ORDER BY empno
    MEASURES 
        match_number() as mno,
        classifier()   as pattern_vrb
    ALL ROWS PER MATCH
    AFTER MATCH SKIP PAST LAST ROW
    PATTERN (S B+)
    DEFINE 
        B AS LENGTHB(S.ename) + SUM(LENGTHB(CONCAT(b.ename, ';'))) + LENGTHB(';') < = 15
    );

SELECT
    deptno,
    mno, 
    empno,
    ename,
    pattern_vrb,
    sum(LENGTH(ename)) OVER (PARTITION BY deptno, mno ORDER BY empno) AS str_length
FROM emp_mr;

SELECT
    deptno,
    LISTAGG(ename, ';') WITHIN GROUP (ORDER BY empno) AS namelist,
    length(LISTAGG(ename, ';') WITHIN GROUP (ORDER BY empno)) AS how_long
FROM emp_mr
GROUP BY deptno, mno;

SELECT *
FROM Ticker MATCH_RECOGNIZE (
  PARTITION BY symbol
  ORDER BY tstamp
  MEASURES
    MATCH_NUMBER()         AS match_num,
    CLASSIFIER()           AS var_match,
    FINAL COUNT(UP.tstamp) AS up_days,    -- shows the number of days mapped to the UP pattern variable within each match
    FINAL COUNT(tstamp)    AS total_days, -- returns the count of all rows included in a match.
    RUNNING COUNT(tstamp)  AS cnt_days,   -- You do not need to use the RUNNING keyword explicitly in this case because it is the default.
    price - STRT.price     AS price_dif   -- each day's difference in stock price from the price at the first day of a match
  ALL ROWS PER MATCH
  AFTER MATCH SKIP TO LAST UP
  PATTERN (STRT DOWN+ UP+)
  DEFINE
    DOWN AS DOWN.price < PREV(DOWN.price),
    UP AS UP.price > PREV(UP.price)
  ) MR
ORDER BY MR.symbol, MR.match_num, MR.tstamp;

/*
-- Emp Table Script

create table dept(
  deptno number(2,0),
  dname  varchar2(14),
  loc    varchar2(13),
  constraint pk_dept primary key (deptno)
);
 
create table emp(
  empno    number(4,0),
  ename    varchar2(10),
  job      varchar2(9),
  mgr      number(4,0),
  hiredate date,
  sal      number(7,2),
  comm     number(7,2),
  deptno   number(2,0),
  constraint pk_emp primary key (empno),
  constraint fk_deptno foreign key (deptno) references dept (deptno)
);

insert into dept
values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept
values(20, 'RESEARCH', 'DALLAS');
insert into dept
values(30, 'SALES', 'CHICAGO');
insert into dept
values(40, 'OPERATIONS', 'BOSTON');
 
insert into emp
values(
 7839, 'KING', 'PRESIDENT', null,
 to_date('17-11-1981','dd-mm-yyyy'),
 5000, null, 10
);
insert into emp
values(
 7698, 'BLAKE', 'MANAGER', 7839,
 to_date('1-5-1981','dd-mm-yyyy'),
 2850, null, 30
);
insert into emp
values(
 7782, 'CLARK', 'MANAGER', 7839,
 to_date('9-6-1981','dd-mm-yyyy'),
 2450, null, 10
);
insert into emp
values(
 7566, 'JONES', 'MANAGER', 7839,
 to_date('2-4-1981','dd-mm-yyyy'),
 2975, null, 20
);
insert into emp
values(
 7788, 'SCOTT', 'ANALYST', 7566,
 to_date('13-JUL-87','dd-mm-rr') - 85,
 3000, null, 20
);
insert into emp
values(
 7902, 'FORD', 'ANALYST', 7566,
 to_date('3-12-1981','dd-mm-yyyy'),
 3000, null, 20
);
insert into emp
values(
 7369, 'SMITH', 'CLERK', 7902,
 to_date('17-12-1980','dd-mm-yyyy'),
 800, null, 20
);
insert into emp
values(
 7499, 'ALLEN', 'SALESMAN', 7698,
 to_date('20-2-1981','dd-mm-yyyy'),
 1600, 300, 30
);
insert into emp
values(
 7521, 'WARD', 'SALESMAN', 7698,
 to_date('22-2-1981','dd-mm-yyyy'),
 1250, 500, 30
);
insert into emp
values(
 7654, 'MARTIN', 'SALESMAN', 7698,
 to_date('28-9-1981','dd-mm-yyyy'),
 1250, 1400, 30
);
insert into emp
values(
 7844, 'TURNER', 'SALESMAN', 7698,
 to_date('8-9-1981','dd-mm-yyyy'),
 1500, 0, 30
);
insert into emp
values(
 7876, 'ADAMS', 'CLERK', 7788,
 to_date('13-JUL-87', 'dd-mm-rr') - 51,
 1100, null, 20
);
insert into emp
values(
 7900, 'JAMES', 'CLERK', 7698,
 to_date('3-12-1981','dd-mm-yyyy'),
 950, null, 30
);
insert into emp
values(
 7934, 'MILLER', 'CLERK', 7782,
 to_date('23-1-1982','dd-mm-yyyy'),
 1300, null, 10
);

*/