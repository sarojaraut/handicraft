--
-- NAME :  create_apxapp_user_wms.sql
-- TYPE :  SQL Script
-- TITLE:  Script for creating APX_APP workspace
-- NOTES:  This script must be executed from user login having  
--         APEX_ADMINISTRATOR_ROLE role.
--
--$Revision:   1.0  $
--
-- Version   | Date     | Author      | Reason
--------------------------------------------------------------------------------
-- 1.0       |12/06/17 | S Raut       | Initial release
--------------------------------------------------------------------------------
DECLARE
    l_workspace_id    NUMBER       := 1000000000000000;
BEGIN
      
    APEX_UTIL.SET_SECURITY_GROUP_ID(p_security_group_id => l_workspace_id);
                
    APEX_UTIL.CREATE_USER(
            p_user_name                    => 'APXAPP',
            p_first_name                   => 'Apxapp',
            p_last_name                    => 'Apxapp',
            p_description                  => 'Dev/Admin user for Apex workspace',
            p_email_address                => 'apxapp@river-island.com',
            p_web_password                 => 'APXAPP',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => 'ADMIN:CREATE:DATA_LOADER:EDIT:HELP:MONITOR:SQL',
            p_default_schema               => 'RWM',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => 'WMS:PKMWCS');
END;
/

COMMIT;
