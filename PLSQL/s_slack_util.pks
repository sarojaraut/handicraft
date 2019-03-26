CREATE OR REPLACE PACKAGE s_slack_util
as
-- Steps Involved
-- Go to https://slack.com/signin
-- Create a new workspace using RI email ID e.g RI-Core
-- Add a channel in that workspace e.g appmon
-- Administration > manage apps > search for "Incoming WebHooks"
-- Add configuration and select the channel to whixh you want to publish
-- Make a note of Webhook URL, first part is g_webhook_host and second part is g_webhook_path
-- e.g https://hooks.slack.com/services/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
-- g_webhook_host = https://hooks.slack.com
-- g_webhook_path = /services/T9J6NB9PX/BAW3T9UTS/M4f3ekHZcBiUuTGvUIGTgVWs
-- 
/*
exec s_slack_util.send_message('Testing');
exec s_slack_util.send_message('`Testing`');
exec s_slack_util.send_message('```Testing```');
exec s_slack_util.send_message('>This is a line of text'||chr(10)||'>And this is another one.');

exec s_slack_util.send_message('*This is bold*');
exec s_slack_util.send_message('_This is itlaic_');
exec s_slack_util.send_message('~This is strike out~');

exec s_slack_util.send_message('### Header 3'||chr(10)||'> This is the second paragraph in the blockquote.');

> 
> This is the second paragraph in the blockquote.
exec s_slack_util.send_message('> ## This is an H2 in a blockquote');

https_wallet : is the wallet name
docker cp SlackDigiCertGlobalRootCA.crt 32530b146d33:/
orapki wallet create -wallet https_wallet -pwd babuna21 -auto_login
orapki wallet add -wallet https_wallet -cert hooks.slack.com.cer -trusted_cert -pwd babuna21

docker cp 32530b146d33:/https_wallet .
*/
    -- set API base URL
    PROCEDURE init_context (
        i_webhook_base        IN VARCHAR2,
        i_webhook_path        IN VARCHAR2,
        i_wallet_path         IN VARCHAR2,
        i_wallet_password     IN VARCHAR2
    );
    -- send message
    PROCEDURE send_message (
        i_text in varchar2
    );
 
END s_slack_util;
/

show err;