
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
    -- Unprotected

    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'healthcheck.v1',
        p_pattern        => 'v2/',
        p_priority       => 0,
        p_etag_type      => 'HASH',
        p_etag_query     => NULL,
        p_comments       => NULL);

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'healthcheck.v1',
        p_pattern        => 'v2/',
        p_method         => 'GET',
        p_source_type    => 'json/query',
        p_items_per_page =>  0,
        p_mimes_allowed  => '',
        p_comments       => NULL,
        p_source         =>q'[
            select 
                sys_context('userenv', 'db_name')                  db_name
            from dual
        ]'
        );

    COMMIT;
    -- URI http://server:port/ords/api/healthcheck/v2/
    --https://sd2cgxnc6zom7sw-ourcompany.adb.uk-london-1.oraclecloudapps.com/ords/api/healthcheck/v2/
END;
/

begin
    ords.create_role('healthcheck_role');     
    commit;
end;
/

DECLARE
    l_arr owa.vc_arr;
BEGIN
    l_arr(1) := 'healthcheck_role';

    ORDS.define_privilege (
        p_privilege_name => 'healthcheck_priv',
        p_roles          => l_arr,
        p_label          => 'Health check Access Privilege',
        p_description    => 'Allow access to healthcheck API'
    );

    COMMIT;
END;
/

begin
    ords.create_privilege_mapping(
        p_privilege_name => 'healthcheck_priv',
        p_pattern => '/healthcheck/v1/*');     
    commit;
end;
/

BEGIN
    OAUTH.create_client(
        p_name            => 'healthcheck_Client',
        p_grant_type      => 'client_credentials',
        p_owner           => 'Saroj',
        p_description     => 'A client for healthcheck management',
        p_support_email   => 'test@test.com',
        p_privilege_names => 'healthcheck_priv'
    );

    COMMIT;
END;
/

SELECT id, name, client_id, client_secret FROM user_ords_clients;

client id : zMsOZn2pLkd6zrsNwsQ90Q..
client secret : OKbAMNlB2h0EcCX0OnGLHw..

-- Display client-privilege relationship.
SELECT name, client_name FROM user_ords_client_privileges;

-- Associate the client with org_role role required for org_priv
BEGIN
    OAUTH.grant_client_role(
        p_client_name => 'healthcheck_Client',
        p_role_name   => 'healthcheck_role'
    );

    COMMIT;
END;
/




curl -i -k --user zMsOZn2pLkd6zrsNwsQ90Q..:OKbAMNlB2h0EcCX0OnGLHw.. --data "grant_type=client_credentials" https://sd2cgxnc6zom7sw-ourcompany.adb.uk-london-1.oraclecloudapps.com/ords/api/oauth/token

curl --request GET \
  --url https://sd2cgxnc6zom7sw-ourcompany.adb.uk-london-1.oraclecloudapps.com/ords/api/healthcheck/v1/ \
  --header 'Content-Type: application/x-www-form-urlencoded'

curl -i -k --user uny2QusgGI6hZJ6I-jzyCw..:kJ7oI7dRjljbXkNd52E4Ig.. --data "grant_type=client_credentials" https://sd2cgxnc6zom7sw-devclearing.adb.uk-london-1.oraclecloudapps.com/ords/api/oauth/token

