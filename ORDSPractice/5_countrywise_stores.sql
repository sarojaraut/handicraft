--
-- http://wwisdlap002/ords/cms/org/store/SINGAPORE/
BEGIN
    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'org',
        p_pattern        => 'store/:CountryName/');

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'org',
        p_pattern        => 'store/:CountryName/',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_query,
        p_source         => 'select * from orgmstee 
                        where org_lvl_id=1
                        start with org_lvl_child in
                        (select org_lvl_child from orgmstee 
                        where org_lvl_id=3 
                        and org_name_full=upper(:CountryName))
                        connect by prior org_lvl_child = org_lvl_parent');
COMMIT;
END;
/



