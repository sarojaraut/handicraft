-- Grant Necessary Privileges to Provisioning App Workspace DB User
grant execute on apex_instance_admin to PROVISION;
grant select on sys.dba_sys_privs to PROVISION;
grant create user, drop user, alter user to PROVISION;

begin
    for c1 in (
        select privilege
        from sys.dba_sys_privs
        where grantee = 'APEX_GRANTS_FOR_NEW_USERS_ROLE' ) loop
        execute immediate 'grant '||c1.privilege||' to PROVISION with admin option';
    end loop;
end;
/
--
--Scripting Workspace Creation
-- This script creates 10 workspaces
declare
    l_workspace_base constant varchar2(30) := 'WORKSHOP';
    l_db_user_base   constant varchar2(30) := 'WORKSHOP';
    l_password_base  constant varchar2(30) := 'AaBbCcDdEe!';
    i                         integer;
begin
    for i in 1.. 10 loop
        execute immediate 'create user '||l_db_user_base||i||' identified by "'||l_password_base||i||
            '" default tablespace DATA quota unlimited on DATA';

        --grant all the privileges that a db user would get if provisioned by APEX
        for c1 in (
            select privilege
            from sys.dba_sys_privs
            where grantee = 'APEX_GRANTS_FOR_NEW_USERS_ROLE' ) 
        loop
            execute immediate 'grant '||c1.privilege||' to '||l_db_user_base||i;
        end loop;

        apex_instance_admin.add_workspace(
            p_workspace      => l_workspace_base||i,
            p_primary_schema => l_db_user_base||i);

        --Add the parsing db user of this application to allow apex_util.set_workspace to succeed
        apex_instance_admin.add_schema(
            p_workspace      => l_workspace_base||i,
            p_schema         => 'PROVISION');

        apex_util.set_workspace(
            p_workspace      => l_workspace_base||i);

        apex_util.create_user(
            p_user_name                    => l_db_user_base||i,
            p_web_password                 => l_password_base||i,
            p_developer_privs              => 'ADMIN:CREATE:DATA_LOADER:EDIT:HELP:MONITOR:SQL',
            p_email_address                => l_db_user_base||i||'@example.com',
            p_default_schema               => l_db_user_base||i,
            p_change_password_on_first_use => 'N' );

        apex_instance_admin.remove_schema(
            p_workspace        => l_workspace_base||i,
            p_schema           => 'PROVISION');

        apex_util.set_workspace(
            p_workspace      => 'PROVISION');
    end loop;
end;
