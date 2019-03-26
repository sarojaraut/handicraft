CREATE OR REPLACE PACKAGE plsql_memory

IS
   PROCEDURE start_analysis;

   PROCEDURE show_usage;
END plsql_memory;
/

CREATE OR REPLACE PACKAGE BODY plsql_memory
IS
   g_pga_start   PLS_INTEGER;

   FUNCTION statval ( statname_in IN VARCHAR2 )
      RETURN NUMBER
   IS
      l_memory   PLS_INTEGER;
   BEGIN
      SELECT s.VALUE
        INTO l_memory
        FROM v$mystat s,
             v$statname n
       WHERE s. statistic# = n. statistic#
             AND n.name = statname_in;

      RETURN l_memory;
   END statval;

   PROCEDURE start_analysis
   IS
   BEGIN
      DBMS_SESSION.free_unused_user_memory;
      g_pga_start := statval ( 'session pga memory max');
   END start_analysis ;

   FUNCTION memory_usage
      RETURN INTEGER
   IS
      l_pga_usage   PLS_INTEGER;
   BEGIN
   
      l_pga_usage := statval ( 'session pga memory max');
      RETURN l_pga_usage - g_pga_start;

   END;

   PROCEDURE show_usage
   IS
   BEGIN
      DBMS_OUTPUT.put_line ( 'g_pga_start=' || g_pga_start);
      DBMS_OUTPUT.put_line ( 'PGA=' || memory_usage ());
   END;
END plsql_memory;
/

GRANT SELECT ON v$mystat TO orderactive;
GRANT SELECT ON v_$statname TO orderactive;

CREATE OR REPLACE PACKAGE plsql_memory_globals
IS
   TYPE strings_aat
   IS
      TABLE OF varchar2 (10000)
         INDEX BY pls_integer;

   g_list_of_strings   strings_aat;
END plsql_memory_globals;
/

SET SERVEROUTPUT ON;
SET TIMING ON;

DECLARE
   l_strings   plsql_memory_globals.strings_aat;

   PROCEDURE run_my_application
   IS
   BEGIN
      FOR i IN 1 .. 10000
      LOOP
         FOR j IN 1 .. 10
         LOOP
            l_strings (i + j * 100000 - 1) := TO_CHAR (i);

            plsql_memory_globals.g_list_of_strings (i + j * 100000 - 1) := TO_CHAR (i);
         END LOOP;
      END LOOP;
   END run_my_application;
BEGIN
   plsql_memory.start_analysis;
   run_my_application;
   plsql_memory.show_usage;
   
   plsql_memory_globals.g_list_of_strings.delete;
END plsql_memory_demo;
/

exec DBMS_SESSION.RESET_PACKAGE;