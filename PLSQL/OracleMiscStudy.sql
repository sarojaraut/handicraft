Pseudocolumns
 
A pseudocolumn behaves like a table column, but is not actually stored in the table. You can select from pseudocolumns, but you cannot insert, update, or delete their values. A pseudocolumn is also similar to a function without arguments. However, functions without arguments typically return the same value for every row in the result set,whereas pseudocolumns typically return a different value for each row.

� Hierarchical Query Pseudocolumns > (CONNECT_BY_ISCYCLE, CONNECT_BY_ISLEAF, LEVEL)
The CONNECT_BY_ISCYCLE pseudocolumn returns 1 if the current row has a child which is also its ancestor. Otherwise it returns 0.
The CONNECT_BY_ISLEAF pseudocolumn returns 1 if the current row is a leaf of the tree defined by the CONNECT BY condition. Otherwise it returns 0. This information indicates whether a given row can be further expanded to show more of the hierarchy.

SELECT last_name "Employee", CONNECT_BY_ISLEAF "IsLeaf",
       LEVEL, SYS_CONNECT_BY_PATH(last_name, '/') "Path"
  FROM employees
  WHERE LEVEL <= 3 AND department_id = 80
  START WITH employee_id = 100
  CONNECT BY PRIOR employee_id = manager_id AND LEVEL <= 4
  ORDER BY "Employee", "IsLeaf";

For each row returned by a hierarchical query, the LEVEL pseudocolumn returns 1 for a root row, 2 for a child of a root, and so on.

� Sequence Pseudocolumns(CURRVAL, NEXTVAL)
Where to Use Sequence Values 
� The select list of a SELECT statement that is not contained in a subquery, materialized view, or view
� The select list of a subquery in an INSERT statement
� The VALUES clause of an INSERT statement
� The SET clause of an UPDATE statement

You cannot use CURRVAL and NEXTVAL in the following constructs:
� A subquery in a DELETE, SELECT, or UPDATE statement
� A query of a view or of a materialized view
� A SELECT statement with the DISTINCT operator, with a GROUP BY clause or ORDER BY clause
� A SELECT statement that is combined with another SELECT statement with the UNION, INTERSECT, or MINUS set operator
� The WHERE clause of a SELECT statement
� The condition of a CHECK constraint

ROWNUM Pseudocolumn
For each row returned by a query, the ROWNUM pseudocolumn returns a number indicating the order in which Oracle selects the row from a table or set of joined rows. The first row selected has a ROWNUM of 1, the second has 2, and so on.

Data Densification

Data is normally stored in sparse form. That is, if no value exists for a given combination of dimension values, no row exists in the fact table. However, you may want to view the data in dense form, with rows for all combination of dimension values displayed even when no fact data exist for them. For example, if a product did not sell during a particular time period, you may still want to see the product for that time period with zero sales value next to it. One way of obtaning data densification is using partition join.

Partition Join Syntax
The syntax for partitioned outer join extends the SQL JOIN clause with the phrase PARTITION BY followed by an expression list. The expressions in the list specify the group to which the outer join is applied. The following are the two forms of syntax normally used for partitioned outer join:

SELECT .....
FROM table_reference
PARTITION BY (expr [, expr ]... )
RIGHT OUTER JOIN table_reference

SELECT .....
FROM table_reference
LEFT OUTER JOIN table_reference
PARTITION BY {expr [,expr ]...)

Example

SELECT Product_Name, t.Year, t.Week, NVL(Sales,0) dense_sales
FROM
    (
      SELECT 
        SUBSTR(p.Prod_Name,1,15) Product_Name,
        t.Calendar_Year Year, 
        t.Calendar_Week_Number Week, 
        SUM(Amount_Sold) Sales
    FROM Sales s, Times t, Products p
    WHERE s.Time_id = t.Time_id 
    AND s.Prod_id = p.Prod_id 
    AND p.Prod_name IN ('Bounce') 
    AND t.Calendar_Year IN (2000,2001) 
    AND t.Calendar_Week_Number BETWEEN 20 AND 30
    GROUP BY p.Prod_Name, t.Calendar_Year, t.Calendar_Week_Number
    ) v
    -- Data from v needs to be densified. where clause between 20 and 30 is for minimizing the data set for example
PARTITION BY (v.Product_Name)
RIGHT OUTER JOIN
    (SELECT DISTINCT 
      Calendar_Week_Number Week,
      Calendar_Year Year
    FROM Times
    WHERE Calendar_Year IN (2000, 2001)
    AND Calendar_Week_Number BETWEEN 20 AND 30) t
ON (v.week = t.week AND v.Year = t.Year)
ORDER BY t.year, t.week;

Limiting SQL Rows - 12C feature

SELECT employee_id, last_name
FROM employees
ORDER BY employee_id
FETCH FIRST 5 ROWS ONLY;

SELECT employee_id, last_name
FROM employees
ORDER BY employee_id
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;

[ OFFSET offset { ROW | ROWS } ]
[ FETCH { FIRST | NEXT } [ { rowcount | percent PERCENT } ]
{ ROW | ROWS } { ONLY | WITH TIES } ]

Groupings
The CUBE, ROLLUP, and GROUPING SETS extensions to SQL make querying and reporting easier and faster. 

ROLLUP Extension to GROUP BY
ROLLUP enables a SELECT statement to calculate multiple levels of subtotals across a specified group of dimensions. It creates subtotals that roll up from the most
detailed level to a grand total, following a grouping list specified in the ROLLUP clause. ROLLUP takes as its argument an ordered list of grouping columns. First, it calculates the standard aggregate values specified in the GROUP BY clause. Then, it creates progressively higher-level subtotals, moving from right to left through the list of grouping columns. Finally, it creates a grand total.

Use the ROLLUP extension in tasks involving subtotals.
� It is very helpful for subtotaling along a hierarchical dimension such as time or geography. For instance, a query could specify a ROLLUP(y, m, day) or ROLLUP(country, state, city).
� For data warehouse administrators using summary tables, ROLLUP can simplify and speed up the maintenance of summary tables.

SELECT channels.channel_desc, calendar_month_desc, countries.country_iso_code, TO_CHAR(SUM(amount_sold), '9,999,999,999') SALES$
FROM sales, customers, times, channels, countries
WHERE sales.time_id=times.time_id
AND sales.cust_id=customers.cust_id
AND customers.country_id = countries.country_id
AND sales.channel_id = channels.channel_id
AND channels.channel_desc IN ('Direct Sales', 'Internet')
AND times.calendar_month_desc IN ('2000-09', '2000-10')
AND countries.country_iso_code IN ('GB', 'US')
GROUP BY ROLLUP(channels.channel_desc, calendar_month_desc, countries.country_iso_code);

CHANNEL_DESC CALENDAR CO SALES$
-------------------- -------- -- --------------
Internet	2000-09	GB	16,569
Internet	2000-09	US	124,224
Internet	2000-09	    140,793
Internet	2000-10	GB	14,539
Internet	2000-10	US	137,054
Internet	2000-10	    151,593
Internet	            292,387
Direct Sales	2000-09	GB	85,223
Direct Sales	2000-09	US	638,201
Direct Sales	2000-09	    723,424
Direct Sales	2000-10	GB	91,925
Direct Sales	2000-10	US	682,297
Direct Sales	2000-10	    774,222
Direct Sales	            1,497,646
                            1,790,032

This query returns the following sets of rows:
� Regular aggregation rows that would be produced by GROUP BY without using ROLLUP.
� First-level subtotals aggregating across country_id for each combination of channel_desc and calendar_month.
� Second-level subtotals aggregating across calendar_month_desc and country_id for each channel_desc value.
� A grand total row.

Partial Rollup
You can also roll up so that only some of the sub-totals will be included. This partial rollup uses the following syntax:
GROUP BY expr1, ROLLUP(expr2, expr3);

In this case, the GROUP BY clause creates subtotals at (2+1=3) aggregation levels. That is, at level (expr1, expr2, expr3), (expr1, expr2), and (expr1).

CUBE Extension to GROUP BY
CUBE takes a specified set of grouping columns and creates subtotals for all of their possible combinations. In terms of multidimensional analysis, CUBE generates all the subtotals that could be calculated for a data cube with the specified dimensions.

GROUPING SETS Expression
You can selectively specify the set of groups that you want to create using a GROUPING SETS expression within a GROUP BY clause.

CUBE(a, b, c) = GROUPING SETS ((a, b, c), (a, b), (a, c), (b, c), (a), (b), (c), ())
ROLLUP(a, b, c) = GROUPING SETS ((a, b, c), (a, b),(a), ())

GROUP BY ROLLUP(a, b, c) equivalent to
GROUP BY a, b, c UNION ALL
GROUP BY a, b UNION ALL
GROUP BY a UNION ALL
GROUP BY ()

GROUP BY ROLLUP(a, (b, c)) This is equivalent to:
GROUP BY a, b, c UNION ALL
GROUP BY a UNION ALL
GROUP BY ()

GROUP BY CUBE((a, b), c) This is equivalent to:
GROUP BY a, b, c UNION ALL
GROUP BY a, b UNION ALL
GROUP BY c UNION ALL
GROUP By ()

GROUPING Functions : Provides an easy way to determine which rows are the subtotals in  cube or rollup output. 

SELECT channels.channel_desc, calendar_month_desc, countries.country_iso_code, TO_CHAR(SUM(amount_sold), '9,999,999,999') SALES$
grouping(channels.channel_desc) chdesc, grouping(calendar_month_desc) cmdesc, grouping(countries.country_iso_code) cisocd, 
grouping_id(channels.channel_desc,calendar_month_desc,countries.country_iso_code)
FROM sales, customers, times, channels, countries
WHERE sales.time_id=times.time_id
AND sales.cust_id=customers.cust_id
AND customers.country_id = countries.country_id
AND sales.channel_id = channels.channel_id
AND channels.channel_desc IN ('Direct Sales', 'Internet')
AND times.calendar_month_desc IN ('2000-09', '2000-10')
AND countries.country_iso_code IN ('GB', 'US')
GROUP BY ROLLUP(channels.channel_desc, calendar_month_desc, countries.country_iso_code);

grouping returns 1 if the row is a subtotal row for the input column, else returns 0.
grouping_id returns the binary representation of 1, 0 combinations for all input columns based on the type of subtotal.


