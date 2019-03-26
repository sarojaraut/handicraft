--
-- http://wwisdlap002/ords/cms/org/orgmst/
-- http://wwisdlap002/ords/cms/org/orgmst/822/
BEGIN
    ORDS.DEFINE_MODULE(
       p_module_name    => 'org',
       p_base_path      => 'org/',
       p_items_per_page => 10,
       p_status         => 'PUBLISHED',
       p_comments       => 'ORG Module' );

/*
    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'org',
        p_pattern        => 'orgmst/');

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'org',
        p_pattern        => 'orgmst/',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_query,
        p_source         => 'select * from orgmstee');
*/
--
-- Key based search
--
    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'org',
        p_pattern        => 'orgmst/');

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'org',
        p_pattern        => 'orgmst/',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_query,
        p_source         => 'select * from orgmstee where org_lvl_child=nvl(:org_lvl_child,org_lvl_child)');
    
--
-- Key based search
--   

END;
/

commit;

