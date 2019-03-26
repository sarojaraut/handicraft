--
-- http://wwisdlap002/ords/cms/org/orgmst/?org_lvl_number=971
-- http://wwisdlap002/ords/cms/org/orgmst/971/
BEGIN
    ORDS.DEFINE_MODULE(
       p_module_name    => 'org',
       p_base_path      => 'org/',
       p_items_per_page => 10,
       p_status         => 'PUBLISHED',
       p_comments       => 'ORG Module' );

    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'org',
        p_pattern        => 'orgmst/');
--
-- Key based search named parameter
--
    ORDS.DEFINE_HANDLER(
        p_module_name    => 'org',
        p_pattern        => 'orgmst/',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_query,
        p_source         => 'select * from orgmstee where org_lvl_number=nvl(:org_lvl_number,org_lvl_number)');
--
-- Key based search named parameter
--
    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'org',
        p_pattern        => 'orgmst/:org_lvl_number/');

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'org',
        p_pattern        => 'orgmst/:org_lvl_number/',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_query,
        p_source         => 'select * from orgmstee where org_lvl_number=:org_lvl_number');
    
END;
/

commit;

