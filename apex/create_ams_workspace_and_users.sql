sqlplus APEX_DEPLOY/APEX_DEPLOY@gba71011:10200/AMSLNK

begin
    APEX_INSTANCE_ADMIN.ADD_WORKSPACE
      (p_workspace_id          =>  999999999999999
      ,p_workspace             => 'APX_WIP'
      ,p_primary_schema        => 'ORDERACTIVE'
      ,p_additional_schemas    => 'MNPUSERMASTER'
      );
end;
/

begin
    APEX_INSTANCE_ADMIN.ADD_WORKSPACE
      (p_workspace_id          =>  1000000000000000
      ,p_workspace             => 'APXAPP'
      ,p_primary_schema        => 'ORDERACTIVE'
      ,p_additional_schemas    => 'MNPUSERMASTER'
      );
end;
/

DECLARE
    l_workspace_id    NUMBER       := 999999999999999;
begin
    apex_util.set_security_group_id(p_security_group_id => l_workspace_id);
                
    APEX_UTIL.CREATE_USER(
            --p_user_id                      => ams_apex_user_seq.nextval,
            p_user_name                    => 'APXSR',
            p_first_name                   => 'Saroj Ranjan',
            p_last_name                    => 'Raut',
            p_description                  => '',
            p_email_address                => 'saroja.raut@river-island.com',
            p_web_password                 => 'APXSR',
            p_web_password_format          => 'CLEAR_TEXT',
            p_group_ids                    => '',
            p_developer_privs              => 'ADMIN:CREATE:DATA_LOADER:EDIT:HELP:MONITOR:SQL',
            p_default_schema               => 'ITSR',
            p_account_locked               => 'N',
            p_failed_access_attempts       => 0,
            p_change_password_on_first_use => 'Y',
            p_first_password_use_occurred  => 'N',
            p_allow_app_building_yn        => 'Y',
            p_allow_sql_workshop_yn        => 'Y',
            p_allow_websheet_dev_yn        => 'Y',
            p_allow_team_development_yn    => 'Y',
            p_allow_access_to_schemas      => 'ORDERACTIVE');
end;
/

DECLARE
    l_workspace_id    NUMBER       := 1000000000000000; 
    l_workspace_name  VARCHAR2(30) := 'APXAPP';
    l_base_schema     VARCHAR2(30) := 'ORDERACTIVE';
    l_app_alias       varchar2(30) := 'MNPUSERMASTER';
BEGIN
    /*SELECT workspace_id
    INTO   l_workspace_id
    FROM   apex_workspaces
    WHERE  workspace = upper(l_workspace_name);
    */
    APEX_UTIL.SET_SECURITY_GROUP_ID(P_SECURITY_GROUP_ID => L_WORKSPACE_ID);
    APEX_APPLICATION_INSTALL.SET_WORKSPACE_ID(l_workspace_id);
    APEX_APPLICATION_INSTALL.GENERATE_OFFSET;
    APEX_APPLICATION_INSTALL.SET_SCHEMA(upper(l_base_schema));
    APEX_APPLICATION_INSTALL.SET_APPLICATION_ALIAS(l_app_alias);
END;
/

@f1001.sql

@f1001_export_after_deleting_auth_scheme.sql

-- Changing pasword
DECLARE
    l_workspace_id    NUMBER       := 1000000000000000;
begin
    apex_util.set_security_group_id(p_security_group_id => 1000000000000000);
    
    APEX_UTIL.EDIT_USER (
    p_user_id                      => '1',
    p_user_name                    => 'SARRARA',
    p_web_password                 => 'TEST',
    p_new_password                 => 'TEST' -- For updating the password web and new should be same
    );
    
    commit;
end;
/

-- Deleting User
DECLARE
    l_workspace_id    NUMBER       := 1000000000000000;
BEGIN
    APEX_UTIL.SET_SECURITY_GROUP_ID(P_SECURITY_GROUP_ID => 1000000000000000);
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'APXSR');
END;
/

/*
CREATE USER APEX_DEPLOY IDENTIFIED BY APEX_DEPLOY;
GRANT APEX_ADMINISTRATOR_ROLE TO APEX_DEPLOY; -- just gives execute privilege on a db package
GRANT CREATE SESSION TO APEX_DEPLOY;

Rollback Section

begin
    APEX_INSTANCE_ADMIN.ADD_WORKSPACE
      (p_workspace_id          =>  1000000000000000
      ,p_workspace             => 'AMSDEV'
      ,p_primary_schema        => 'AMS_PORTAL'
      ,p_additional_schemas    => 'AMS_VIEW'   -- A colon delimited list
      );
end;
/

begin
    APEX_INSTANCE_ADMIN.REMOVE_WORKSPACE(
        p_workspace         => 'AMS'
        ,p_drop_users       => 'N'
        ,p_drop_tablespaces => 'N' );
end;
/

APEX_INSTANCE_ADMIN.ADD_SCHEMA(
    p_workspace    IN VARCHAR2,
    p_schema       IN VARCHAR2);
    
APEX_INSTANCE_ADMIN.REMOVE_SCHEMA(
    p_workspace     IN VARCHAR2,
    p_schema        IN VARCHAR2);

*/

if you can create a temporary user and grant apex_administrator_role(exacute privilege on a API) to this user and create session privileges 

DECLARE
    l_workspace_id    NUMBER       := 1000000000000000;
begin
    apex_util.set_security_group_id(p_security_group_id => 1000000000000000);
    
    APEX_UTIL.EDIT_USER (
    p_user_id                      => '1',
    p_user_name                    => 'USERNAME',
    p_web_password                 => 'NEW PASSWORD',
    p_new_password                 => 'NEW PASSWORD' -- For updating the password web and new should be same
    );
    
    commit;
end;
/

DECLARE
    l_workspace_id    NUMBER       := 1000000000000000;
begin
    apex_util.set_security_group_id(p_security_group_id => 1000000000000000);
    
    APEX_UTIL.EDIT_USER (
    p_user_id                      => '1',
    p_user_name                    => 'USERNAME',
    p_web_password                 => 'NEW PASSWORD',
    p_new_password                 => 'NEW PASSWORD' 
    );
    
    commit;
end;
/

DECLARE
    l_workspace_id    NUMBER       := 1000000000000000;
BEGIN
    APEX_UTIL.SET_SECURITY_GROUP_ID(P_SECURITY_GROUP_ID => 1000000000000000);
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'APXSR');
    COMMIT;
END;
/

