PROMPT *** Create AMS Workspace

SET SERVEROUTPUT ON;

begin
    APEX_INSTANCE_ADMIN.ADD_WORKSPACE
      (p_workspace_id          =>  1000000000000000 
      ,p_workspace             => 'AMS'
      ,p_primary_schema        => 'AMS_PORTAL'
      ,p_additional_schemas    => 'AMS_VIEW'   -- A colon delimited list
      );
exception
    when others then
        dbms_output.put_line('SQLERRM ::'||sqlerrm);
end;
/

PROMPT *** Importing the Portal Applicationn

DECLARE
    l_workspace_id    NUMBER       := 1000000000000000; 
    l_workspace_name  VARCHAR2(30) := 'AMS';
    l_base_schema     VARCHAR2(30) := 'AMS_PORTAL';
    l_app_alias       varchar2(30) := 'AMS_PORTAL';
BEGIN
    /*SELECT workspace_id
    INTO   l_workspace_id
    FROM   apex_workspaces
    WHERE  workspace = upper(l_workspace_name);
    */
    apex_util.set_security_group_id(p_security_group_id => l_workspace_id);
    APEX_APPLICATION_INSTALL.SET_WORKSPACE_ID(l_workspace_id);
    APEX_APPLICATION_INSTALL.GENERATE_OFFSET;
    APEX_APPLICATION_INSTALL.SET_SCHEMA(upper(l_base_schema));
    APEX_APPLICATION_INSTALL.SET_APPLICATION_ALIAS(l_app_alias);
exception
    when others then
        dbms_output.put_line('SQLERRM ::'||sqlerrm);
END;
/

@f1001_WithStaticFilesInWorkspaceFile.sql
@create_apex_users.sql
commit;


