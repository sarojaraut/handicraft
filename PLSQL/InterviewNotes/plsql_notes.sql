

-- Stefen Notes
Complex data structures (collections, objects, records) can take up substantial amounts of memory.
Analyze PGA/UGA through v$ dynamic views
– Obtain "session pga memory" information from v_$sesstat.
Elements of PL/SQL that affect memory usage:
–  BULK COLLECT limit clause 
–  The NOCOPY hint 
–  Packaged variables
–  DBMS_SESSION programs: free_unused_user_memory, reset_package and modify_package_state

Take advantage of PL/SQL-specific enhancements for SQL.
– BULK COLLECT and FORALL, cursor variables, table functions

Things to be aware of: FORALL
– You MUST know how to use collections to use this feature!
– Only a single DML statement is allowed per FORALL.
– SQL%BULK_ROWCOUNT returns the number of rows affected by each row in the binding array.
– Prior to Oracle10g, the binding array must be sequentially filled.
– Use SAVE EXCEPTIONS to continue past errors.

OPEN three_cols_cur;
LOOP
FETCH emps_in_dept_cur BULK COLLECT INTO emps LIMIT 100;

EXIT WHEN emps.COUNT = 0;


Use the LIMIT clause with the INTO to manage the amount of memory used with the BULK COLLECT operation.
BULK COLLECT will not raise NO_DATA_FOUND if no rows are found. Best to check contents of collection to confirm that something was retrieved.

how do you return multiple rows?
– Collection - use BULK COLLECT, Can do so in package specification or even as a schema level object.
– Cursor variable - especially handy when returning data to a non-PL/SQL host environment. Uses the OPEN...FOR statement to associate the variable with a query.

 Sometimes you need to return multiple rows of data that are the result of a complex transformation.
– Canot fit it all (easily) into a SELECT statement.  Table functions to the rescue!
– A table function is a function that returns a collection and can be called in the FROM clause of a query.
– Combine with cursor variables to return these datasets through a function interface.
Whenever possible, use anchored declarations rather than explicit datatype references %TYPE for scalar structures %ROWTYPE for composite structures
 Use SUBTYPEs for programmatically-defined types SUBTYPE emp_allrows_rt IS emp%ROWTYPE;
Always Fetch into Cursor Records, Fetching into individual variables hard-codes number of items in select list. Fetching into a record means writing less code.


Manage errors effectively and consistently

Case block without else will through case_not_found if none of the when clauses catches the scenario

The EXCEPTION is a limited type of data.
– Has just two attributes: code and message.
– You can RAISE and handle an exception, but it cannot be passed as an argument in a program.

is
  bulk_errors  EXCEPTION;
  PRAGMA EXCEPTION_INIT (bulk_errors, -24381);
begin 
..


RAISE raises the specified exception by name.
– RAISE; re-raises current exception. Callable only within the exception section.

RAISE_APPLICATION_ERROR  Communicates an application specific error back to a non-PL/SQL host environment.
– Error numbers restricted to the -20,999 - -20,000 range.
RAISE_APPLICATION_ERROR (error_number, error_message);
RAISE_APPLICATION_ERROR (error_number, error_message, keep_errors); --keep_errors default false, true means keeps error stack including line number



The EXCEPTION section consolidates all error handling logic in a block. But only traps errors raised in the executable section of the block.
Several useful functions usually come into play:
– SQLCODE and SQLERRM
– DBMS_UTILITY.FORMAT_ERROR_STACK
– DBMS_UTILITY.FORMAT_ERROR_BACKTRACE
The DBMS_ERRLOG package
– Quick and easy logging of DML errors
The AFTER SERVERERROR trigger
– Instance-wide error handling

Find line number on which error was raised with DBMS_UTILITY.FORMAT_ERROR_BACKTRACE
– Introduced in Oracle10g Release 2, this function returns the full stack of errors with line number information.
– Formerly, this stack was available only if you let the error go unhandled.


DBMS_ERRLOG : Allows DML statements to execute against all rows, even if an error occurs. Much faster than trapping errors, logging, and then continuing/recovering.
FORALL with SAVE EXCEPTIONS offers similar capabilities.

DML statements generally are not rolled back when an exception is raised. This gives you more control over your transaction.
Rollbacks occur with...
– Unhandled exception from the outermost PL/SQL block;
– Exit from autonomous transaction without commit/rollback;
– Other serious errors, such as "Rollback segment too small".

Readability features you should use : 
END labels – For program units, loops, nested blocks
SUBTYPEs – Create application-specific datatypes!
Overloading, aka, "static polymorphism", occurs when 2 or more programs in the same scope have the same name.
Benefits of overloading include... – Improved usability of package: users have to remember fewer names, overloadings anticipate different kinds of usages.

The initialization section:
– Is defined after and outside of any programs in the package.
– Is not required. In fact, most packages you build wont have one. 
– Can have exception handling section.

Dynamic SQL 
Starting with 11g, a CLOB can be passed as an input parameter. Before that the limit was 32K

v_sql_tx:='SELECT lov_item_t '||
'FROM (SELECT lov_t(' ||
dbms_assert.simple_sql_name(i_id_tx)||', '||
dbms_assert.simple_sql_name(i_display_tx)||') lov_item_t '||
' FROM '||dbms_assert.simple_sql_name(i_table_tx)||
' order by '||dbms_assert.simple_sql_name(i_order_nr)||
')' ||
' WHERE ROWNUM <= :limit';
EXECUTE IMMEDIATE v_sql_tx BULK COLLECT INTO v_out_tt USING i_limit_nr;
RETURN v_out_tt;

The DBMS_ASSERT package helps prevent code injections by enforcing the rule that table and column names are “simple SQL names” (no spaces, no separation symbols, etc.)
One major limitation of EXECUTE IMMEDIATE. It is a single PARSE/EXECUTE/FETCH sequence of events that cannot be stopped or paused. As a result, in cases of multi-row fetching via BULK COLLECT we need to use dynamic cursor 

Drwbacks of DYnamic SQL : Security, performance, lose track of dependencies(some times having dependencies is not a good thing, e.g. ), 


Cursors are memory areas where the Oracle platform executes SQL statements. 
Any given PL/SQL block issues an implicit cursor whenever an SQL statement is executed, as long as an explicit cursor does not exist for that SQL statement.
The implicit cursor is used to process INSERT, UPDATE, DELETE, and SELECT INTO statements. During the processing of an implicit cursor, the Oracle platform automatically performs the OPEN, FETCH, and CLOSE operations.
The most recently opened cursor is called the “SQL” cursor. SQL%ROWCOUNT
Unlike an implicit cursor, an explicit cursor is defined by the program for any query that returns more than one row of data. First you declare a cursor. Second, you open an earlier declared cursor. Third, you fetch the earlier declared and opened cursor. Finally, you close the cursor.

%NOTFOUND, %FOUND, %ROWCOUNT, %ISOPEN
The attribute %ROWCOUNT then returns a number, which is the current row number of the cursor.


CURSOR c_cursor_name IS select statement

CURSOR c_student is
SELECT first_name||’ ’||Last_name name
FROM student;
vr_student c_student%ROWTYPE;

OPEN c_student;
LOOP
FETCH c_student INTO vr_student;
EXIT WHEN c_student_name%NOTFOUND;
END LOOP;

CLOSE cursor_name;

FOR r_student IN c_student
LOOP
INSERT INTO table_log
VALUES(r_student.last_name);
END LOOP;

-- Cursor parameters make the cursor more reusable. The mode of the parameters can only be IN.


CURSOR c_zip (p_state IN zipcode.state%TYPE) IS
SELECT zip, city, state
FROM zipcode
WHERE state = p_state;

FOR r_zip IN c_zip(‘NY’)
LOOP ...

CURSOR c_course IS
SELECT course_no, cost
FROM course FOR UPDATE;

UPDATE student
SET phone = ‘718’||SUBSTR(phone,4)
WHERE CURRENT OF c_stud_zip;

TYPE student_cur_type IS REF CURSOR;
student_cur student_cur_type;

OPEN student_cur FOR
‘SELECT first_name, last_name FROM student ‘||‘WHERE zip = :1’
USING v_zip;


--Trigger
A database trigger is a named PL/SQL block that is stored in a database and executed implicitly when a triggering event occurs. 
CREATE [OR REPLACE] [EDITIONABLE|NONEDITIONABLE] TRIGGER trigger_name
{BEFORE|AFTER} triggering_event ON table_name
[FOR EACH ROW]
[FOLLOWS|PRECEDES another_trigger]
[ENABLE/DISABLE]
[WHEN condition]
DECLARE
Declaration statements
BEGIN
Executable statements
EXCEPTION
Exception-handling statements
END;

maintain complex security rules, comples business rules, preventing invalid transactions, audit 

A trigger may not issue a transactional control statement such as COMMIT, SAVEPOINT, or ROLLBACK. When the trigger fires, all operations performed by the trigger become part of a transaction. When a transaction is committed or rolled back, the operations performed by the trigger are committed or rolled back as well. An exception to this rule is a trigger that contains an autonomous transaction.

dropping table drops triggers as well. 
We can use pseudorecord, :NEW, :OLD to access old and new values. 

A compound trigger allows you to combine different types of triggers into one trigger.
Specifically, you are able to combine
A statement trigger that fires before the firing statement
A row trigger that fires before each row that the firing statement affects
A row trigger that fires after each row that the firing statement affects
A statement trigger that fires after the firing statement

CREATE [OR REPLACE] TRIGGER trigger_name
triggering_event ON table_name
COMPOUND TRIGGER
Declaration Statements
BEFORE STATEMENT IS
BEGIN
Executable statements

BEFORE EACH ROW IS
BEGIN
Executable statements

END BEFORE EACH ROW;
AFTER EACH ROW IS
BEGIN
Executable statements

END AFTER EACH ROW;
AFTER STATEMENT IS
BEGIN
Executable statements

END AFTER STATEMENT;
END;

References to :OLD and :NEW pseudocolumns cannot appear in the
declaration, BEFORE STATEMENT, and AFTER STATEMENT sections.
The value of the :NEW pseudocolumn can be changed in the BEFORE EACH
ROW section only.
The firing order of the compound and simple triggers is not guaranteed. In
other words, the firing of the compound trigger may interleave with the firing
of the simple triggers.


Bulk Operation 
declare 
  errors EXCEPTION;
  PRAGMA EXCEPTION_INIT(errors, -24381);
begin
  FORALL i IN 1..10 SAVE EXCEPTIONS
  INSERT INTO test (row_num, row_text)
  VALUES (row_num_tab(i), row_text_tab(i));
exception 
  when errors 
  DBMS_OUTPUT.PUT_LINE ('There were '||SQL%BULK_EXCEPTIONS.COUNT||'exceptions');
  FOR i in 1.. SQL%BULK_EXCEPTIONS.COUNT LOOP
  DBMS_OUTPUT.PUT_LINE ('Record '||
    SQL%BULK_EXCEPTIONS(i).error_index||' caused error '||i||': '||
    SQL%BULK_EXCEPTIONS(i).error_code||' '||
    SQLERRM(-SQL%BULK_EXCEPTIONS(i).error_code));
  END LOOP;
end;

for sparse collection we can use FORALL i IN INDICES OF row_num_tab

OPEN student_cur;
LOOP
— Fetch 50 rows at once
FETCH student_cur BULK COLLECT INTO student_tab LIMIT v_limit;
EXIT WHEN student_tab.COUNT = 0;

DBMS_PROFILER.START_PROFILER (‘Optimizer level at 2’);
-- call the process
DBMS_PROFILER.STOP_PROFILER();

SELECT r.runid, r.run_comment, d.line#, d.total_occur, d.total_time
FROM 
  plsql_profiler_runs r
  ,plsql_profiler_data d
  ,plsql_profiler_units u
WHERE r.runid = d.runid
AND d.runid = u.runid
AND d.unit_number = u.unit_number
AND d.total_occur > 0
ORDER BY d.runid, d.line#;

The PL/SQL Hierarchical Profiler is implemented via the DBMS_HPROF package. It profiles the execution of PL/SQL applications and reports on the execution times for SQL 
and PL/SQL separately. 
