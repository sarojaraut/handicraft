CREATE OR REPLACE PACKAGE ri_plsql_standard IS
    --
    --Variables
    --
    gc_local_variable_name   CONSTANT VARCHAR2(30) := 'l\_%';
    gc_package_variable_name CONSTANT VARCHAR2(30) := 'g\_%';
    gc_record_variable_name  CONSTANT VARCHAR2(30) := '%';
    gc_iterator_name         CONSTANT VARCHAR2(30) := 'l_%';
    --
    -- Constants
    --
    gc_local_constant_name  CONSTANT VARCHAR2(30) := 'lc\_%';
    gc_global_constant_name CONSTANT VARCHAR2(30) := 'gc\_%';
    --
    -- Parameters
    --
    gc_in_parameter_name     CONSTANT VARCHAR2(30) := 'p\_%';
    gc_out_parameter_name    CONSTANT VARCHAR2(30) := 'x\_%';
    gc_in_out_parameter_name CONSTANT VARCHAR2(30) := 'x\_%';
    gc_cursor_parameter_name CONSTANT VARCHAR2(30) := 'cp\_%';
    --
    -- Cursors
    --
    gc_local_cursor_name  CONSTANT VARCHAR2(30) := 'c\_%';
    gc_global_cursor_name CONSTANT VARCHAR2(30) := 'c\_%';
    --
    -- Procedures/Functions
    --
    gc_procedure_name CONSTANT VARCHAR2(30) := '%';
    gc_function_name  CONSTANT VARCHAR2(30) := '%';
    --
    -- Exception
    --
    gc_local_exception_name  CONSTANT VARCHAR2(30) := 'e\_%';
    gc_global_exception_name CONSTANT VARCHAR2(30) := 'ge\_%';
    --
    -- Types
    --
    gc_sub_type_name   CONSTANT VARCHAR2(30) := 'st%';
    gc_table_type_name CONSTANT VARCHAR2(30) := '%/_tab_type';

    PROCEDURE check_code(p_package_name_filter IN VARCHAR2);

END ri_plsql_standard;
/

CREATE OR REPLACE PACKAGE BODY ri_plsql_standard IS

    TYPE g_result_rec_type IS RECORD(
        package_name    user_identifiers.object_name%TYPE,
        identifier_name user_identifiers.NAME%TYPE,
        check_type      VARCHAR2(50),
        line            NUMBER,
        TYPE            user_identifiers.TYPE%TYPE,
        parent_type     user_identifiers.TYPE%TYPE,
        valid           VARCHAR2(1));

    TYPE g_result_tab_type IS TABLE OF g_result_rec_type INDEX BY BINARY_INTEGER;
    g_result_tab g_result_tab_type;
    --
    --
    PROCEDURE log(p_line IN VARCHAR2) IS
    BEGIN
        dbms_output.put_line(p_line);
    END log;
    --
    --
    PROCEDURE recompile_package(p_package_name IN VARCHAR2) IS
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET PLSCOPE_SETTINGS=''IDENTIFIERS:ALL''';
        EXECUTE IMMEDIATE 'ALTER PACKAGE ' || p_package_name || ' COMPILE ';

        log('Recompiled ' || p_package_name);
    END recompile_package;
    --
    --
    PROCEDURE check_names(
        p_check_type   IN VARCHAR2,
        p_package_name IN VARCHAR2,
        p_type         IN VARCHAR2,
        p_format       IN VARCHAR2,
        p_scope        IN VARCHAR2 DEFAULT 'LOCAL',
        p_usage        IN VARCHAR2 DEFAULT 'DECLARATION') 
    IS
        CURSOR c_identifiers(p_type IN VARCHAR2) IS 
        WITH identifiers_inline AS(
            SELECT NAME,
                line,
                TYPE,
                (
                    SELECT TYPE
                    FROM user_identifiers
                    WHERE object_name = p_package_name
                        AND object_type = ide.object_type
                        AND usage_id = ide.usage_context_id
                )  parent_type
            FROM user_identifiers ide
            WHERE object_name = p_package_name
                AND usage = p_usage
                AND TYPE = p_type
        )
        SELECT NAME,
            line,
            parent_type,
            TYPE
        FROM identifiers_inline
        WHERE (
            (
                p_scope = 'LOCAL' 
                AND parent_type IN ('FUNCTION', 'PROCEDURE')
            ) 
            OR (p_scope = parent_type) 
            OR (p_scope = 'ALL')
        )
        ORDER BY line;

        l_index NUMBER;
    BEGIN


    l_index := g_result_tab.COUNT;
    FOR r_identifier IN c_identifiers(p_type)
    LOOP
        l_index := l_index + 1;
        g_result_tab(l_index).package_name    := p_package_name;
        g_result_tab(l_index).identifier_name := r_identifier.NAME;
        g_result_tab(l_index).check_type      := p_check_type;
        g_result_tab(l_index).TYPE            := r_identifier.TYPE;
        g_result_tab(l_index).parent_type     := r_identifier.parent_type;
        g_result_tab(l_index).line            := r_identifier.line;

        IF upper(r_identifier.NAME) NOT LIKE upper(p_format)  ESCAPE '\'
        THEN
            g_result_tab(l_index).valid := 'N';
        ELSE
            g_result_tab(l_index).valid := 'Y';
        END IF;
    END LOOP;
    END check_names;
    --
    --
    --
    PROCEDURE check_code(p_package_name IN VARCHAR2) 
    IS
    BEGIN
        --recompile_package(p_package_name => p_package_name);

        check_names(p_check_type   => 'Local Variable',
                    p_package_name => p_package_name,
                    p_type         => 'VARIABLE',
                    p_format       => gc_local_variable_name,
                    p_scope        => 'LOCAL');

        check_names(p_check_type   => 'Global Variable',
                    p_package_name => p_package_name,
                    p_type         => 'VARIABLE',
                    p_format       => gc_package_variable_name,
                    p_scope        => 'PACKAGE');

        check_names(p_check_type   => 'Record Variable',
                    p_package_name => p_package_name,
                    p_type         => 'VARIABLE',
                    p_format       => gc_record_variable_name,
                    p_scope        => 'RECORD');

        check_names(p_check_type   => 'Iterator',
                    p_package_name => p_package_name,
                    p_type         => 'ITERATOR',
                    p_format       => gc_iterator_name);

        check_names(p_check_type   => 'Parameter In',
                    p_package_name => p_package_name,
                    p_type         => 'FORMAL IN',
                    p_format       => gc_in_parameter_name);

        check_names(p_check_type   => 'Parameter Out',
                    p_package_name => p_package_name,
                    p_type         => 'FORMAL OUT',
                    p_format       => gc_out_parameter_name);

        check_names(p_check_type   => 'Parameter In Out',
                    p_package_name => p_package_name,
                    p_type         => 'FORMAL IN OUT',
                    p_format       => gc_in_out_parameter_name);
        check_names(p_check_type   => 'Cursor Parameter',
                    p_package_name => p_package_name,
                    p_type         => 'FORMAL IN',
                    p_format       => gc_cursor_parameter_name,
                    p_scope        => 'CURSOR');

        check_names(p_check_type   => 'Local Constant',
                    p_package_name => p_package_name,
                    p_type         => 'CONSTANT',
                    p_format       => gc_local_constant_name,
                    p_scope        => 'LOCAL');

        check_names(p_check_type   => 'Global Constant',
                    p_package_name => p_package_name,
                    p_type         => 'CONSTANT',
                    p_format       => gc_global_constant_name,
                    p_scope        => 'PACKAGE');

        check_names(p_check_type   => 'Local Cursor',
                    p_package_name => p_package_name,
                    p_type         => 'CURSOR',
                    p_format       => gc_local_cursor_name,
                    p_scope        => 'LOCAL');

        check_names(p_check_type   => 'Global Cursor',
                    p_package_name => p_package_name,
                    p_type         => 'CURSOR',
                    p_format       => gc_global_cursor_name,
                    p_scope        => 'PACKAGE');

        check_names(p_check_type   => 'Procedure',
                    p_package_name => p_package_name,
                    p_type         => 'PROCEDURE',
                    p_format       => gc_procedure_name,
                    p_usage        => 'DEFINITION',
                    p_scope        => 'ALL');

        check_names(p_check_type   => 'Function',
                    p_package_name => p_package_name,
                    p_type         => 'FUNCTION',
                    p_format       => gc_function_name,
                    p_usage        => 'DEFINITION',
                    p_scope        => 'ALL');

        check_names(p_check_type   => 'Local Exception',
                    p_package_name => p_package_name,
                    p_type         => 'EXCEPTION',
                    p_format       => gc_local_exception_name,
                    p_scope        => 'LOCAL');

        check_names(p_check_type   => 'Global Exception',
                    p_package_name => p_package_name,
                    p_type         => 'EXCEPTION',
                    p_format       => gc_global_exception_name,
                    p_scope        => 'PACKAGE');

        check_names(p_check_type   => 'Sub Type',
                    p_package_name => p_package_name,
                    p_type         => 'SUBTYPE',
                    p_format       => gc_sub_type_name,
                    p_scope        => 'ALL');

        check_names(p_check_type   => 'Table Type (Nested)',
                    p_package_name => p_package_name,
                    p_type         => 'NESTED TABLE',
                    p_format       => gc_table_type_name,
                    p_scope        => 'ALL');

        check_names(p_check_type   => 'Table Type (Index)',
                    p_package_name => p_package_name,
                    p_type         => 'INDEX TABLE',
                    p_format       => gc_table_type_name,
                    p_scope        => 'ALL');

    END check_code;
    ------------------------------------------------------------------------
    PROCEDURE check_code(p_package_name_filter IN VARCHAR2) IS
        CURSOR c_objects IS
            SELECT object_name package_name
            FROM all_objects
            WHERE object_name LIKE p_package_name_filter
            AND object_type = 'PACKAGE';

        l_valid VARCHAR2(30);
    BEGIN
        g_result_tab .DELETE();
        FOR rec IN c_objects
        LOOP
            check_code(p_package_name => rec.package_name);
        END LOOP;

    log('Record count :-' || g_result_tab.COUNT);
    --
    -- Change DBMS OUTPUT to store in a table.
    --
    FOR i IN 1 .. g_result_tab.COUNT
    LOOP
        SELECT decode(g_result_tab(i).valid,
                   
                    'Y',
                    'Valid',
                    'Invalid')
        INTO l_valid
        FROM dual;
        log('Package ' || g_result_tab(i).package_name || ' - Line ' || g_result_tab(i).line || ' ' || g_result_tab(i).check_type || ' name ' || g_result_tab(i)
          .identifier_name || ' --> ' || l_valid);
    END LOOP;

    END check_code;
END ri_plsql_standard;
/

set serveroutput on;
set linesize 150;

exec ri_plsql_standard.check_code('ri_plsql_standard');

--http://www.oracle.com/technetwork/articles/grid/o50plsql-165471.html


