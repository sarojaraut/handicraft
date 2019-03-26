DECLARE
    l_workspace_id    NUMBER; 
    l_base_schema     VARCHAR2(30);
	l_workspace_name  VARCHAR2(30) := 'APXAPP';
    l_app_alias       varchar2(30) := 'expdiag';
BEGIN
    SELECT workspace_id
    INTO   l_workspace_id
    FROM   apex_workspaces
    WHERE  workspace = upper(l_workspace_name);
    
    APEX_UTIL.SET_SECURITY_GROUP_ID(P_SECURITY_GROUP_ID => L_WORKSPACE_ID);
    APEX_APPLICATION_INSTALL.SET_WORKSPACE_ID(l_workspace_id);
    APEX_APPLICATION_INSTALL.GENERATE_OFFSET;
    APEX_APPLICATION_INSTALL.SET_SCHEMA(upper(user));
    APEX_APPLICATION_INSTALL.SET_APPLICATION_ALIAS(l_app_alias);
END;
/

@f20000_14092017.sql