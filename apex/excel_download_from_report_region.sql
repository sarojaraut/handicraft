declare
    l_context               apex_exec.t_context;
    l_region_id             number;
    l_print_config          apex_data_export.t_print_config;
    l_export                apex_data_export.t_export;
    l_columns               apex_data_export.t_columns;
    l_app_id                number := :APP_ID;
    l_page_id               number := :APP_PAGE_ID;
    l_column_mapping         varchar2(4000) :=
            '[
                {
                    "columnName": "REP_LOGIN",
                    "heading": "LOGIN"
                },
                {
                    "columnName": "REP_NAME",
                    "heading": "Name"
                }, 
                {
                    "columnName": "EMP_NUM",
                    "heading": "Emp Number"
                },

                {
                    "columnName": "CURRENCY_SYMBOL",
                    "heading": "Currency"
                },
                {
                    "columnName": "LOCAL_PAYBLE_AMT",
                    "heading": "Amount",
                    "formatter":"999G999G999G999G990D00"
                },
                {
                    "columnName": "USD_PAYBLE_AMT",
                    "heading": "Amount$",
                    "formatter":"FML999G999G999G999G990D00"
                },
                {
                    "columnName": "PERIOD_MON_YY",
                    "heading": "Period"
                }
            ]';

begin
    --:TODO needs further refinement to show error message
    -- if status for any selected employee is less than CFO approved
    l_region_id := apex_region.get_id(
        p_application_id => l_app_id,
        p_page_id        => l_page_id,
        -- p_name           => 'Commissions'
        p_dom_static_id  => 'comm' 
        );

    l_context := apex_region.open_query_context (
        p_page_id => l_page_id,
        p_region_id => l_region_id
    );
        
    for i in (
        select columnName, heading, formatter
        from dual,
            json_table(
                l_column_mapping,
                '$[*]'
                columns(
                    columnName  path '$.columnName',
                    heading     path '$.heading',
                    formatter   path '$.formatter'
                )
            )
    )
    loop
        apex_data_export.add_column(
            p_columns             => l_columns,
            p_name                => i.columnName,
            p_heading             => i.heading,
            p_format_mask         => i.formatter
        );
    end loop;

    l_print_config := apex_data_export.get_print_config(
        p_header_bg_color       => '#0070C0', -- Blue Background
        p_header_font_color     => '#FFFFFF', -- White Text
        p_header_font_weight    => apex_data_export.c_font_weight_bold,
        p_page_header           => 'CONFIDENTIAL - FOR INTERNAL USE ONLY',
        p_page_footer           => 'CONFIDENTIAL document generated on: ' || to_char(systimestamp, 'dd-Mon-yyyy hh24:mi:ss TZR'),
        p_page_footer_alignment => apex_data_export.c_align_center,
        p_border_width          => 0,
        p_border_color          =>'#FFFFFF'
    );

    l_export := apex_data_export.export (
        p_context               => l_context,
        p_print_config          => l_print_config,
        p_format                => apex_data_export.c_format_xlsx,
        p_columns               => l_columns,
        p_file_name             => 'commission_'||to_char(sysdate,'yyyymmddhh24miss') 
        );

    apex_exec.close( l_context );

    apex_data_export.download( p_export => l_export );

exception
    when others then
        apex_exec.close( l_context );
        raise;
end;
