/*

curl -H "Content-Type: application/json" -d "{\"org_lvl_child\":0, \"org_lvl_parent\":0, \"org_lvl_id\":0, \"org_name_full\":0, \"org_name_short\":0, \"org_lvl_number\":0, \"curr_code\":0, \"org_is_store\":0, \"web_store_ind\":0}" -X POST  http://wwisdlap002/ords/cms/org/orgmst/

 */
-- 
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
-- All ORGs
--
    ORDS.DEFINE_HANDLER(
        p_module_name    => 'org',
        p_pattern        => 'orgmst/',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_query,
        p_source         => 'select * from orgmstee');

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
        
--
-- Country wise stores
--
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
--
-- Country wise stores with hierarchy
--
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
--
-- creating ORG
--
    ORDS.DEFINE_HANDLER(
        p_module_name    => 'org',
        p_pattern        => 'orgmst/',
        p_method         => 'POST',
        p_source_type    => ORDS.source_type_plsql,
        p_source         => 'BEGIN
                               INSERT INTO ORGMSTEE(
                                            org_lvl_child
                                            ,org_lvl_parent
                                            ,org_lvl_id
                                            ,org_name_full
                                            ,org_name_short
                                            ,org_lvl_number
                                            ,curr_code
                                            ,org_is_store
                                            ,web_store_ind)
                                    VALUES
                                        (:org_lvl_child
                                        ,:org_lvl_parent
                                        ,:org_lvl_id
                                        ,:org_name_full
                                        ,:org_name_short
                                        ,:org_lvl_number
                                        ,:curr_code
                                        ,:org_is_store
                                        ,:web_store_ind);
                            END;');

    COMMIT;

END;
/

