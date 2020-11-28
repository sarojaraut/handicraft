

-- 1. The DBMS_ERRLOG package provides a procedure that enables you to create an error logging table so that DML operations can continue after encountering errors rather than abort and roll back. 

DBMS_ERRLOG.CREATE_ERROR_LOG (
    dml_table_name            IN VARCHAR2,
    err_log_table_name        IN VARCHAR2 := NULL, -- The default is the first 25 characters in the name of the DML table prefixed with 'ERR$_'.
    err_log_table_owner       IN VARCHAR2 := NULL,
    err_log_table_space       IN VARCHAR2 := NULL,
    skip_unsupported          IN BOOLEAN  := FALSE -- LONG, CLOB, BLOB, BFILE, and ADT datatypes are not supported in the columns. When set to FALSE, an unsupported column type will cause the procedure to terminate.
);

-- This creates error log table with following extra columns
ORA_ERR_MESG$                              VARCHAR2(2000)
ORA_ERR_ROWID$                             ROWID
ORA_ERR_OPTYP$                             VARCHAR2(2)
ORA_ERR_TAG$                               VARCHAR2(2000)


--controlled operation with defined reject limit
INSERT INTO TARGET_TABLE
SELECT *
FROM   SOURCE_TABLE
LOG ERRORS INTO ERR$_TARGET_TABLE ('TEST_INSERT') REJECT LIMIT UNLIMITED;

SELECT ora_err_number$, ora_err_mesg$
FROM   ERR$_TARGET_TABLE
WHERE  ora_err_tag$ = 'TEST_INSERT';


-- 2. Compilation error if you specify when others before any specific exception e.g no_data_found

--Partition 

-- Misc with data as ( 
    select 'MONDAY' val 
    from dual)
select regexp_substr(val,'[A-Z]{1}',1,rownum) letter_by_letter
from data
connect by rownum <= length(val);
-- Flip the position of two parameters 1, rownum as above query and use stbstring 
with data as ( 
    select 'MONDAY' val 
    from dual)
select substr(val,rownum, 1) letter_by_letter
from data
connect by rownum <= length(val);
--substr will be more efficient for this use case but regexp will be more powerful for handling other complex scenarios

with json as ( 
select 
    treat( '[{"key1":"val1"},{"key2":"val2"}]' as json) val 
from dual)
, decomposed_json as(
select 
    json_value(s.val,'$[*].key1') key1 ,
    json_value(s.val,'$[*].key2') key2
from json s)
select * from decomposed_json;
--
--