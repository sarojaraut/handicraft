LOAD DATA
APPEND INTO TABLE EMP_NEW
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
(
EMPNO   CHAR,
ENAME   char,
JOB     char,
MGR     char,
HIREDATE date 'dd-mm-yyyy',
SAL     char,
COMM    char,
DEPTNO  char
)

-- sqlldr userid=scott/tiger@ocp11g control=emp.ctl file=emp.csv