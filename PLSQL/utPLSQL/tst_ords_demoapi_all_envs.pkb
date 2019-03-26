CREATE OR REPLACE PACKAGE BODY tst_ords_demoapi_all_envs AS

    G_scope_prefix     CONSTANT VARCHAR2(100) := LOWER($$plsql_unit) || '.';
    --
    -- DESCRIPTION: Invokes the rest end points and populate the global collection
    --
    PROCEDURE global_setup 
    IS
    BEGIN
        init_global_collection(i_end_url => G_ords_url_cmsdev);
        init_global_collection(i_end_url => G_ords_url_cmstst);
        init_global_collection(i_end_url => G_ords_url_cmsts2);
        init_global_collection(i_end_url => G_ords_url_cmsts3);
        init_global_collection(i_end_url => G_ords_url_cmsts4);
        init_global_collection(i_end_url => G_ords_url_cmssp1);
        
        init_global_collection(i_end_url => G_ords_url_omsdev);
        init_global_collection(i_end_url => G_ords_url_omstst);
        init_global_collection(i_end_url => G_ords_url_omsts2);
        init_global_collection(i_end_url => G_ords_url_omsts3);
        init_global_collection(i_end_url => G_ords_url_omsts4);
        init_global_collection(i_end_url => G_ords_url_omssp1);
        
        init_global_collection(i_end_url => G_ords_url_wmsdev);
        init_global_collection(i_end_url => G_ords_url_wmstst);
        init_global_collection(i_end_url => G_ords_url_wmsts2);
        init_global_collection(i_end_url => G_ords_url_wmsts3);
        init_global_collection(i_end_url => G_ords_url_wmsts4);
        init_global_collection(i_end_url => G_ords_url_wmssp1);
        /*
        init_global_collection(i_end_url => G_ords_url_dwhdev);
        init_global_collection(i_end_url => G_ords_url_dwhtst);
        init_global_collection(i_end_url => G_ords_url_dwhts2);
        init_global_collection(i_end_url => G_ords_url_dwhts3);
        init_global_collection(i_end_url => G_ords_url_dwhsp1);
        */
    END;

    -- CMSDEV
    --
    -- DESCRIPTION: response_json is not null means server is sending response
    --
    PROCEDURE cmsdev_server_listening 
    IS
    BEGIN
        ut.expect(G_rec_tab(regexp_substr(G_ords_url_cmsdev,'[^/]+',1,4)).response_json).to_be_not_null();    
    END;
    --
    -- DESCRIPTION: response_json is a valid JSON, means it's available
    --
    PROCEDURE cmsdev_end_url_available 
    IS
    BEGIN
        ut.expect(G_rec_tab(regexp_substr(G_ords_url_cmsdev,'[^/]+',1,4)).response_json).to_be_like( '{"items":[%', '#' ); 
    END;
    --
    -- DESCRIPTION: db_name is same as sys context value
    --
    PROCEDURE cmsdev_check_db_env 
    IS
    BEGIN
        --ut.expect(UPPER(regexp_substr(G_rest_end_url,'[^/]+',1,4))).to_equal(UPPER(G_db_name)); 
        ut.expect(upper(G_rec_tab(regexp_substr(G_ords_url_cmsdev,'[^/]+',1,4)).db_name)).to_equal(UPPER(regexp_substr(G_ords_url_cmsdev,'[^/]+',1,4)));
    END;
    --
    -- DESCRIPTION: G_db_name is same as sys context value
    --
    PROCEDURE cmsdev_check_module 
    IS
    BEGIN
        ut.expect('APEX Listener').to_equal(G_rec_tab(regexp_substr(G_ords_url_cmsdev,'[^/]+',1,4)).module); 
    END;
    --
    -- UNIT:        valid_session
    -- DESCRIPTION: Session not null
    --
    PROCEDURE cmsdev_valid_session 
    IS
    BEGIN
        ut.expect(G_rec_tab(regexp_substr(G_ords_url_cmsdev,'[^/]+',1,4)).sessionid).to_be_not_null();
    END;

    -- cmstst
    --
    -- DESCRIPTION: response_json is not null means server is sending response
    --
    PROCEDURE cmstst_server_listening 
    IS
    BEGIN
        ut.expect(G_rec_tab(regexp_substr(G_ords_url_cmstst,'[^/]+',1,4)).response_json).to_be_not_null();    
    END;
    --
    -- DESCRIPTION: response_json is a valid JSON, means it's available
    --
    PROCEDURE cmstst_end_url_available 
    IS
    BEGIN
        ut.expect(G_rec_tab(regexp_substr(G_ords_url_cmstst,'[^/]+',1,4)).response_json).to_be_like( '{"items":[%', '#' ); 
    END;
    --
    -- DESCRIPTION: db_name is same as sys context value
    --
    PROCEDURE cmstst_check_db_env 
    IS
    BEGIN
        --ut.expect(UPPER(regexp_substr(G_rest_end_url,'[^/]+',1,4))).to_equal(UPPER(G_db_name)); 
        ut.expect(upper(G_rec_tab(regexp_substr(G_ords_url_cmstst,'[^/]+',1,4)).db_name)).to_equal(UPPER(regexp_substr(G_ords_url_cmstst,'[^/]+',1,4)));
    END;
    --
    -- DESCRIPTION: G_db_name is same as sys context value
    --
    PROCEDURE cmstst_check_module 
    IS
    BEGIN
        ut.expect('APEX Listener').to_equal(G_rec_tab(regexp_substr(G_ords_url_cmstst,'[^/]+',1,4)).module); 
    END;
    --
    -- UNIT:        valid_session
    -- DESCRIPTION: Session not null
    --
    PROCEDURE cmstst_valid_session 
    IS
    BEGIN
        ut.expect(G_rec_tab(regexp_substr(G_ords_url_cmstst,'[^/]+',1,4)).sessionid).to_be_not_null();
    END;


    -- CMSTS2
    --
    -- DESCRIPTION: response_json is not null means server is sending response
    --
    PROCEDURE cmsts2_server_listening 
    IS
    BEGIN
        ut.expect(G_rec_tab(regexp_substr(G_ords_url_cmsts2,'[^/]+',1,4)).response_json).to_be_not_null();    
    END;
    --
    -- DESCRIPTION: response_json is a valid JSON, means it's available
    --
    PROCEDURE cmsts2_end_url_available 
    IS
    BEGIN
        ut.expect(G_rec_tab(regexp_substr(G_ords_url_cmsts2,'[^/]+',1,4)).response_json).to_be_like( '{"items":[%', '#' ); 
    END;
    --
    -- DESCRIPTION: db_name is same as sys context value
    --
    PROCEDURE cmsts2_check_db_env 
    IS
    BEGIN
        --ut.expect(UPPER(regexp_substr(G_rest_end_url,'[^/]+',1,4))).to_equal(UPPER(G_db_name)); 
        ut.expect(upper(G_rec_tab(regexp_substr(G_ords_url_cmsts2,'[^/]+',1,4)).db_name)).to_equal(UPPER(regexp_substr(G_ords_url_cmsts2,'[^/]+',1,4)));
    END;
    --
    -- DESCRIPTION: G_db_name is same as sys context value
    --
    PROCEDURE cmsts2_check_module 
    IS
    BEGIN
        ut.expect('APEX Listener').to_equal(G_rec_tab(regexp_substr(G_ords_url_cmsts2,'[^/]+',1,4)).module); 
    END;
    --
    -- UNIT:        valid_session
    -- DESCRIPTION: Session not null
    --
    PROCEDURE cmsts2_valid_session 
    IS
    BEGIN
        ut.expect(G_rec_tab(regexp_substr(G_ords_url_cmsts2,'[^/]+',1,4)).sessionid).to_be_not_null();
    END;
    
    -- CMSTS3
    --
    -- DESCRIPTION: response_json is not null means server is sending response
    --
    PROCEDURE cmsts3_server_listening 
    IS
    BEGIN
        ut.expect(G_rec_tab(regexp_substr(G_ords_url_cmsts3,'[^/]+',1,4)).response_json).to_be_not_null();    
    END;
    --
    -- DESCRIPTION: response_json is a valid JSON, means it's available
    --
    PROCEDURE cmsts3_end_url_available 
    IS
    BEGIN
        ut.expect(G_rec_tab(regexp_substr(G_ords_url_cmsts3,'[^/]+',1,4)).response_json).to_be_like( '{"items":[%', '#' ); 
    END;
    --
    -- DESCRIPTION: db_name is same as sys context value
    --
    PROCEDURE cmsts3_check_db_env 
    IS
    BEGIN
        --ut.expect(UPPER(regexp_substr(G_rest_end_url,'[^/]+',1,4))).to_equal(UPPER(G_db_name)); 
        ut.expect(upper(G_rec_tab(regexp_substr(G_ords_url_cmsts3,'[^/]+',1,4)).db_name)).to_equal(UPPER(regexp_substr(G_ords_url_cmsts3,'[^/]+',1,4)));
    END;
    --
    -- DESCRIPTION: G_db_name is same as sys context value
    --
    PROCEDURE cmsts3_check_module 
    IS
    BEGIN
        ut.expect('APEX Listener').to_equal(G_rec_tab(regexp_substr(G_ords_url_cmsts3,'[^/]+',1,4)).module); 
    END;
    --
    -- UNIT:        valid_session
    -- DESCRIPTION: Session not null
    --
    PROCEDURE cmsts3_valid_session 
    IS
    BEGIN
        ut.expect(G_rec_tab(regexp_substr(G_ords_url_cmsts3,'[^/]+',1,4)).sessionid).to_be_not_null();
    END;

    -- CMSTS4
    --
    -- DESCRIPTION: response_json is not null means server is sending response
    --
    PROCEDURE cmsts4_server_listening 
    IS
    BEGIN
        ut.expect(G_rec_tab(regexp_substr(G_ords_url_cmsts4,'[^/]+',1,4)).response_json).to_be_not_null();    
    END;
    --
    -- DESCRIPTION: response_json is a valid JSON, means it's available
    --
    PROCEDURE cmsts4_end_url_available 
    IS
    BEGIN
        ut.expect(G_rec_tab(regexp_substr(G_ords_url_cmsts4,'[^/]+',1,4)).response_json).to_be_like( '{"items":[%', '#' ); 
    END;
    --
    -- DESCRIPTION: db_name is same as sys context value
    --
    PROCEDURE cmsts4_check_db_env 
    IS
    BEGIN
        --ut.expect(UPPER(regexp_substr(G_rest_end_url,'[^/]+',1,4))).to_equal(UPPER(G_db_name)); 
        ut.expect(upper(G_rec_tab(regexp_substr(G_ords_url_cmsts4,'[^/]+',1,4)).db_name)).to_equal(UPPER(regexp_substr(G_ords_url_cmsts4,'[^/]+',1,4)));
    END;
    --
    -- DESCRIPTION: G_db_name is same as sys context value
    --
    PROCEDURE cmsts4_check_module 
    IS
    BEGIN
        ut.expect('APEX Listener').to_equal(G_rec_tab(regexp_substr(G_ords_url_cmsts4,'[^/]+',1,4)).module); 
    END;
    --
    -- UNIT:        valid_session
    -- DESCRIPTION: Session not null
    --
    PROCEDURE cmsts4_valid_session 
    IS
    BEGIN
        ut.expect(G_rec_tab(regexp_substr(G_ords_url_cmsts4,'[^/]+',1,4)).sessionid).to_be_not_null();
    END;


    -- CMSSP1
    --
    -- DESCRIPTION: response_json is not null means server is sending response
    --
    PROCEDURE cmssp1_server_listening 
    IS
    BEGIN
        ut.expect(G_rec_tab(regexp_substr(G_ords_url_cmssp1,'[^/]+',1,4)).response_json).to_be_not_null();    
    END;
    --
    -- DESCRIPTION: response_json is a valid JSON, means it's available
    --
    PROCEDURE cmssp1_end_url_available 
    IS
    BEGIN
        ut.expect(G_rec_tab(regexp_substr(G_ords_url_cmssp1,'[^/]+',1,4)).response_json).to_be_like( '{"items":[%', '#' ); 
    END;
    --
    -- DESCRIPTION: db_name is same as sys context value
    --
    PROCEDURE cmssp1_check_db_env 
    IS
    BEGIN
        --ut.expect(UPPER(regexp_substr(G_rest_end_url,'[^/]+',1,4))).to_equal(UPPER(G_db_name)); 
        ut.expect(upper(G_rec_tab(regexp_substr(G_ords_url_cmssp1,'[^/]+',1,4)).db_name)).to_equal(UPPER(regexp_substr(G_ords_url_cmssp1,'[^/]+',1,4)));
    END;
    --
    -- DESCRIPTION: G_db_name is same as sys context value
    --
    PROCEDURE cmssp1_check_module 
    IS
    BEGIN
        ut.expect('APEX Listener').to_equal(G_rec_tab(regexp_substr(G_ords_url_cmssp1,'[^/]+',1,4)).module); 
    END;
    --
    -- UNIT:        valid_session
    -- DESCRIPTION: Session not null
    --
    PROCEDURE cmssp1_valid_session 
    IS
    BEGIN
        ut.expect(G_rec_tab(regexp_substr(G_ords_url_cmssp1,'[^/]+',1,4)).sessionid).to_be_not_null();
    END;
    --
    -- UNIT:        global_setup
    -- DESCRIPTION: Invokes the rest end point and set global values
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
    --
    -- UNIT:        init_global_collection
    -- DESCRIPTION: set the global collection values
    --
    PROCEDURE init_global_collection(
        i_end_url in varchar2)
    IS
        L_params             logger.tab_param;
        L_scope              VARCHAR2(100) := G_scope_prefix||'init_global_collection';  
        l_rec                db_details_rec;
        l_db_name            varchar2(100) := regexp_substr(i_end_url,'[^/]+',1,4);
    BEGIN
        logger.append_param (L_params, 'i_end_url', i_end_url);
        --dbms_output.put_line('i_end_url:'||i_end_url);
        -- Call web service and get the reponse JSON
        l_rec.response_json := APEX_WEB_SERVICE.make_rest_request(
            p_url          => i_end_url, 
            p_http_method  => 'GET'
            );
            
        logger.append_param (L_params, 'l_rec.response_json', l_rec.response_json);

        -- Parse the JSON
      
        APEX_JSON.parse(l_rec.response_json);

        -- Loop through the JSON items.
        l_item_count := APEX_JSON.get_count(p_path => 'items');

        l_rec.db_name      := APEX_JSON.get_varchar2(p_path => 'items[%d].db_name', p0 => 1);
        l_rec.module       := APEX_JSON.get_varchar2(p_path => 'items[%d].module', p0 => 1);
        l_rec.sessionid    := APEX_JSON.get_varchar2(p_path => 'items[%d].sessionid', p0 => 1);
        l_rec.host         := APEX_JSON.get_varchar2(p_path => 'items[%d].host', p0 => 1);

        G_rec_tab(l_db_name) := l_rec;
        
    EXCEPTION
        WHEN OTHERS THEN
            logger.log_error (
                p_text   => 'Error invoking Demo Rest End Point',
                p_scope  => L_scope,
                p_params => l_params,
                p_extra  => l_rec.response_json
                );
    END;

END tst_ords_demoapi_all_envs;
/

