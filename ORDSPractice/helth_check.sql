
begin
    dbms_session.set_identifier('Test Process');
    dbms_application_info.set_client_info('Test Client Info');
    dbms_application_info.set_module('Test Module','Test Action'); -- Sets both module and action
    dbms_application_info.set_action('Test Action - 1'); -- Overwrites previous action
end;
/


BEGIN
    ORDS.ENABLE_SCHEMA(
        p_enabled             => TRUE,
        p_schema              => user,
        p_url_mapping_type    => 'BASE_PATH',
        p_url_mapping_pattern => 'api',
        p_auto_rest_auth      => FALSE);

    ORDS.DEFINE_MODULE(
        p_module_name    => 'healthcheck.v1',
        p_base_path      => '/healthcheck/',
        p_items_per_page =>  10,
        p_status         => 'PUBLISHED',
        p_comments       => 'Health check module');

    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'healthcheck.v1',
        p_pattern        => 'v1/',
        p_priority       => 0,
        p_etag_type      => 'HASH',
        p_etag_query     => NULL,
        p_comments       => NULL);

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'healthcheck.v1',
        p_pattern        => 'v1/',
        p_method         => 'GET',
        p_source_type    => 'json/query',
        p_items_per_page =>  0,
        p_mimes_allowed  => '',
        p_comments       => NULL,
        p_source         =>q'[
            select 
                sys_context('userenv', 'db_name')                  db_name
                ,sys_context('userenv', 'instance_name')           instance_name
                ,sys_context('userenv', 'cdb_name')                cdb_name
                ,sys_context('userenv', 'server_host')             server_host
                ,sys_context('userenv', 'oracle_home')             oracle_home
                ,sys_context('userenv', 'ip_address')              ip_address
                ,sys_context('userenv', 'host')                    host
                ,sys_context('userenv', 'os_user')                 os_user
                ,sys_context('userenv', 'current_user')            current_user
                ,sys_context('userenv', 'session_user')            session_user
                ,sys_context('userenv', 'sessionid')               sessionid
                ,sys_context('userenv', 'sid')                     sid
                ,sys_context('userenv', 'terminal')                terminal
                ,sys_context('userenv', 'client_program_name')     client_program_name
                ,sys_context('userenv', 'client_identifier')       client_identifier 
                ,sys_context('userenv', 'client_info')             client_info
                ,sys_context('userenv', 'module')                  module
                ,sys_context('userenv', 'action')                  action
            from dual
        ]'
        );

    COMMIT;
    -- URI http://server:port/ords/api/healthcheck/v1/
END;
/