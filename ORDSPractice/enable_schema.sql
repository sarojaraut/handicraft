--
-- Note that enabling a schema is not equivalent to enabling all tables and views in the schema. 
-- It just means making Oracle REST Data Services aware that the schema exists and that it may have zero or more resources to expose to HTTP. 
-- Those resources may be AutoREST resources or resource module resources.
-- p_url_mapping_type can be BASE_PATH or BASE_URL, it cabe changed only when p_url_mapping_pattern is changed
-- select * from user_ords_schemas;
/*

BEGIN
    ORDS.DROP_REST_FOR_SCHEMA( p_schema  => 'CMS');
    COMMIT;
END;
/

*/
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

    ORDS.ENABLE_SCHEMA(p_enabled => TRUE,
                       p_schema => 'CMS',
                       p_url_mapping_type => 'BASE_PATH',
                       p_url_mapping_pattern => 'cms',
                       p_auto_rest_auth => FALSE);
    
    commit;

END;
/


DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

    ORDS.ENABLE_SCHEMA(p_enabled => TRUE,
                       p_schema => 'ORDERACTIVE',
                       p_url_mapping_type => 'BASE_PATH',
                       p_url_mapping_pattern => '.',
                       p_auto_rest_auth => FALSE);
    
    commit;

END;
/

