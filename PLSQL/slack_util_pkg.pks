CREATE OR REPLACE PACKAGE s_slack_util
as

    -- set API base URL
    PROCEDURE init_context (
        i_base_url            IN VARCHAR2,
        i_webhook_path        IN VARCHAR2,
        i_wallet_path         IN VARCHAR2,
        i_wallet_password     IN VARCHAR2,
    );

    -- send message
    PROCEDURE send_message (
        i_text in varchar2
    );
 
END s_slack_util;
/

