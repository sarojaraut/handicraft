SELECT
    'create or replace view '
    || ltrim(lower(table_name), 'c18_')
    || ' as '
    || CHR(13)
    || 'select '
    || CHR(13)
    || (
        SELECT
            listagg('    '
                    || rpad(lower(column_name), 32)
                    || ' as '
                    || column_name, ','||CHR(13))
        FROM
            user_tab_columns utc
        WHERE
            utc.table_name = ut.table_name
    )
    || CHR(13)
    || 'FROM '
    || table_name
    || ';'
FROM user_tables ut
WHERE table_name like 'C18_%';