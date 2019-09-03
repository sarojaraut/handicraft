create or replace function get_scenario_feedback
return blob
is
    l_file_id       number;
    l_excel         blob;
    l_stats         logger.tab_param := logger.gc_empty_tab_param;
    l_scope         varchar2(100) := $$plsql_unit;
begin
    logger.append_param(
        l_stats,
        'Start',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );
    dbms_lob.createtemporary( l_excel, true );

    as_xlsx.new_sheet( p_sheetname => 'scenario_feedback');
    as_xlsx.query2sheet( 
        p_sql => q'[
        SELECT           
            b.id scenario_id,
            d.username,
            d.full_name,
            a.followed_script,
            a.verified_spelling,
            a.summarised_grades,
            a.friendly,
            a.professional,
            a.clear,
            c.hash,
            a.comments,
            to_char(c.submission_date,'dd MON YYYY HH24:MI:SS') as submission_date,
            b.expected,
            c.status actual_outcome,
            a.referred,
            a.transferred,
            a.verified_grades_again,
            a.why_not,
            a.caller
        FROM   c19_test_feedback@webapps_owner_prd a
        LEFT JOIN  c19_test_scenario@webapps_owner_prd b
            ON a.scenario_id = b.id
        LEFT JOIN  c19_application@webapps_owner_prd c
            ON c.student_id = a.student_id
            AND  c.ucas_code = b.ucas_code
        LEFT JOIN  c19_user@webapps_owner_prd d
            ON d.username = c.submitted_by
        ORDER BY submission_date DESC
        ]', 
        p_sheet => 1);

    -- as_xlsx.new_sheet( p_sheetname => 'APPLICATION');
    -- as_xlsx.query2sheet( 
    --     p_sql => 'select * from c19_application', 
    --     p_sheet => 1);

    logger.append_param(
        l_stats,
        'scenario_feedback exported',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );

    l_excel := as_xlsx.finish;

    logger.append_param(
        l_stats,
        'Generated successfully',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );
    logger.append_param(
        l_stats,
        'End',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );
    return l_excel;
exception
    when others then
        logger.log_error(
            'Data generation failure',
            l_scope,
            null,
            l_stats
        );
    logger.append_param(
        l_stats,
        'Generation Error',
        dbms_utility.format_error_stack()
    );
    raise;
end;
/

create or replace function get_summary_feedback
return blob
is
    l_file_id       number;
    l_excel         blob;
    l_stats         logger.tab_param := logger.gc_empty_tab_param;
    l_scope         varchar2(100) := $$plsql_unit;
begin
    logger.append_param(
        l_stats,
        'Start',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );
    dbms_lob.createtemporary( l_excel, true );

    as_xlsx.new_sheet( p_sheetname => 'scenario_feedback');
    as_xlsx.query2sheet( 
        p_sql => q'[
            SELECT           
                d.username                                      as username,
                case 
                    when regexp_substr(full_name,'[^ ]+',1,6) is not null
                        then regexp_substr(d.full_name,'[^ ]+',1,5)||' '||regexp_substr(full_name,'[^ ]+',1,6)
                    else d.full_name
                end user_full_name,
                case 
                    when regexp_substr(full_name,'[^ ]+',1,3) is not null
                        then regexp_substr(d.full_name,'[^ ]+',1,2)||' '||regexp_substr(full_name,'[^ ]+',1,3)
                    else d.full_name
                end supervisor,
                ROUND(AVG(COALESCE(a.followed_script, 1)), 1)   as followed_script,
                ROUND(AVG(COALESCE(a.verified_spelling, 1)), 1) as verified_spelling,
                ROUND(AVG(COALESCE(a.summarised_grades, 1)), 1) as summarised_grades,
                ROUND(AVG(COALESCE(a.friendly, 1)), 1)          as friendly,
                ROUND(AVG(COALESCE(a.professional, 1)), 1)      as professional,
                ROUND(AVG(COALESCE(a.clear, 1)), 1)             as clear,
                count(8) total_feedbacks
            FROM  c19_test_feedback@webapps_owner_prd a
            LEFT JOIN c19_test_scenario@webapps_owner_prd b
                ON a.scenario_id = b.id
            LEFT JOIN c19_application@webapps_owner_prd c
                ON c.student_id = a.student_id
                AND c.ucas_code = b.ucas_code
            LEFT JOIN  c19_user@webapps_owner_prd d
            ON  d.username = c.submitted_by
            WHERE username IS NOT NULL
            GROUP BY 
                username, d.full_name
            ORDER BY user_full_name ASC
        ]', 
        p_sheet => 1);

    -- as_xlsx.new_sheet( p_sheetname => 'APPLICATION');
    -- as_xlsx.query2sheet( 
    --     p_sql => 'select * from c19_application', 
    --     p_sheet => 1);

    logger.append_param(
        l_stats,
        'scenario_feedback exported',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );

    l_excel := as_xlsx.finish;

    logger.append_param(
        l_stats,
        'Generated successfully',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );
    logger.append_param(
        l_stats,
        'End',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );
    return l_excel;
exception
    when others then
        logger.log_error(
            'Data generation failure',
            l_scope,
            null,
            l_stats
        );
    logger.append_param(
        l_stats,
        'Generation Error',
        dbms_utility.format_error_stack()
    );
    raise;
end get_summary_feedback;
/

select * from user_ords_schemas;

BEGIN
    ORDS.enable_schema(
        p_enabled             => TRUE,
        p_schema              => user,
        p_url_mapping_type    => 'BASE_PATH',
        p_url_mapping_pattern => 'api',
        p_auto_rest_auth      => FALSE
    );

    ORDS.define_module(
        p_module_name    => 'scenario_feedback',
        p_base_path      => 'scenarios/',
        p_items_per_page => 0);

    ORDS.define_template(
        p_module_name    => 'scenario_feedback',
        p_pattern        => 'feedback');

    ORDS.define_handler(
        p_module_name    => 'scenario_feedback',
        p_pattern        => 'feedback',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_plsql,
        p_source         => q'[
            DECLARE
                l_blob       blob;
                l_file_name  varchar2(100);
            BEGIN 
                l_blob := get_scenario_feedback;
                l_file_name := 'scenario_feedback_'||to_char(systimestamp AT TIME ZONE 'Europe/London','yyyy_mm_dd_hh24_mi_ss')||'.xlsx';

                    owa_util.mime_header('application/octet-stream', false);
                    htp.p('content-length: ' || dbms_lob.getlength(l_blob));
                    htp.p('content-disposition: filename="' || l_file_name || '"');
                    owa_util.http_header_close;

                    wpg_docload.download_file(l_blob);
            EXCEPTION
                WHEN OTHERS THEN
                :status := 404;
                :message := SQLERRM;
            END;
        ]',
        p_items_per_page => 0);

    ORDS.define_parameter(
        p_module_name        => 'scenario_feedback',
        p_pattern            => 'feedback',
        p_method             => 'GET',
        p_name               => 'X-ORDS-STATUS-CODE',   -- Available in 18.3
        p_bind_variable_name => 'status',
        p_source_type        => 'HEADER',
        p_access_method      => 'OUT'
        );

    ORDS.define_parameter(
        p_module_name        => 'scenario_feedback',
        p_pattern            => 'feedback',
        p_method             => 'GET',
        p_name               => 'message',
        p_bind_variable_name => 'message',
        p_source_type        => 'RESPONSE',
        p_access_method      => 'OUT'
        );
    --
    -- Summry Template
    --

    ORDS.define_template(
        p_module_name    => 'scenario_feedback',
        p_pattern        => 'summary-feedback');

    ORDS.define_handler(
        p_module_name    => 'scenario_feedback',
        p_pattern        => 'summary-feedback',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_plsql,
        p_source         => q'[
            DECLARE
                l_blob       blob;
                l_file_name  varchar2(100);
            BEGIN 
                l_blob := get_summary_feedback;
                l_file_name := 'summary_feedback_'||to_char(systimestamp AT TIME ZONE 'Europe/London','yyyy_mm_dd_hh24_mi_ss')||'.xlsx';

                    owa_util.mime_header('application/octet-stream', false);
                    htp.p('content-length: ' || dbms_lob.getlength(l_blob));
                    htp.p('content-disposition: filename="' || l_file_name || '"');
                    owa_util.http_header_close;

                    wpg_docload.download_file(l_blob);
            EXCEPTION
                WHEN OTHERS THEN
                :status := 404;
                :message := SQLERRM;
            END;
        ]',
        p_items_per_page => 0);

    ORDS.define_parameter(
        p_module_name        => 'scenario_feedback',
        p_pattern            => 'summary-feedback',
        p_method             => 'GET',
        p_name               => 'X-ORDS-STATUS-CODE',   -- Available in 18.3
        p_bind_variable_name => 'status',
        p_source_type        => 'HEADER',
        p_access_method      => 'OUT'
        );

    ORDS.define_parameter(
        p_module_name        => 'scenario_feedback',
        p_pattern            => 'summary-feedback',
        p_method             => 'GET',
        p_name               => 'message',
        p_bind_variable_name => 'message',
        p_source_type        => 'RESPONSE',
        p_access_method      => 'OUT'
        );

  COMMIT;
END;
/

-- http://localhost:38080/ords/api/scenarios/feedback
-- http://clr2ap0.unix2.test.city.ac.uk:8090/ords/api/scenarios/feedback
-- http://clr2ap0.unix2.test.city.ac.uk:8090/ords/api/scenarios/summary-feedback

create or replace function get_scenario_feedback
return blob
is
    l_file_id       number;
    l_excel         blob;
    l_stats         logger.tab_param := logger.gc_empty_tab_param;
    l_scope         varchar2(100) := $$plsql_unit;
begin
    logger.append_param(
        l_stats,
        'Start',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );
    dbms_lob.createtemporary( l_excel, true );

    as_xlsx.new_sheet( p_sheetname => 'scenario_feedback');
    as_xlsx.query2sheet( 
        p_sql => q'[
        select
            id
            ,scenario_id
            ,student_id
            ,caller
            ,followed_script
            ,verified_spelling
            ,summarised_grades
            ,friendly
            ,professional
            ,clear
            ,comments
            ,referred
            ,transferred
            ,verified_grades_again
            ,why_not
            ,to_char(submission_date,'dd MON YYYY HH24:MI:SS') as submission_date
        from c19_test_feedback@webapps_owner_prd
        ]', 
        p_sheet => 1);

    -- as_xlsx.new_sheet( p_sheetname => 'APPLICATION');
    -- as_xlsx.query2sheet( 
    --     p_sql => 'select * from c19_application', 
    --     p_sheet => 1);

    logger.append_param(
        l_stats,
        'scenario_feedback exported',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );

    l_excel := as_xlsx.finish;

    logger.append_param(
        l_stats,
        'Generated successfully',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );
    logger.append_param(
        l_stats,
        'End',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );
    return l_excel;
exception
    when others then
        logger.log_error(
            'Data generation failure',
            l_scope,
            null,
            l_stats
        );
    logger.append_param(
        l_stats,
        'Generation Error',
        dbms_utility.format_error_stack()
    );
    raise;
end;
/

SELECT           
    d.username                                      as username,
    d.full_name                                     as full_name,
    ROUND(AVG(COALESCE(a.followed_script, 1)), 1)   as followed_script,
    ROUND(AVG(COALESCE(a.verified_spelling, 1)), 1) as verified_spelling,
    ROUND(AVG(COALESCE(a.summarised_grades, 1)), 1) as summarised_grades,
    ROUND(AVG(COALESCE(a.friendly, 1)), 1)          as friendly,
    ROUND(AVG(COALESCE(a.professional, 1)), 1)      as professional,
    ROUND(AVG(COALESCE(a.clear, 1)), 1)             as clear
FROM  c19_test_feedback@webapps_owner_prd a
LEFT JOIN c19_test_scenario@webapps_owner_prd b
    ON a.scenario_id = b.id
LEFT JOIN c19_application@webapps_owner_prd c
    ON c.student_id = a.student_id
    AND c.ucas_code = b.ucas_code
LEFT JOIN  c19_user@webapps_owner_prd d
ON  d.username = c.submitted_by
WHERE username IS NOT NULL
GROUP BY username, full_name
ORDER BY full_name ASC;


SELECT           
    b.id scenario_id,
    d.username,
    d.full_name,
    a.followed_script,
    a.verified_spelling,
    a.summarised_grades,
    a.friendly,
    a.professional,
    a.clear,
    c.hash,
    a.comments,
    to_char(c.submission_date,'dd MON YYYY HH24:MI:SS') as submission_date,
    b.expected,
    c.status actual_outcome,
    a.referred,
    a.transferred,
    a.verified_grades_again,
    a.why_not,
    a.caller
FROM   c19_test_feedback@webapps_owner_prd a
LEFT JOIN  c19_test_scenario@webapps_owner_prd b
    ON a.scenario_id = b.id
LEFT JOIN  c19_application@webapps_owner_prd c
    ON c.student_id = a.student_id
    AND  c.ucas_code = b.ucas_code
LEFT JOIN  c19_user@webapps_owner_prd d
    ON d.username = c.submitted_by
ORDER BY submission_date DESC;






















create or replace function get_effective_summary
return blob
is
    l_file_id       number;
    l_excel         blob;
    l_stats         logger.tab_param := logger.gc_empty_tab_param;
    l_scope         varchar2(100) := $$plsql_unit;
begin
    logger.append_param(
        l_stats,
        'Start',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );
    dbms_lob.createtemporary( l_excel, true );

    as_xlsx.new_sheet( p_sheetname => 'scenario_feedback');
    as_xlsx.query2sheet( 
        p_sql => q'[select * from table(c19_get_effective_summary@webapps_owner_prd)]', 
        p_sheet => 1);

    -- as_xlsx.new_sheet( p_sheetname => 'APPLICATION');
    -- as_xlsx.query2sheet( 
    --     p_sql => 'select * from c19_application', 
    --     p_sheet => 1);

    logger.append_param(
        l_stats,
        'scenario_feedback exported',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );

    l_excel := as_xlsx.finish;

    logger.append_param(
        l_stats,
        'Generated successfully',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );
    logger.append_param(
        l_stats,
        'End',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );
    return l_excel;
exception
    when others then
        logger.log_error(
            'Data generation failure',
            l_scope,
            null,
            l_stats
        );
    logger.append_param(
        l_stats,
        'Generation Error',
        dbms_utility.format_error_stack()
    );
    raise;
end get_effective_summary;
/

-- http://clr2ap0.unix2.test.city.ac.uk:8090/ords/api/effective-summary/report
BEGIN
    ORDS.enable_schema(
        p_enabled             => TRUE,
        p_schema              => user,
        p_url_mapping_type    => 'BASE_PATH',
        p_url_mapping_pattern => 'api',
        p_auto_rest_auth      => FALSE
    );

    ORDS.define_module(
        p_module_name    => 'effective_summary',
        p_base_path      => 'effective-summary/',
        p_items_per_page => 0);

    ORDS.define_template(
        p_module_name    => 'effective_summary',
        p_pattern        => 'report');

    ORDS.define_handler(
        p_module_name    => 'effective_summary',
        p_pattern        => 'report',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_plsql,
        p_source         => q'[
            DECLARE
                l_blob       blob;
                l_file_name  varchar2(100);
            BEGIN 
                l_blob := get_effective_summary;
                l_file_name := 'effective_summary_'||to_char(sysdate,'yyyy_mm_dd_hh24_mi_ss')||'.xlsx';

                    owa_util.mime_header('application/octet-stream', false);
                    htp.p('content-length: ' || dbms_lob.getlength(l_blob));
                    htp.p('content-disposition: filename="' || l_file_name || '"');
                    owa_util.http_header_close;

                    wpg_docload.download_file(l_blob);
            EXCEPTION
                WHEN OTHERS THEN
                :status := 404;
                :message := SQLERRM;
            END;
        ]',
        p_items_per_page => 0);

    ORDS.define_parameter(
        p_module_name        => 'effective_summary',
        p_pattern            => 'report',
        p_method             => 'GET',
        p_name               => 'X-ORDS-STATUS-CODE',   -- Available in 18.3
        p_bind_variable_name => 'status',
        p_source_type        => 'HEADER',
        p_access_method      => 'OUT'
        );

    ORDS.define_parameter(
        p_module_name        => 'effective_summary',
        p_pattern            => 'report',
        p_method             => 'GET',
        p_name               => 'message',
        p_bind_variable_name => 'message',
        p_source_type        => 'RESPONSE',
        p_access_method      => 'OUT'
        );

  COMMIT;
END;
/

create or replace function get_submitted_by_stats
return blob
is
    l_file_id       number;
    l_excel         blob;
    l_stats         logger.tab_param := logger.gc_empty_tab_param;
    l_scope         varchar2(100) := $$plsql_unit;
begin
    logger.append_param(
        l_stats,
        'Start',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );
    dbms_lob.createtemporary( l_excel, true );

    as_xlsx.new_sheet( p_sheetname => 'user_stats');
    as_xlsx.query2sheet( 
        p_sql => q'[
            select
                submitted_by,
                u.full_name,
                offered,
                referred,
                rejected,
                invited,
                pooled,
                offered + referred + rejected + invited + pooled total_applications_handled
            from
            (
                select 
                    submitted_by,
                    offered,
                    referred,
                    rejected,
                    invited,
                    pooled,
                    offered + referred + rejected + invited + pooled total_applications_handled
                from (
                    select submitted_by, status
                    from c19_application@webapps_owner_prd 
                    where submitted_by <> 'public'
                    and submission_date < = sysdate
                    )
                pivot ( count(*)
                for status in (
                    'O' as offered
                    ,'R' as referred
                    ,'X' as rejected
                    ,'I' as invited
                    ,'P' as pooled
                    )
                )

            ) a
                join c19_user@webapps_owner_prd u
                    on (a.submitted_by = u.username)
                order by offered + referred + rejected + invited + pooled desc, offered desc
        ]', 
        p_sheet => 1);

    -- as_xlsx.new_sheet( p_sheetname => 'APPLICATION');
    -- as_xlsx.query2sheet( 
    --     p_sql => 'select * from c19_application', 
    --     p_sheet => 1);

    logger.append_param(
        l_stats,
        'submitted_by_stats exported',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );

    l_excel := as_xlsx.finish;

    logger.append_param(
        l_stats,
        'Generated successfully',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );
    logger.append_param(
        l_stats,
        'End',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );
    return l_excel;
exception
    when others then
        logger.log_error(
            'Data generation failure',
            l_scope,
            null,
            l_stats
        );
    logger.append_param(
        l_stats,
        'Generation Error',
        dbms_utility.format_error_stack()
    );
    raise;
end get_submitted_by_stats;
/

create or replace function get_updated_by_stats
return blob
is
    l_file_id       number;
    l_excel         blob;
    l_stats         logger.tab_param := logger.gc_empty_tab_param;
    l_scope         varchar2(100) := $$plsql_unit;
begin
    logger.append_param(
        l_stats,
        'Start',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );
    dbms_lob.createtemporary( l_excel, true );

    as_xlsx.new_sheet( p_sheetname => 'user_stats');
    as_xlsx.query2sheet( 
        p_sql => q'[
            select
                last_updated_by,
                u.full_name,
                offered,
                referred,
                rejected,
                invited,
                pooled,
                offered + referred + rejected + invited + pooled total_applications_handled
            from
            (
                select 
                    last_updated_by,
                    offered,
                    referred,
                    rejected,
                    invited,
                    pooled,
                    offered + referred + rejected + invited + pooled total_applications_handled
                from (
                    select last_updated_by, status
                    from c19_application@webapps_owner_prd 
                    where last_updated_by <> 'public'
                    and submission_date < = sysdate
                    )
                pivot ( count(*)
                for status in (
                    'O' as offered
                    ,'R' as referred
                    ,'X' as rejected
                    ,'I' as invited
                    ,'P' as pooled
                    )
                )

            ) a
                join c19_user@webapps_owner_prd u
                    on (a.last_updated_by = u.username)
                order by offered + referred + rejected + invited + pooled desc, offered desc
        ]', 
        p_sheet => 1);

    -- as_xlsx.new_sheet( p_sheetname => 'APPLICATION');
    -- as_xlsx.query2sheet( 
    --     p_sql => 'select * from c19_application', 
    --     p_sheet => 1);

    logger.append_param(
        l_stats,
        'submitted_by_stats exported',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );

    l_excel := as_xlsx.finish;

    logger.append_param(
        l_stats,
        'Generated successfully',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );
    logger.append_param(
        l_stats,
        'End',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );
    return l_excel;
exception
    when others then
        logger.log_error(
            'Data generation failure',
            l_scope,
            null,
            l_stats
        );
    logger.append_param(
        l_stats,
        'Generation Error',
        dbms_utility.format_error_stack()
    );
    raise;
end get_updated_by_stats;
/

-- http://clr2ap0.unix2.test.city.ac.uk:8090/ords/api/userstats/submitted-by
-- http://clr2ap0.unix2.test.city.ac.uk:8090/ords/api/userstats/last-updated-by

BEGIN
    ORDS.enable_schema(
        p_enabled             => TRUE,
        p_schema              => user,
        p_url_mapping_type    => 'BASE_PATH',
        p_url_mapping_pattern => 'api',
        p_auto_rest_auth      => FALSE
    );

    ORDS.define_module(
        p_module_name    => 'user_stats',
        p_base_path      => 'userstats/',
        p_items_per_page => 0);

    ORDS.define_template(
        p_module_name    => 'user_stats',
        p_pattern        => 'submitted-by');

    ORDS.define_handler(
        p_module_name    => 'user_stats',
        p_pattern        => 'submitted-by',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_plsql,
        p_source         => q'[
            DECLARE
                l_blob       blob;
                l_file_name  varchar2(100);
            BEGIN 
                l_blob := get_submitted_by_stats;
                l_file_name := 'user_submitted_by_stats_'||to_char(systimestamp AT TIME ZONE 'Europe/London','yyyy_mm_dd_hh24_mi_ss')||'.xlsx';

                    owa_util.mime_header('application/octet-stream', false);
                    htp.p('content-length: ' || dbms_lob.getlength(l_blob));
                    htp.p('content-disposition: filename="' || l_file_name || '"');
                    owa_util.http_header_close;

                    wpg_docload.download_file(l_blob);
            EXCEPTION
                WHEN OTHERS THEN
                :status := 404;
                :message := SQLERRM;
            END;
        ]',
        p_items_per_page => 0);

    ORDS.define_parameter(
        p_module_name        => 'user_stats',
        p_pattern            => 'submitted-by',
        p_method             => 'GET',
        p_name               => 'X-ORDS-STATUS-CODE',   -- Available in 18.3
        p_bind_variable_name => 'status',
        p_source_type        => 'HEADER',
        p_access_method      => 'OUT'
        );

    ORDS.define_parameter(
        p_module_name        => 'user_stats',
        p_pattern            => 'submitted-by',
        p_method             => 'GET',
        p_name               => 'message',
        p_bind_variable_name => 'message',
        p_source_type        => 'RESPONSE',
        p_access_method      => 'OUT'
        );
    --
    -- Summry Template
    --
    ORDS.define_template(
        p_module_name    => 'user_stats',
        p_pattern        => 'last-updated-by');

    ORDS.define_handler(
        p_module_name    => 'user_stats',
        p_pattern        => 'last-updated-by',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_plsql,
        p_source         => q'[
            DECLARE
                l_blob       blob;
                l_file_name  varchar2(100);
            BEGIN 
                l_blob := get_updated_by_stats;
                l_file_name := 'user_last_updated_by_stats_'||to_char(systimestamp AT TIME ZONE 'Europe/London','yyyy_mm_dd_hh24_mi_ss')||'.xlsx';

                    owa_util.mime_header('application/octet-stream', false);
                    htp.p('content-length: ' || dbms_lob.getlength(l_blob));
                    htp.p('content-disposition: filename="' || l_file_name || '"');
                    owa_util.http_header_close;

                    wpg_docload.download_file(l_blob);
            EXCEPTION
                WHEN OTHERS THEN
                :status := 404;
                :message := SQLERRM;
            END;
        ]',
        p_items_per_page => 0);

    ORDS.define_parameter(
        p_module_name        => 'user_stats',
        p_pattern            => 'last-updated-by',
        p_method             => 'GET',
        p_name               => 'X-ORDS-STATUS-CODE',   -- Available in 18.3
        p_bind_variable_name => 'status',
        p_source_type        => 'HEADER',
        p_access_method      => 'OUT'
        );

    ORDS.define_parameter(
        p_module_name        => 'user_stats',
        p_pattern            => 'last-updated-by',
        p_method             => 'GET',
        p_name               => 'message',
        p_bind_variable_name => 'message',
        p_source_type        => 'RESPONSE',
        p_access_method      => 'OUT'
        );

  COMMIT;
END;
/

