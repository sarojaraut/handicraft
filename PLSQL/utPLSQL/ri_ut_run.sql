CREATE OR REPLACE function ri_ut_run (
    i_package_name  in  varchar2,
	i_user_name     in  varchar2)
return number
is
    l_hdr_id    number;
	L_params    logger.tab_param;
begin

    l_hdr_id := ri_ut_tst_suite_hdr_seq.nextval;
	
	logger.append_param (L_params, 'i_package_name', i_package_name);   
	-- Logging Key variables   
	logger.append_param (L_params, 'i_user_name', i_user_name);
	logger.append_param (L_params, 'l_hdr_id', l_hdr_id);

	logger.log_info (
    p_text    => s_const.C_begin,
    p_scope  => 'ri_ut_run',
    p_params => l_params
    );
	
    insert all
    when rec_type='HDR' then
        into ri_ut_tst_suite_hdr
        (
            run_hdr_id,
            package_name,
            owner,
            suite_name,
            total_tests,
            skipped_tests,
            error_tests,
            failure_tests,
            elapsed_time,
            test_run_date
        )
        values
        (
            l_hdr_id,
            hdr_package_name,
            null,
            hdr_suite_name,
            hdr_total_tests,
            hdr_skipped,
            hdr_error,
            hdr_failure,
            hdr_time,
            sysdate
        )
    when rec_type='DTL' then
        into ri_ut_tst_suite_dtl
        (
            run_dtl_id,
            run_hdr_id,
            package_name,
            test_case_name,
            total_assertions,
            skipped_tests,
            error_tests,
            failure_tests,
            elapsed_time,
            test_status
        )
        values
        (
            ri_ut_tst_suite_dtl_seq.nextval,
            l_hdr_id,
            dtl_package_name,
            dtl_test_case_name,
            dtl_assertions,
            dtl_skipped,
            dtl_error,
            dtl_failure,
            dtl_time,
            dtl_status
        )
    with ut_output as
    (
    select
        case
            when column_value like '%<testsuite %'         then 'HDR'
            when column_value like '%<testcase classname%' then 'DTL'
            else 'OTHER'
        end case,
        column_value,
        '<testsuite tests="(.*)" id="(.*)" package="(.*)"  skipped="(.*)" error="(.*)" failure="(.*)" name="(.*)" time="(.*)" >'              hdr_format,
        '<testcase classname="(.*)"  assertions="(.*)" skipped="(.*)" error="(.*)" failure="(.*)" name="(.*)" time="(.*)" ( status="(.*)")?>' dtl_format
    from table(ut.run(i_user_name||'.'||i_package_name, ut_xunit_reporter()))
    where column_value like '%<testsuite %'
        or column_value like '%<testcase classname%'
    )
    select
        case as rec_type,
        regexp_replace(column_value, hdr_format, '\3') hdr_package_name,
        regexp_replace(column_value, hdr_format, '\7') hdr_suite_name,
        regexp_replace(column_value, hdr_format, '\1') hdr_total_tests,
        regexp_replace(column_value, hdr_format, '\4') hdr_skipped,
        regexp_replace(column_value, hdr_format, '\5') hdr_error,
        regexp_replace(column_value, hdr_format, '\6') hdr_failure,
        regexp_replace(column_value, hdr_format, '\8') hdr_time,
        regexp_replace(column_value, dtl_format, '\1') dtl_package_name,
        regexp_replace(column_value, dtl_format, '\6') dtl_test_case_name,
        regexp_replace(column_value, dtl_format, '\2') dtl_assertions,
        regexp_replace(column_value, dtl_format, '\3') dtl_skipped,
        regexp_replace(column_value, dtl_format, '\4') dtl_error,
        regexp_replace(column_value, dtl_format, '\5') dtl_failure,
        regexp_replace(column_value, dtl_format, '\7') dtl_time,
        regexp_replace(column_value, dtl_format, '\9') dtl_status
    from ut_output;
	
	logger.log_info (
    p_text    => s_const.C_end,
    p_scope  => 'ri_ut_run',
    p_params => l_params
    );

    return l_hdr_id;

exception
    when others then
		logger.log_error (
			p_text    => 'Error from ri_ut_run',
			p_scope  => 'ri_ut_run',
			p_params => l_params
			);
end;
/
