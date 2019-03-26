CREATE OR REPLACE PACKAGE BODY s_slack_util
AS
    -- https://hooks.slack.com/services/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
    g_api_base_url        VARCHAR2(100) := 'https://slack.com/api'; -- s_datatype.long_string
    g_webhook_host        VARCHAR2(100);
    g_webhook_path        VARCHAR2(100);
    g_wallet_path         VARCHAR2(100);
    g_wallet_password     VARCHAR2(100);

    PROCEDURE pl_assert (
        i_condition     in boolean,
        i_error_message in varchar2
    )
    AS
    BEGIN

        IF (i_condition IS NULL) OR (NOT i_condition) 
        THEN
            raise_application_error (-20000, i_error_message);
        END IF;

    END pl_assert;

    FUNCTION fl_make_request (
        i_url          IN VARCHAR2,
        i_body         IN CLOB := NULL,
        i_http_method  IN VARCHAR2 := 'POST'
    ) RETURN clob
    AS
        l_http_status_code             PLS_INTEGER;
        l_returnvalue                  CLOB;
    BEGIN

        apex_web_service.g_request_headers.delete;
        apex_web_service.g_request_headers(1).name := 'Content-Type';
        apex_web_service.g_request_headers(1).value := 'application/json';

        l_returnvalue := apex_web_service.make_rest_request(
            p_url            => i_url,
            p_http_method    => i_http_method,
            p_body           => i_body,
            p_wallet_path    => g_wallet_path,
            p_wallet_pwd     => g_wallet_password,
            p_https_host     => 'slack.com' -- fix for ORA-24263: Certificate Error using slack_util_pkg on 12.2
        );

        l_http_status_code := apex_web_service.g_status_code;

        -- possible error codes, see https://api.slack.com/changelog/2016-05-17-changes-to-errors-for-incoming-webhooks
        pl_assert (
            l_http_status_code = 200, 
            'Request failed with HTTP error code ' 
                || l_http_status_code 
                || '. First 1K of response body: ' 
                || substr(l_returnvalue, 1, 1000) 
        );

    RETURN l_returnvalue;
    
    END fl_make_request;

    PROCEDURE init_context (
        i_webhook_base        IN VARCHAR2,
        i_webhook_path        IN VARCHAR2,
        i_wallet_path         IN VARCHAR2,
        i_wallet_password     IN VARCHAR2
    )
    AS
    BEGIN

        g_webhook_host     := i_webhook_base;
        g_webhook_path     := i_webhook_path;
        g_wallet_path      := i_wallet_path;
        g_wallet_password  := i_wallet_password;
    
    END init_context;

    PROCEDURE send_message (
        i_text in varchar2)
    AS
        l_response clob;
    BEGIN

        pl_assert (g_webhook_host is not null, 'Webhook host not defined!');
        pl_assert (g_webhook_path is not null, 'Webhook path not defined!');

        l_response := fl_make_request (
            i_url => g_webhook_host || g_webhook_path,
            i_body => '{ "text": ' || apex_json.stringify (i_text) || ' }'
        );

    END send_message;

BEGIN
    init_context (
        i_webhook_base       => 'https://hooks.slack.com',
        i_webhook_path       => '/services/T9J6NB9PX/B9K4Q36EB/tXhRrkrzfDvEad99xqP1nM7D',
        i_wallet_path        => 'file:/u01/app/oracle/admin/db12c/wallet' , -- || s_env.f_getenv('S_WALLET_DIR')
        i_wallet_password    => 'babuna21'
    );
END s_slack_util;
/

show err;
