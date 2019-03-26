CREATE OR REPLACE PACKAGE BODY tst_ords_demoapi AS

    G_scope_prefix     CONSTANT VARCHAR2(100) := LOWER($$plsql_unit) || '.';
    --
    -- UNIT:        global_setup
    -- DESCRIPTION: Invokes the rest end point and set globa values
    --
    PROCEDURE global_setup 
    IS
        L_params             logger.tab_param;
        L_scope              VARCHAR2(100) := G_scope_prefix||'global_setup';    
    BEGIN
        -- Call web service and get the reponse JSON
        G_clob := APEX_WEB_SERVICE.make_rest_request(
        p_url          => G_rest_end_url, 
        p_http_method  => 'GET'
        );

        -- Parse the JSON
        APEX_JSON.parse(G_clob);

        -- Loop through the JSON items.
        l_item_count := APEX_JSON.get_count(p_path => 'items');

        G_db_name        := APEX_JSON.get_varchar2(p_path => 'items[%d].db_name', p0 => 1);
        G_module         := APEX_JSON.get_varchar2(p_path => 'items[%d].module', p0 => 1);
        G_sessionid      := APEX_JSON.get_varchar2(p_path => 'items[%d].sessionid', p0 => 1);
        G_host           := APEX_JSON.get_varchar2(p_path => 'items[%d].host', p0 => 1);

    EXCEPTION
        WHEN OTHERS THEN
            logger.log_error (
                p_text   => 'Error invoking Demo Rest End Point',
                p_scope  => L_scope,
                p_params => l_params
                );
    END;
    --
    -- UNIT:        server_listening
    -- DESCRIPTION: G_clob is not null means server is sending response
    --
    PROCEDURE server_listening 
    IS
    BEGIN
        ut.expect(G_clob).to_be_not_null();    
    END;
    --
    -- UNIT:        end_url_available
    -- DESCRIPTION: G_clob is a JSON means it's available
    --
    PROCEDURE end_url_available 
    IS
    BEGIN
        ut.expect(G_clob).to_be_like( '{"items":[%', '#' ); 
    END;
    --
    -- UNIT:        check_db_env
    -- DESCRIPTION: G_db_name is same as sys context value
    --
    PROCEDURE check_db_env 
    IS
        l_actual_db_env     VARCHAR2(30);
    BEGIN
        ut.expect(UPPER(regexp_substr(G_rest_end_url,'[^/]+',1,4))).to_equal(UPPER(G_db_name)); 
    END;
    --
    -- UNIT:        valid_host
    -- DESCRIPTION: G_db_name is same as sys context value
    --
    PROCEDURE valid_host 
    IS
        l_actual_db_env     VARCHAR2(30);
    BEGIN
        ut.expect(UPPER(regexp_substr(G_rest_end_url,'[^/]+',1,2))).to_be_like(UPPER(G_host)||'%'); 
    END;
    --
    -- UNIT:        check_module
    -- DESCRIPTION: G_db_name is same as sys context value
    --
    PROCEDURE check_module 
    IS
        l_actual_module     VARCHAR2(30) := 'APEX Listener';
    BEGIN
        ut.expect(l_actual_module).to_equal(G_module); 
    END;
    --
    -- UNIT:        valid_session
    -- DESCRIPTION: Session not null
    --
    PROCEDURE valid_session 
    IS
    BEGIN
        ut.expect(G_sessionid).to_be_not_null();
    END;
    --
    -- UNIT:        global_setup
    -- DESCRIPTION: Invokes the rest end point and set globa values
    --
    PROCEDURE global_cleanup 
    IS
        L_params             logger.tab_param;
        L_scope              VARCHAR2(100) := G_scope_prefix||'global_cleanup';    
    BEGIN

        G_clob           := NULL;
        G_db_name        := NULL;
        G_module         := NULL;
        G_sessionid      := NULL;
        G_host           := NULL;
    END;

END tst_ords_demoapi;
/

