/*

SQL Macros are new in Oracle 19c
SQM can encapsulate complex processing within a macro which then be used anywhere inside SQL statement

Two types of SQL Macros
1. TABLE expressions typically used in a FROM-clause
2. SCALAR expressions used in SELECT list, WHERE/HAVING, GROUP BY/ORDER BY clauses

TABLE type SQL Macro

1. Parameterized Views : Tables used in queries are fixed inside the definition of macro, Arguments are passed in to select rows from those tables. Common use of these parameterized views is when the scalar arguments are used to select a subset of the rows that are then aggregated


2. Polymorphic Views
Table valued macros that have one or more table arguments, can additionally have scalar valued arguments as well!

{USER, ALL, DBA}_PROCEDURES views will have new column called SQL_MACRO.
– Column can have the values NULL, SCALAR, or TABLE.

SQL Macros have an important advantage over ordinary PL/SQL functions in that they make the reusable SQL code completely transparent to the Optimizer – and that brings big benefits! It makes it possible for the optimizer to transform the original code for efficient execution because the underlying query inside the macro function can be merged into outer query. That means there is no context switching between PL/SQL and SQL and the query inside the macro function is now executed under same snapshot as outer query. So we get both simplicity and faster execution.

*/

create or replace function budget_parametrized_vw (
    i_dept_no number default 10)
return varchar2 sql_macro(table)
is
begin
    return q'[
    select
        d.deptno,
        sum(e.sal) budget,
        any_value(d.dname) department,
        count(e.empno) headcount,
        count(e.mgr) mgr_headcount
    from emp e, dept d
    where d.deptno = i_dept_no
        and e.deptno = d.deptno
    group by d.deptno
    ]';
end budget_parametrized_vw;
/

SELECT *
FROM budget_parametrized_vw(10);

create or replace function row_sampler_polym_vw(
    i_tab dbms_tf.table_t,
    i_pct number default 10)
return varchar2 sql_macro(table)
as
begin
return  q'{
    select *
    from i_tab
    order by dbms_random.value
    fetch first i_pct percent rows only
    }';
end;
/

SELECT *
FROM row_sampler_polym_vw(i_tab=>emp, i_pct=>15);

WITH east_coast as (
    SELECT deptno
    FROM dept
    WHERE loc = 'BOSTON')
SELECT *
FROM row_sampler_polym_vw(east_coast);

-- Using SQL Macros (TABLE) to Return a Range

create or replace package gen is
    function grange(
        gstop number)
    return varchar2 sql_macro(table);

    function grange(
        gfirst number default 0,
        gstop  number,
        gstep  number default 1)
    return varchar2 sql_macro(table);
end gen;
/

create or replace package body gen is
    function grange(
        gstop number)
    return varchar2 sql_macro(table)
    is
    begin
    return q'{
        select * from (
            select level-1 n
            from dual connect by level<=gstop
        ) where gstop>0
    }';
    end;

    function grange(
        gfirst number default 0,
        gstop  number,
        gstep  number default 1)
    return varchar2 sql_macro(table)
    is
    begin
        return q'{
            select gfirst + n * gstep n
            from gen.grange(round((gstop-gfirst)/nullif(gstep,0)))
        }';
    end;

end gen;
/

select * from gen.grange(5);

select * from gen.grange(5,10);

select * from gen.grange(gfirst => 0, gstop=> 1, gstep=>0.1);

select * from gen.grange(5,-6,-2);

-- An example how to build hash keys for arbitrary table using SQL macro function. Hash keys are used in Data Vault 2.0 modelling approach. Two hash keys are added dynamically to the query result: one for the table key columns (given via parameter) and another for all table columns (used e.g. for comparing rows)

create or replace function add_hash_columns(
    t dbms_tf.table_t
    , key_cols dbms_tf.columns_t)
return varchar2 sql_macro
as
    v_hdiff      clob ;
    v_hkey       clob ;
    v_str        varchar2(200);
    v_delimiter  varchar2(9):= '||''#''||';
    v_name       dbms_id;
begin
    dbms_output.put_line('Called');
    for i in 1..t.column.count loop
        v_name := t.column(i).description.name;
        if t.column(i).description.type = dbms_tf.type_varchar2 then
            v_str := v_name;
        elsif t.column(i).description.type = dbms_tf.type_number then
            v_str := 'to_char('||v_name||')';
        elsif t.column(i).description.type = dbms_tf.type_date then
            v_str := 'to_char('||v_name||',''yyyymmdd'')';
        end if;

        v_hdiff := v_hdiff || v_delimiter || v_str;

        if v_name member of key_cols then
            v_hkey := v_hkey || v_delimiter || v_str;
        end if;
    end loop;

    v_hdiff := ltrim(v_hdiff,'|''#');
    v_hkey  := ltrim(v_hkey,'|''#');

    return 'select standard_hash('||v_hkey||',''md5'') hash_key, '||
    '       standard_hash('||v_hdiff||',''md5'') hash_diff, '||
    ' t.* from t';
end;
/

SELECT e.* FROM add_hash_columns (demo.emp, COLUMNS(empno)) e;
SELECT * FROM add_hash_columns (demo.emp, COLUMNS(empno));