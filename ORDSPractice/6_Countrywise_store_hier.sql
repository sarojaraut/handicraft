--
-- http://wwisdlap002/ords/cms/org/storewithhier/SINGAPORE/
BEGIN
    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'org',
        p_pattern        => 'storewithhier/:CountryName/');

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'org',
        p_pattern        => 'storewithhier/:CountryName/',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_query,
        p_items_per_page => 0,
        p_source         => 'select cntry.*,
                                cursor(select area.*,
                                            cursor(select str.* 
                                            from orgmstee str
                                            where str.org_lvl_parent=area.org_lvl_child) store
                                        from orgmstee area
                                        where area.org_lvl_parent=cntry.org_lvl_child) area
                            from orgmstee cntry
                            where org_lvl_id=3 
                                and org_name_full=upper(:CountryName)');
COMMIT;
END;
/



