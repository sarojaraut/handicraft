--
-- Provide values for the top five variables and run as cms user in cmsdev.
-- **Important Note ** : user name has to be exactly as your Ad username
-- After script execution access : http://rlcmstd:8080/apex with following credentials
--          Workspace name APXAPP
--          Username as provided in the script, 
--          Password as provided in the script
CREATE OR REPLACE procedure create_apex_dev_user(
      i_username     IN     VARCHAR2
    , i_password     IN     VARCHAR2
    , i_email_id     IN     VARCHAR2
    , i_first_name   IN     VARCHAR2
    , i_last_name    IN     VARCHAR2
)
IS
    L_scope    s_datatype.unit_name := LOWER($$plsql_unit);
BEGIN
 
    FOR idx in
        (SELECT 
            workspace, 
            workspace_id 
        FROM apex_workspaces)
    LOOP
        apex_util.set_security_group_id(p_security_group_id => idx.workspace_id);
        -- ignore user already exists error
        apex_util.create_user(
                p_user_name                    => i_username,
                p_first_name                   => i_first_name,
                p_last_name                    => i_last_name,
                p_description                  => 'Dev user for Apex workspace',
                p_email_address                => i_email_id,
                p_web_password                 => i_password,
                p_web_password_format          => 'CLEAR_TEXT',
                p_group_ids                    => '',
                p_developer_privs              => 'CREATE:DATA_LOADER:EDIT:HELP:MONITOR:SQL',
                p_default_schema               => user,
                p_account_locked               => 'N',
                p_failed_access_attempts       =>  0,
                p_change_password_on_first_use => 'Y',
                p_first_password_use_occurred  => 'N',
                p_allow_app_building_yn        => 'Y',
                p_allow_sql_workshop_yn        => 'Y',
                p_allow_websheet_dev_yn        => 'Y',
                p_allow_team_development_yn    => 'Y',
                p_allow_access_to_schemas      => user);

    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        logger.log_error (
            p_text   => 'Error identifying unknown SKU',
            p_scope  => L_scope);
        RAISE;
 
END;
/

SELECT
    user_name,
    apxapp_user,
    apx_wip_user
FROM(
    SELECT
        workspace_name,
        user_name,
        upper(account_locked) account_locked
    FROM
        apex_workspace_apex_users@cms_cmsdev
    WHERE
        user_name = 'APXAPP'
)
PIVOT ( 
        MIN (decode(account_locked ,
                'NO', 'Y',
                'YES', 'L') 
        ) AS "USER"
        FOR workspace_name
            IN ( 
            'APXAPP'  AS APXAPP,
            'APX_WIP' AS APX_WIP)
);


Side Region showing the report
Any other user 

alter table ri_apex_user_access_request drop
(
CMS_SCRIPT,
OMS_SCRIPT,
WMS_SCRIPT,
DWH_SCRIPT,
MFP_SCRIPT
)

create database link cms_cmsdev connect to cms identified by cmsdev using
'CMSDEV =
  (DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = rlcmstd)(PORT = 1523))
    )
    (CONNECT_DATA =
      (SERVICE_NAME = cmsdev)
    )
  )';


create database link rwm_wmsdev connect to rwm identified by rwmdev using
'  (DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = rlwmstd)(PORT = 1523))
    )
    (CONNECT_DATA =
      (SERVICE_NAME = wmsdev)
    )
  )';

cd
~/.vscode/extensions

settings :
plsql-language.pldoc.path
plsql-language.pldoc.author

select * from trans_hso_ord_hdr where ord_id in
(
2100108079
,2100110502-- Already there
,2100110512
,250195390
,250195693
,250197173
,250197173
,250197173
);

4095d883a5b9f766459a5e42413bcafe43c5386f  2100108079.json
774e3a58e461eb1318547eaa9dc8b820da7e08a7  2100110504.json
dc900273602b69c5c2c963c0d91b87c680f6445b  2100110512.json
a14462ac33bf0b49cfdb8b0feba4007c9c6bf90f  2100110514.json
250195390