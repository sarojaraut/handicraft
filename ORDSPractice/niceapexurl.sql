--
-- http://dev-apex/ords/cmsdev/
-- 
BEGIN
    ORDS.DEFINE_MODULE(
       p_module_name    => 'niceapexurl',
       p_base_path      => 'apex/',
       p_items_per_page => 10,
       p_status         => 'PUBLISHED',
       p_comments       => 'NIce APEX URL' );

    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'niceapexurl',
        p_pattern        => '{app}');

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'niceapexurl',
        p_pattern        => '{app}',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_plsql,
        p_source         => q'[declare 
								l_url  varchar2(4000); 
							begin 
								l_url     :=  '../../f?p=' ||:app;
								:URL      := l_url;
								:STATUS   := 301;
							end;]'
	);

	ORDS.define_parameter(
	p_module_name        => 'niceapexurl',
	p_pattern            => '{app}',
	p_method             => 'GET',
	p_name               => 'LOCATION',
	p_bind_variable_name => 'URL',
	p_source_type        => 'HEADER',
	p_param_type         => 'STRING',
	p_access_method      => 'OUT'
	);

	ORDS.define_parameter(
	p_module_name        => 'niceapexurl',
	p_pattern            => '{app}',
	p_method             => 'GET',
	p_name               => 'X-APEX-STATUS-CODE',
	p_bind_variable_name => 'STATUS',
	p_source_type        => 'HEADER',
	p_param_type         => 'STRING',
	p_access_method      => 'OUT'
	);

    COMMIT;

END;
/

http://dev-apex.hq.river-island.com/ords/cmsdev/cms/apex/loggmon

BEGIN
    ORDS.DELETE_MODULE(
       p_module_name    => 'niceapexurl');
END;
/

 DECLARE
   PRAGMA AUTONOMOUS_TRANSACTION;
 BEGIN

     ORDS.ENABLE_SCHEMA(p_enabled => TRUE,
                        p_schema => 'ORDERACTIVE',
                        p_url_mapping_type => 'BASE_PATH',
                        p_url_mapping_pattern => 'orderactive',
                        p_auto_rest_auth => FALSE);

     commit;

 END;
 /


