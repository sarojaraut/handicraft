--
-- NAME :  create_apxapp_workspace_wms.sql
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

    APEX_INSTANCE_ADMIN.ADD_WORKSPACE
      (p_workspace_id          =>  l_workspace_id
      ,p_workspace             => 'APXAPP'
      ,p_primary_schema        => 'RWM'
      ,p_additional_schemas    => 'WMS:PKMWCS'
      );

END;
/

COMMIT;
