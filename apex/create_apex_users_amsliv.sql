PROMPT *** Create APEX Users

SET SERVEROUTPUT ON;

DECLARE
    l_workspace_id    NUMBER       := 1000000000000000;
BEGIN
    APEX_UTIL.SET_SECURITY_GROUP_ID(P_SECURITY_GROUP_ID => l_workspace_id);
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'JAMESSO');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'NISHMAP');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'FINBARG');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'MARTINHA');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'SAMZ');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'M0007270');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'RICHKE');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'PAVITER');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'SAMUELC');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'RONGNA');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'M0007167');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'SBIRD');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'HITESHG');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'NAEEMP');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'M0006771');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'M0007148');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'THOMASHI');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'LUKEEVAN');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'VASAVV');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'M0007166');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'JOHNV');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'JAMESR');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'LAURENSO');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'JAGDEEP');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'RANDEEPB');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'M0007075');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'RICHGIL');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'SNEPA');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'M0007150');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'M0007261');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'GARYCO');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'BENST');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'SUNILD');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'MATTWH');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'M0007230');
    COMMIT;
END;
/

SET SERVEROUTPUT ON;

DECLARE
    l_workspace_id    NUMBER       := 1000000000000000;
begin
    apex_util.set_security_group_id(p_security_group_id => 1000000000000000);
-- Jamesso	James	Southall	James.Southall@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'JAMESSO',
            p_first_name                   => 'James',
            p_last_name                    => 'Southall',
            p_description                  => '',
            p_email_address                => 'James.Southall@adminre.co.uk',
            p_web_password                 => 'JAMESSO',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- NishmaP	Nishma	Parmar	Nishma.Parmar@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'NISHMAP',
            p_first_name                   => 'Nishma',
            p_last_name                    => 'Parmar',
            p_description                  => '',
            p_email_address                => 'Nishma.Parmar@adminre.co.uk',
            p_web_password                 => 'NISHMAP',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => 'ADMIN:CREATE:DATA_LOADER:EDIT:HELP:MONITOR:SQL',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- FINBARG	Finbar	Gavin-Gates	Finbar.Gavin-Gates@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'FINBARG',
            p_first_name                   => 'Finbar',
            p_last_name                    => 'Gavin-Gates',
            p_description                  => '',
            p_email_address                => 'Finbar.Gavin-Gates@adminre.co.uk',
            p_web_password                 => 'FINBARG',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- MartinHa	Martin	Hall	Martin.Hall@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'MARTINHA',
            p_first_name                   => 'Martin',
            p_last_name                    => 'Hall',
            p_description                  => '',
            p_email_address                => 'Martin.Hall@adminre.co.uk',
            p_web_password                 => 'MARTINHA',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- samz	Samiul	Zakaria	Samiul.Zakaria@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'SAMZ',
            p_first_name                   => 'Samiul',
            p_last_name                    => 'Zakaria',
            p_description                  => '',
            p_email_address                => 'Samiul.Zakaria@adminre.co.uk',
            p_web_password                 => 'SAMZ',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- M0007270	Harjeet	Bains	Harjeet.Bains@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'M0007270',
            p_first_name                   => 'Harjeet',
            p_last_name                    => 'Bains',
            p_description                  => '',
            p_email_address                => 'Harjeet.Bains@adminre.co.uk',
            p_web_password                 => 'M0007270',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- RICHKE	Richard	Keats	Richard.Keats@adminre.co.uk        
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'RICHKE',
            p_first_name                   => 'Richard',
            p_last_name                    => 'Keats',
            p_description                  => '',
            p_email_address                => 'richard.keats@adminre.co.uk',
            p_web_password                 => 'RICHKE',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- PAVITER	Paviter	Singh Randhawa	Paviter.SinghRandhawa@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'PAVITER',
            p_first_name                   => 'Paviter',
            p_last_name                    => 'Singh',
            p_description                  => '',
            p_email_address                => 'Paviter.SinghRandhawa@adminre.co.uk',
            p_web_password                 => 'PAVITER',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- SAMUELC	Samuel	Chapman	Samuel.Chapman@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'SAMUELC',
            p_first_name                   => 'Samuel',
            p_last_name                    => 'Chapman',
            p_description                  => '',
            p_email_address                => 'Samuel.Chapman@adminre.co.uk',
            p_web_password                 => 'SAMUELC',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- RONGNA	Rongna	Chen	Rongna.Chen@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'RONGNA',
            p_first_name                   => 'Rongna',
            p_last_name                    => 'Chen',
            p_description                  => '',
            p_email_address                => 'Rongna.Chen@adminre.co.uk',
            p_web_password                 => 'RONGNA',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- M0007167	Daljinder	Chatha	Daljinder.Chatha@adminre.co.uk  
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'M0007167',
            p_first_name                   => 'Daljinder',
            p_last_name                    => 'Chatha',
            p_description                  => '',
            p_email_address                => 'Daljinder.Chatha@adminre.co.uk',
            p_web_password                 => 'M0007167',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- SBIRD	Samuel	Bird	Samuel.Bird@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'SBIRD',
            p_first_name                   => 'Samuel',
            p_last_name                    => 'Bird',
            p_description                  => '',
            p_email_address                => 'Samuel.Bird@adminre.co.uk',
            p_web_password                 => 'SBIRD',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- HITESHG	Hitesh	Gohel	Hitesh.Gohel@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'HITESHG',
            p_first_name                   => 'Hitesh',
            p_last_name                    => 'Gohel',
            p_description                  => '',
            p_email_address                => 'Hitesh.Gohel@adminre.co.uk',
            p_web_password                 => 'HITESHG',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- NAEEMP	Naeem	Petkar	Naeem.Petkar@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'NAEEMP',
            p_first_name                   => 'Naeem',
            p_last_name                    => 'Petkar',
            p_description                  => '',
            p_email_address                => 'Naeem.Petkar@adminre.co.uk',
            p_web_password                 => 'NAEEMP',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- M0006771	Michelle	Ntola	Michelle.Ntola@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'M0006771',
            p_first_name                   => 'Michelle',
            p_last_name                    => 'Ntola',
            p_description                  => '',
            p_email_address                => 'Michelle.Ntola@adminre.co.uk',
            p_web_password                 => 'M0006771',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- M0007148	Mary	Hickling	Mary.Hickling@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'M0007148',
            p_first_name                   => 'Mary',
            p_last_name                    => 'Hickling',
            p_description                  => '',
            p_email_address                => 'Mary.Hickling@adminre.co.uk',
            p_web_password                 => 'M0007148',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- THOMASHI	Thomas	Hill	Thomas.Hill@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'THOMASHI',
            p_first_name                   => 'Thomas',
            p_last_name                    => 'Hill',
            p_description                  => '',
            p_email_address                => 'Thomas.Hill@adminre.co.uk',
            p_web_password                 => 'THOMASHI',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- LUKEEVAN	Luke	Evan-Jones	Luke.Evan-Jones@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'LUKEEVAN',
            p_first_name                   => 'Luke',
            p_last_name                    => 'Evan-Jones',
            p_description                  => '',
            p_email_address                => 'Luke.Evan-Jones@adminre.co.uk',
            p_web_password                 => 'LUKEEVAN',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- VASAVV	Vasav	Vyas	Vasav.Vyas@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'VASAVV',
            p_first_name                   => 'Vasav',
            p_last_name                    => 'Vyas',
            p_description                  => '',
            p_email_address                => 'Vasav.Vyas@adminre.co.uk',
            p_web_password                 => 'VASAVV',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- M0007166	Jerissa	Patel	Jerissa.Patel@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'M0007166',
            p_first_name                   => 'Jerissa',
            p_last_name                    => 'Patel',
            p_description                  => '',
            p_email_address                => 'Jerissa.Patel@adminre.co.uk',
            p_web_password                 => 'M0007166',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');

-- JOHNV	John	Varns	John.Varns@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'JOHNV',
            p_first_name                   => 'John',
            p_last_name                    => 'Varns',
            p_description                  => '',
            p_email_address                => 'John.Varns@adminre.co.uk',
            p_web_password                 => 'JOHNV',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- JAMESR	James	Rogers	James.Rogers@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'JAMESR',
            p_first_name                   => 'James',
            p_last_name                    => 'Rogers',
            p_description                  => '',
            p_email_address                => 'James.Rogers@adminre.co.uk',
            p_web_password                 => 'JAMESR',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- LAURENSO	Lauren	Hewlett	lauren.hewlett@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'LAURENSO',
            p_first_name                   => 'Lauren',
            p_last_name                    => 'Hewlett',
            p_description                  => '',
            p_email_address                => 'lauren.hewlett@adminre.co.uk',
            p_web_password                 => 'LAURENSO',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- JAGDEEP	Jagdeep	Atwal	Jagdeep.Atwal@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'JAGDEEP',
            p_first_name                   => 'Jagdeep',
            p_last_name                    => 'Atwal',
            p_description                  => '',
            p_email_address                => 'Jagdeep.Atwal@adminre.co.uk',
            p_web_password                 => 'JAGDEEP',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- RANDEEPB	Randeep	Basra	Randeep.Basra@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'RANDEEPB',
            p_first_name                   => 'Randeep',
            p_last_name                    => 'Basra',
            p_description                  => '',
            p_email_address                => 'Randeep.Basra@adminre.co.uk',
            p_web_password                 => 'RANDEEPB',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');

-- M0007075	Benedict	McConalogue	Benedict.McConalogue@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'M0007075',
            p_first_name                   => 'Benedict',
            p_last_name                    => 'McConalogue',
            p_description                  => '',
            p_email_address                => 'Benedict.McConalogue@adminre.co.uk',
            p_web_password                 => 'M0007075',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- RICHGIL	Richard	Gill	Richard.Gill@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'RICHGIL',
            p_first_name                   => 'Richard',
            p_last_name                    => 'Gill',
            p_description                  => '',
            p_email_address                => 'Richard.Gill@adminre.co.uk',
            p_web_password                 => 'RICHGIL',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');

-- SNEPA	Sneha	Patel	Sneha.Patel@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'SNEPA',
            p_first_name                   => 'Sneha',
            p_last_name                    => 'Patel',
            p_description                  => '',
            p_email_address                => 'Sneha.Patel@adminre.co.uk',
            p_web_password                 => 'SNEPA',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');

-- M0007150	Sean	Stallwood	Sean.Stallwood@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'M0007150',
            p_first_name                   => 'Sean',
            p_last_name                    => 'Stallwood',
            p_description                  => '',
            p_email_address                => 'Sean.Stallwood@adminre.co.uk',
            p_web_password                 => 'M0007150',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- M0007261	Simone	Ceccarelli	Simone.Ceccarelli@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'M0007261',
            p_first_name                   => 'Simone',
            p_last_name                    => 'Ceccarelli',
            p_description                  => '',
            p_email_address                => 'Simone.Ceccarelli@adminre.co.uk',
            p_web_password                 => 'M0007261',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- GARYCO	Gary	Cook	Gary.Cook@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'GARYCO',
            p_first_name                   => 'Gary',
            p_last_name                    => 'Cook',
            p_description                  => '',
            p_email_address                => 'Gary.Cook@adminre.co.uk',
            p_web_password                 => 'GARYCO',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- BENST	Ben	Stroud	Ben.Stroud@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'BENST',
            p_first_name                   => 'Ben',
            p_last_name                    => 'Stroud',
            p_description                  => '',
            p_email_address                => 'Ben.Stroud@adminre.co.uk',
            p_web_password                 => 'BENST',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- SUNILD	Sunil	Dhanda	Sunil.Dhanda@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'SUNILD',
            p_first_name                   => 'Sunil',
            p_last_name                    => 'Dhanda',
            p_description                  => '',
            p_email_address                => 'Sunil.Dhanda@adminre.co.uk',
            p_web_password                 => 'SUNILD',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- MATTWH	Matthew	Wharton	Matthew.Wharton@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'MATTWH',
            p_first_name                   => 'Matthew',
            p_last_name                    => 'Wharton',
            p_description                  => '',
            p_email_address                => 'Matthew.Wharton@adminre.co.uk',
            p_web_password                 => 'MATTWH',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');
-- M0007230	Alex	Wentford	Alex.Wentford@adminre.co.uk
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'M0007230',
            p_first_name                   => 'Alex',
            p_last_name                    => 'Wentford',
            p_description                  => '',
            p_email_address                => 'Alex.Wentford@adminre.co.uk',
            p_web_password                 => 'M0007230',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => '',
            p_default_schema               => 'AMS_PORTAL',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => '');

exception
    when others then
        dbms_output.put_line('SQLERRM ::'||sqlerrm);
end;
/