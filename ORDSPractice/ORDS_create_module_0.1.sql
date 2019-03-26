CREATE OR REPLACE PROCEDURE get_store_json (i_org_name IN orgmstee.org_name_full%TYPE DEFAULT NULL) AS
  l_cursor SYS_REFCURSOR;
BEGIN
  
  INSERT INTO REST_ORG_ACCESS_LOG
    (user_name,access_date)
  VALUES (user,sysdate);
  
    COMMIT;
    
    OPEN l_cursor FOR
        select * from orgmstee 
        where org_lvl_id=1
        start with org_lvl_child in
        (select org_lvl_child from orgmstee 
        where org_lvl_id=3 
        and org_name_full=upper(i_org_name))
        connect by prior org_lvl_child = org_lvl_parent;
        
  APEX_JSON.open_object;
  APEX_JSON.write('STORES', l_cursor);
  APEX_JSON.close_object;
END;
/

CREATE OR REPLACE PROCEDURE update_orgmstee (
    i_org_lvl_child               orgmstee.org_lvl_child%TYPE,
    i_org_lvl_parent              orgmstee.org_lvl_parent%TYPE,
    i_org_lvl_id                  orgmstee.org_lvl_id%TYPE,
    i_org_name_full               orgmstee.org_name_full%TYPE,
    i_org_name_short              orgmstee.org_name_short%TYPE,
    i_org_lvl_number              orgmstee.org_lvl_number%TYPE,
    i_curr_code                   orgmstee.curr_code%TYPE,
    i_org_is_store                orgmstee.org_is_store%TYPE,
    i_web_store_ind               orgmstee.web_store_ind%TYPE
)
AS
BEGIN
    UPDATE orgmstee
    SET 
        org_lvl_parent     =  i_org_lvl_parent,
        org_lvl_id         =  i_org_lvl_id,
        org_name_full      =  i_org_name_full,
        org_name_short     =  i_org_name_short,
        org_lvl_number     =  i_org_lvl_number,
        curr_code          =  i_curr_code,
        org_is_store       =  i_org_is_store,
        web_store_ind      =  i_web_store_ind 
    WHERE   org_lvl_child =  i_org_lvl_child; 
EXCEPTION
  WHEN OTHERS THEN
    HTP.print(SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE delete_orgmstee (
    i_org_lvl_child  IN   orgmstee.org_lvl_child%TYPE
)
AS
BEGIN
  DELETE FROM orgmstee
  WHERE org_lvl_child = i_org_lvl_child;
EXCEPTION
  WHEN OTHERS THEN
    HTP.print(SQLERRM);
END;
/

BEGIN
    --
    -- Main module and standard template
    --
    ORDS.DEFINE_SERVICE(
        p_module_name => 'orgmodule' ,
        p_base_path   => '/orgmodule/',
        p_pattern     => 'orgmstee/',
        p_method =>'GET',
        p_source => 'select * from orgmstee',
        p_items_per_page => 10
        );
    --
    -- List Store SQL
    --
    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'orgmodule',
        p_pattern        => 'liststore/:CountryName');

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'orgmodule',
        p_pattern        => 'liststore/:CountryName',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_query,
        p_source         => 
                        'select * from orgmstee 
                        where org_lvl_id=1
                        start with org_lvl_child in
                        (select org_lvl_child from orgmstee 
                        where org_lvl_id=3 
                        and org_name_full=upper(:CountryName))
                        connect by prior org_lvl_child = org_lvl_parent',
        p_items_per_page => 0);
    --
    -- List Store Cursor
    --
    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'orgmodule',
        p_pattern        => 'storecursor/:CountryName');

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'orgmodule',
        p_pattern        => 'storecursor/:CountryName',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_plsql,
        p_source         => 'BEGIN get_store_json(:CountryName); END;',
        p_items_per_page => 0);
    --
    -- List Store CSV
    --
    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'orgmodule',
        p_pattern        => 'orgmstee-csv.csv/');

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'orgmodule',
        p_pattern        => 'orgmstee-csv.csv/',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_csv_query,
        p_source         => 'select * from orgmstee',
        p_items_per_page => 0);    
    --
    -- Update Store
    --
    ORDS.DEFINE_TEMPLATE(
    p_module_name    => 'orgmodule',
    p_pattern        => 'update-orgmstee/');

    ORDS.DEFINE_HANDLER(
    p_module_name    => 'orgmodule',
    p_pattern        => 'update-orgmstee/',
    p_method         => 'PUT',
    p_source_type    => ORDS.source_type_plsql,
    p_source         => 'BEGIN
                           update_orgmstee (
                            i_org_lvl_child               =>  :org_lvl_child,
                            i_org_lvl_parent              =>  :org_lvl_parent,
                            i_org_lvl_id                  =>  :org_lvl_id,
                            i_org_name_full               =>  :org_name_full,
                            i_org_name_short              =>  :org_name_short,
                            i_org_lvl_number              =>  :org_lvl_number,
                            i_curr_code                   =>  :curr_code,
                            i_org_is_store                =>  :org_is_store,
                            i_web_store_ind               =>  :web_store_ind
                        );
                         END;',
    p_items_per_page => 0);
    --
    -- Delete Store
    --
    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'orgmodule',
        p_pattern        => 'delete-orgmstee/');

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'orgmodule',
        p_pattern        => 'delete-orgmstee/',
        p_method         => 'DELETE',
        p_source_type    => ORDS.source_type_plsql,
        p_source         => 'BEGIN
                               delete_orgmstee(i_org_lvl_child => :org_lvl_child);
                             END;',
        p_items_per_page => 0);
    
    COMMIT;
EXCEPTION
WHEN OTHERS THEN 
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
    ROLLBACK;
    RAISE;
END;
/

http://wwisdlap002/ords/cms/orgmodule/orgmstee/?offset=11&limit=20



