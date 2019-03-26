-- NAME         : import_f20000.sql
-- DESCRIPTION  : Script to setup APEX Install context for 
--              : the target environment and import the app
-- USAGE        : s_sql.sh -t replog import_f20000.sql
-- RETURNS      :
-- PARAMS       :
-- NOTES        : Imports APEX logger APP
-------------------------------------------------------------------------------
-- VERSION | DATE      | AUTHOR          | REASON
-- 1.0     | 15/09/17  | S.Raut          | Initial version
-------------------------------------------------------------------------------

DECLARE
    l_workspace_id    NUMBER; 
    l_base_schema     VARCHAR2(30);
	l_workspace_name  VARCHAR2(30) := 'APXAPP';
    l_app_alias       VARCHAR2(30) := 'loggmon';
	L_params          logger.tab_param;
	l_scope           s_datatype.unit_name   := 'import_f20000.sql';
BEGIN

	logger.append_param (L_params, 'USER', user); 
	
	logger.log_info (
		p_text    => s_const.C_begin,
		p_scope  => l_scope,
		p_params => l_params
		);
    
    --Crears env values, if followed by partial failure attempt
	APEX_APPLICATION_INSTALL.CLEAR_ALL;
	
    --Set up environment values for installation
    SELECT workspace_id
    INTO   l_workspace_id
    FROM   apex_workspaces
    WHERE  workspace = upper(l_workspace_name);
	
	logger.append_param (L_params, 'l_workspace_id', l_workspace_id); 
    
    APEX_UTIL.SET_SECURITY_GROUP_ID(P_SECURITY_GROUP_ID => L_WORKSPACE_ID);
    APEX_APPLICATION_INSTALL.SET_WORKSPACE_ID(l_workspace_id);
    APEX_APPLICATION_INSTALL.GENERATE_OFFSET;
    APEX_APPLICATION_INSTALL.SET_SCHEMA(upper(user));
    APEX_APPLICATION_INSTALL.SET_APPLICATION_ALIAS(l_app_alias);
	
    logger.log_info (
		p_text    => s_const.C_end,
		p_scope  => l_scope,
		p_params => l_params
		);
    
EXCEPTION
    WHEN OTHERS THEN
		logger.log_error (
			p_text   => 'APEX Logger APP Import Failure',
			p_scope  => l_scope,
			p_params => l_params
			);
END;
/

-- Execute actual APEX Export file
@${S_STD_PROMOTE_DIR}/f20000.sql

COMMIT;

