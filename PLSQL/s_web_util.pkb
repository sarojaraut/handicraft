CREATE OR REPLACE PACKAGE BODY s_web_util AS
--
-- NAME:  s_web_util
-- TYPE:  PL/SQL Package spec
-- TITLE: Standard package for most common operations related to
--          * oAuth token
--          * JSON 
--
-- NOTES: 
--
--$Revision:   1.1  $
-------------------------------------------------------------------------------
-- Version | Date      | Author             | Reason
-- 1.0     |10/10/2018 | S. Raut            | Initial Revision
-- 1.2     |23/11/2018 | S. Raut            | Added new function f_blob_to_clob
-------------------------------------------------------------------------------
--
--
    C_scope_prefix        CONSTANT s_datatype.unit_name := LOWER($$plsqL_unit) || '.';
    C_wallet_path_prefix  CONSTANT s_datatype.unit_name := 'file:';
    C_wallet_context_name CONSTANT s_datatype.unit_name := 'S_WALLET_DIR';
    C_project_phase       CONSTANT s_datatype.unit_name := 'S_PROJECT_PHASE';
    --
    G_wallet_path        s_datatype.unit_name;
    G_db_environment     s_datatype.unit_name;
    -- UNIT:        f_format_date
    -- DESCRIPTION: Returns date
    -- NOTES:       N/A
    --
    FUNCTION f_format_date(
        I_date         IN  DATE,
        I_format       IN  VARCHAR2 DEFAULT 'YYYY-MM-DD"T"HH24:MI:SS"Z"',
        I_timezone     IN  VARCHAR2 DEFAULT DBTIMEZONE
    )
    RETURN VARCHAR2
    IS
        L_err_msg   s_datatype.err_msg  
            := 'Date conversion error : I_date=%s1 I_format=%s2 I_timezone=%S3';
        L_scope     s_datatype.unit_name := LOWER($$plsql_unit)||'f_format_date';
    BEGIN
    
        RETURN TO_CHAR(
                CAST(I_date as timestamp) AT TIME ZONE I_timezone
                ,I_format
            );
    
    EXCEPTION
        WHEN OTHERS THEN
            logger.log_error (
                p_text   => logger.sprintf(
                                L_err_msg
                                ,I_date
                                ,I_format
                                ,I_timezone),
                p_scope  => L_scope);
            RAISE;
    END f_format_date;
    --
    -- UNIT:        f_rfc3339_format_date
    -- DESCRIPTION: Returns RFC339 formatted date in UTC timezone
    -- NOTES:       N/A
    --
    FUNCTION f_rfc3339_format_date(
        I_date         IN  DATE
    )
    RETURN VARCHAR2
    IS
        L_utc_zone  CONSTANT   VARCHAR2(3)  := 'UTC';
        L_scope s_datatype.unit_name := C_scope_prefix||'f_rfc3339_format_date';
    BEGIN
    
        RETURN f_format_date(
            I_date      => I_date,
            I_timezone  => L_utc_zone);
    
    END f_rfc3339_format_date;
    --
    -- UNIT:        f_build_uuid
    --
    -- DESCRIPTION: Generates universally unique identifier (UUID)
    --               Converts sys_guid in UUID v4 format and return
    -- NOTES:  Throws exception if fails. Logging steps are avoided as
    --         this function is expected to be invoked huge number of times
    --
    FUNCTION f_build_uuid
    RETURN VARCHAR2
    IS
        L_scope  s_datatype.unit_name := C_scope_prefix||'f_build_uuid';
        l_uuid   VARCHAR2(36);
    BEGIN

        l_uuid :=
            regexp_replace(
                RAWTOHEX(sys_guid()),
                '([A-F0-9]{8})([A-F0-9]{4})([A-F0-9]{4})([A-F0-9]{4})([A-F0-9]{12})',
                '\1-\2-\3-\4-\5'
            );

        RETURN l_uuid;

    EXCEPTION
        WHEN OTHERS THEN
            logger.log_error (
                p_text   => 'Failed to build UUID',
                p_scope  => L_scope);
		RAISE;
    END f_build_uuid;
	--
    -- UNIT:        pl_create_ssl_failure_incident
    -- DESCRIPTION: N/A
    -- USAGE:       pl_create_ssl_failure_incident
    -- PARAMS:      I_snow_service : Service now service name
    --              I_snow_attribute : Service now attribute name
    -- RETURNS:     N/A
    -- NOTES:       N/A
    --
    PROCEDURE pl_create_ssl_failure_incident(
        I_snow_service     IN s_webservice_config.snow_service%TYPE,
        I_snow_attribute   IN s_webservice_config.snow_attribute%TYPE
    )
    IS
        C_urgency         CONSTANT VARCHAR2(1)   := '1';
        C_impact          CONSTANT VARCHAR2(1)   := '1';
        L_snow_short_desc          s_datatype.long_string;
        L_snow_desc                s_datatype.long_desc;
        L_incident_number          s_datatype.unit_name;
        L_incident_alert_id        s_datatype.unit_name;
        L_scope s_datatype.unit_name := C_scope_prefix||'pl_create_ssl_failure_incident';
    BEGIN
        logger.log_info (
            p_text   => s_const.C_begin,
            p_scope  => L_scope);
        --
        -- SNOW Ticket Descriptions
        --
        L_snow_short_desc := 'SSL Certificate error - during oAuth token fetch';
        L_snow_desc       :=
            'Failure : %s1, during oauth token fetch from URI:%s2 for audience:%s3';

        --
        -- Invoke util function to create the incident
        --
        s_snow_util.p_incident_post(
            I_short_description => L_snow_short_desc,
            I_description       => L_snow_desc,
            I_service           => I_snow_service,
            I_attribute         => I_snow_attribute,
            I_urgency           => C_urgency,
            I_impact            => C_impact,
            O_incident_number   => L_incident_number,
            O_incident_alert_id => L_incident_alert_id);

        logger.log_info (
            p_text   => s_const.C_end,
            p_scope  => L_scope);

    EXCEPTION
        WHEN OTHERS THEN
            logger.log_error (
                p_text   => 'SNOW incident creation failure',
                p_scope  => L_scope);
            RAISE;
    END pl_create_ssl_failure_incident;
    --
    -- UNIT:        pl_store_oauth_token
    -- DESCRIPTION: Stores the outh token and expiry in config table
    -- USAGE:       pl_store_oauth_token
    -- PARAMS:      I_config_rec : Config record
    -- RETURNS:     N/A
    -- NOTES:       N/A
    --
    PROCEDURE pl_store_oauth_token(
        I_config_rec    s_webservice_config%ROWTYPE
    )
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        L_scope s_datatype.unit_name := C_scope_prefix||'pl_store_oauth_token';
    BEGIN
        logger.log(
            p_text   => s_const.C_begin,
            p_scope  => L_scope);
        
        UPDATE s_webservice_config
        SET   oauth_token = i_config_rec.oauth_token,
              oauth_token_expiry_dtm = i_config_rec.oauth_token_expiry_dtm,
              oauth_token_refresh_dtm = SYSTIMESTAMP
        WHERE system_id     = I_config_rec.system_id
        AND   service_name  = I_config_rec.service_name
        AND   UPPER(project_phase) = UPPER(G_db_environment);

        COMMIT;

        logger.log(
            p_text   => s_const.C_end,
            p_scope  => L_scope);

    EXCEPTION
        WHEN OTHERS THEN
            logger.log_error (
                p_text   => 'Error - saving oauth token details',
                p_scope  => L_scope);
            RAISE;
    END pl_store_oauth_token;
	--
    -- UNIT:        p_set_http_header
    -- DESCRIPTION: Parses the Colon separated and semicolon delimited 
    --              string into name value pair and sets the http header
    -- NOTES:       N/A
    --
    PROCEDURE p_set_http_header(
        I_header_list          IN  s_webservice_config.http_headers%TYPE
    )
    IS
        L_scope s_datatype.unit_name := C_scope_prefix||'p_set_http_header';
    BEGIN
        logger.log (
            p_text   => s_const.C_begin,
            p_scope  => L_scope);
        --
        -- Delete existing headers
        --
        apex_web_service.g_status_code := NULL;
        apex_web_service.g_request_headers.delete;
        --
        -- Add new headers
        --
        FOR I IN (
            SELECT 
                REGEXP_SUBSTR(
                    REGEXP_SUBSTR(
                        I_header_list, 
                        '[^;]+',1,rownum), 
                    '[^:]+',1,1)               AS header_name,
                REGEXP_SUBSTR(
                    REGEXP_SUBSTR(
                        I_header_list, 
                        '[^;]+',1,rownum), 
                    '[^:]+',1,2)               AS  header_value,
            ROWNUM                             AS  header_id
            FROM DUAL
            CONNECT BY ROWNUM <= 
                regexp_count(I_header_list, ';')+1 
        )
        LOOP
            apex_web_service.g_request_headers(i.header_id).name := i.header_name;
            apex_web_service.g_request_headers(i.header_id).value:= i.header_value;
        END LOOP;

        logger.log (
            p_text   => s_const.C_end,
            p_scope  => L_scope);

    EXCEPTION
        WHEN OTHERS THEN
            logger.log_error (
                p_text   => 'Error setting HTTP headers',
                p_scope  => L_scope);
            RAISE;
    END p_set_http_header;
    --
    -- UNIT:        pl_refresh_oauth_token
    -- DESCRIPTION: Requests a new oauth token and populates the
    --              global variable with token and expiry
    --
    -- USAGE:       pl_refresh_oauth_token
    -- PARAMS:      I_config_rec : Config record
    -- RETURNS:     N/A
    --
    -- NOTES:  Throws exception if fails to get a token after retry
    --
    PROCEDURE pl_refresh_oauth_token(
        I_config_rec    IN OUT s_webservice_config%ROWTYPE
    )
    IS
        L_response_clob                 CLOB;
        L_token_payload                 CLOB;
        L_oauth_token                   s_datatype.long_string;
        L_expires_in                    s_datatype.counter;
        L_retry_count                   s_datatype.counter := 0;
        L_oauth_token_ssl_failure       BOOLEAN := FALSE;
        L_params                        logger.tab_param;
        C_failed_cert_pattern  CONSTANT s_datatype.err_msg
            := '%Certificate validation failure%';
        C_fatal_error_code    CONSTANT s_datatype.err_code := -20998;
        C_fatal_error_message CONSTANT s_datatype.err_msg
            := 'oAuth token request failure, http status =';
        L_err_msg                s_datatype.err_msg  
            := 'Web config fetch error : I_system_id=%s1 I_service_name=%s2';
        L_scope  s_datatype.unit_name := C_scope_prefix||'pl_refresh_oauth_token';

    BEGIN
        logger.log_info (
            p_text   => s_const.C_begin,
            p_scope  => L_scope);
        logger.append_param(
            L_params,
            'Start Time',
            systimestamp
            );        
        --
        -- Add HTTP headers from config table
        --
        p_set_http_header(I_config_rec.oauth_http_headers);
        --
        -- Build the token request JSON
        --
        apex_json.initialize_clob_output;
        apex_json.open_object;
        apex_json.write('audience', I_config_rec.oauth_audience);
        apex_json.write('grant_type', 'client_credentials');
        apex_json.write('client_id', I_config_rec.oauth_client_id);
        apex_json.write('client_secret', I_config_rec.oauth_client_secret);
        apex_json.close_object;
        l_token_payload := apex_json.get_clob_output;
        apex_json.free_output;
        --
        -- Loop untill oAuth call is successful or reached max retry
        --
        WHILE NVL(apex_web_service.g_status_code, 0) <> s_http_const.C_status_ok
                AND L_retry_count <= I_config_rec.oauth_max_retries
        LOOP
            L_retry_count := L_retry_count + 1;
            --
            -- Certificate issue will throw exception
            -- and will be re-raised, all other temporary
            -- issues will be retried untill max retry
            --
            BEGIN

                L_response_clob :=
                    apex_web_service.make_rest_request(
                        p_url          => I_config_rec.oauth_url,
                        p_http_method  => s_http_const.C_method_post,
                        p_wallet_path  => G_wallet_path,
                        p_body         => l_token_payload
                );

            EXCEPTION
                WHEN OTHERS THEN
                    logger.log_error (
                        p_text   => 'oAuth rest call failure',
                        p_scope  => L_scope);

                    L_oauth_token_ssl_failure := SQLERRM LIKE C_failed_cert_pattern;
                    --
                    -- Create a P1 SNOW Incident if SSL certificate failure
                    --
                    IF L_oauth_token_ssl_failure 
                       AND I_config_rec.snow_service   IS NOT NULL
                       AND I_config_rec.snow_attribute IS NOT NULL
                    THEN
                        pl_create_ssl_failure_incident(
                            I_snow_service   => I_config_rec.snow_service,
                            I_snow_attribute => I_config_rec.snow_attribute
                        );
                    END IF;
                    --
                    -- Re-raise the exception if SSL failure or
                    -- token not received after max retry
                    --
                    IF (L_oauth_token_ssl_failure
                        OR L_retry_count = I_config_rec.max_retries)
                    THEN
                        RAISE;
                    END IF;
            END;
        END LOOP;

        logger.append_param(
            L_params,
            'oAuth token status',
            apex_web_service.g_status_code
            );

        IF apex_web_service.g_status_code = s_http_const.C_status_ok THEN

            apex_json.parse(l_response_clob);
            l_oauth_token := apex_json.get_varchar2(p_path => 'access_token');
            l_expires_in  := apex_json.get_number(p_path => 'expires_in') ;
            --
            -- To minimise the risk of using expired token, token set to be expired
            -- before 60 seconds of actual expiry
            --
            I_config_rec.oauth_token := l_oauth_token;
            I_config_rec.oauth_token_expiry_dtm := SYSDATE  + (l_expires_in - 60)/(24 * 60 * 60);

        ELSE
            --
            -- oAuth Token call returned with other error code
            --
            RAISE_APPLICATION_ERROR (
                C_fatal_error_code,
                C_fatal_error_message||apex_web_service.g_status_code);
        END IF;
        --
        -- Store the token and expiry in the config table
        --
        pl_store_oauth_token(I_config_rec);

        logger.append_param(
            L_params,
            'End Time',
            systimestamp
            );
        logger.log_info (
            p_text   => s_const.C_end,
            p_scope  => L_scope,
            p_params => L_params);

    EXCEPTION
        WHEN OTHERS THEN
            logger.log_error (
                p_text   => logger.sprintf(
                                L_err_msg
                                ,I_config_rec.system_id
                                ,I_config_rec.service_name),
                p_scope  => L_scope);
		RAISE;
    END pl_refresh_oauth_token;
    --
    -- UNIT:        f_get_web_config
    -- DESCRIPTION: Queries the s_sebservice_config table
    --              and return the config record
    -- NOTES:       N/A
    --
    FUNCTION f_get_web_config(
        I_system_id       IN   s_webservice_config.system_id%type,
        I_service_name    IN   s_webservice_config.service_name%type
    ) 
    RETURN s_webservice_config%ROWTYPE 
    RESULT_CACHE RELIES_ON (s_webservice_config)
    IS
        L_s_webservice_config    s_webservice_config%ROWTYPE;
        L_err_msg                s_datatype.err_msg  
            := 'Web config fetch error : I_system_id=%s1 I_service_name=%s2';
        L_scope s_datatype.unit_name := C_scope_prefix||'f_get_web_config';
    BEGIN
        logger.log (
            p_text   => s_const.C_begin,
            p_scope  => L_scope);

        SELECT *
        INTO L_s_webservice_config
        FROM s_webservice_config
        WHERE system_id     = I_system_id
        AND   service_name  = I_service_name
        AND   UPPER(project_phase) = UPPER(G_db_environment);

        logger.log(
            p_text   => s_const.C_end,
            p_scope  => L_scope);
        
        RETURN L_s_webservice_config;

    EXCEPTION
        WHEN OTHERS THEN
            logger.log_error (
                p_text   => logger.sprintf(
                                L_err_msg
                                ,I_system_id
                                ,I_service_name),
                p_scope  => L_scope);
            RAISE;
    END f_get_web_config;
    --
    -- UNIT:        f_get_oauth_token
    --
    -- DESCRIPTION: Checks if valid token is available for this session
    --              else requests a new oauth token and populates the
    --              global variable with token and expiry
    -- NOTES:  Throws exception fails to return a valid token
    --
    FUNCTION f_get_oauth_token(
        I_system_id       IN   s_webservice_config.system_id%type,
        I_service_name    IN   s_webservice_config.service_name%type
    )
    RETURN VARCHAR2
    RESULT_CACHE
    IS
        l_token_refresh_required     BOOLEAN;
        L_s_webservice_config_rec    s_webservice_config%ROWTYPE;
        L_params                     logger.tab_param;
        L_err_msg                s_datatype.err_msg  
            := 'oAuth token error : I_system_id=%s1 I_service_name=%s2';
        L_scope  s_datatype.unit_name := C_scope_prefix||'f_get_oauth_token';
    BEGIN
        logger.log (
            p_text   => s_const.C_begin,
            p_scope  => L_scope);
        --
        -- Get config details from s_webservice_config
        -- Unless the table get updated this would use the 
        -- result cache
        --
        L_s_webservice_config_rec := 
            f_get_web_config(
                I_system_id      => I_system_id,
                I_service_name   => I_service_name
            );
        
        l_token_refresh_required :=
               L_s_webservice_config_rec.oauth_token is NULL
            OR L_s_webservice_config_rec.oauth_token_expiry_dtm < SYSTIMESTAMP;

        IF l_token_refresh_required THEN
            --
            -- Refresh the token, store the new token and expiry
            -- in config table and also returns the new values
            -- in record
            --
            pl_refresh_oauth_token(L_s_webservice_config_rec);
        END IF;

        logger.log (
            p_text   => s_const.C_end,
            p_scope  => L_scope);

        RETURN s_http_const.C_oauth_bearer_token_prefix||
            L_s_webservice_config_rec.oauth_token;

    EXCEPTION
        WHEN OTHERS THEN
            logger.log_error (
                p_text   => logger.sprintf(
                                L_err_msg
                                ,I_system_id
                                ,I_service_name),
                p_scope  => L_scope,
                p_params => L_params);
		RAISE;
    END f_get_oauth_token;
	--
    -- UNIT:        f_clob_to_zipped_blob
    -- DESCRIPTION: Compress input clob and returns the compressed blob
    -- NOTES:       N/A
    --
    FUNCTION f_clob_to_zipped_blob(
        I_input_clob             IN  CLOB
    )
    RETURN BLOB
    IS
        L_zipped_blob             BLOB;
        L_chunked_raw             RAW(100);
        L_handleer                BINARY_INTEGER;
        l_chunk_size              integer := 57;
        l_offset                  integer := 1;
        L_scope s_datatype.unit_name := C_scope_prefix||'f_clob_to_zipped_blob';
    BEGIN
        logger.log (
            p_text   => s_const.C_begin,
            p_scope  => L_scope);

        dbms_lob.createtemporary(L_zipped_blob, false);

        L_handleer := utl_compress.lz_compress_open(L_zipped_blob);

        WHILE l_offset < dbms_lob.getlength(I_input_clob)
        LOOP
            L_chunked_raw := utl_raw.cast_to_raw(DBMS_LOB.SUBSTR(I_input_clob ,l_chunk_size, l_offset));
            utl_compress.lz_compress_add(L_handleer, L_zipped_blob, L_chunked_raw);
            l_offset := l_offset + l_chunk_size;
        END LOOP;
        
        utl_compress.lz_compress_close(L_handleer, L_zipped_blob);

        logger.log (
            p_text   => s_const.C_end,
            p_scope  => L_scope);
        
        RETURN L_zipped_blob;

    EXCEPTION
        WHEN OTHERS THEN
            logger.log_error (
                p_text   => 'Critical Error',
                p_scope  => L_scope,
                p_extra  => I_input_clob);
            RAISE;
    END f_clob_to_zipped_blob;
	--
    -- UNIT:        f_blob_to_base64_clob
    -- DESCRIPTION: Encode the BLOB to base64 encoded string
    -- NOTES:       N/A
    --
    FUNCTION f_blob_to_base64_clob(
        I_input_blob             IN  BLOB
    )
    RETURN CLOB
    IS
        l_encoded_clob   CLOB;
        L_scope s_datatype.unit_name := C_scope_prefix||'f_blob_to_base64_clob';
    BEGIN
        logger.log (
            p_text   => s_const.C_begin,
            p_scope  => L_scope);

        l_encoded_clob := apex_web_service.blob2clobbase64(I_input_blob);

        l_encoded_clob := replace(l_encoded_clob, CHr(10), NULL);
        l_encoded_clob := replace(l_encoded_clob, CHr(13), NULL);

        logger.log (
            p_text   => s_const.C_end,
            p_scope  => L_scope);
        
        RETURN l_encoded_clob;

    EXCEPTION
        WHEN OTHERS THEN
            logger.log_error (
                p_text   => 'Critical Error',
                p_scope  => L_scope);
            RAISE;
    END f_blob_to_base64_clob;
	--
    -- UNIT:        f_blob_to_clob
    -- DESCRIPTION: Encode the BLOB to base64 encoded string
    -- NOTES:       N/A
    --
    FUNCTION f_blob_to_clob(
        I_input_blob             IN  BLOB
    )
    RETURN CLOB
    IS
        l_clob             CLOB;
        L_temp_str         VARCHAR2(32767);
        l_index            PLS_INTEGER := 1;
        L_buffer           PLS_INTEGER := 32767;
        L_scope s_datatype.unit_name := C_scope_prefix||'f_blob_to_clob';
    BEGIN
        logger.log (
            p_text   => s_const.C_begin,
            p_scope  => L_scope);

        dbms_lob.createtemporary(l_clob, TRUE);
        
        FOR i IN 1..CEIL(dbms_lob.getlength(I_input_blob) / L_buffer)
        LOOP
            
            L_temp_str := 
                utl_raw.cast_to_varchar2(
                    dbms_lob.substr(I_input_blob, L_buffer, l_index)
                );
            dbms_lob.writeappend(l_clob, LENGTH(L_temp_str), L_temp_str);
            l_index := l_index + L_buffer;

        END LOOP;

        RETURN l_clob;

        logger.log (
            p_text   => s_const.C_end,
            p_scope  => L_scope);
        
        RETURN l_clob;

    EXCEPTION
        WHEN OTHERS THEN
            logger.log_error (
                p_text   => 'Critical Error',
                p_scope  => L_scope);
            RAISE;
    END f_blob_to_clob;
BEGIN
    --
    -- Set Oracle wallet path from context
    --
    G_wallet_path    := C_wallet_path_prefix ||
                        s_env.f_getenv(C_wallet_context_name);
    G_db_environment := s_env.f_getenv(C_project_phase);
END s_web_util;
/

show err;
