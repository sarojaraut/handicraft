Notes :
Indexes consume disk space and processing resources, add indexes judiciously. Test first to determine quantifiable performance gains.
Use the correct type of index : Reverse key, composite, index the foreign keys, function based index, index organised tables(for intersection tables)
Consider creating concatenated indexes that result in only the index structure being required to return the result set.
Consider creating indexes on columns used in the ORDER BY, GROUP BY, UNION, or DISTINCT clauses.

select * from emp where empno =10;
--------------------------------------------------------------------------------------
| Id  | Operation                   | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |        |     1 |   309 |     3   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP    |     1 |   309 |     3   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_EMP |     1 |       |     2   (0)| 00:00:01 |
--------------------------------------------------------------------------------------

create index cust_idx1 on emp(ename) nosegment;

-------------------------------------------------------------------------------------------------
| Id  | Operation                           | Name      | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                    |           |     1 |   309 |     5   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID BATCHED| EMP       |     1 |   309 |     5   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN                  | CUST_IDX1 |     1 |       |     3   (0)| 00:00:01 |
-------------------------------------------------------------------------------------------------

EMEI Number : 353391090186582
