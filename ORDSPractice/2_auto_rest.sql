Post by Batch Load

curl -i -X POST --data-binary @w_ii_orgmstee.csv -H "Content-Type: text/csv" http://wwisdlap002/ords/cms/w_ii_orgmstee/batchload?dateFormat="DD-MON-YYYY"

CREATE OR REPLACE PROCEDURE process_org_batch (
    i_batch_id IN w_ii_orgmstee.batch_id%TYPE) 
AS
    l_cursor SYS_REFCURSOR;
BEGIN
  
  INSERT INTO orgmstee
  SELECT  
    org_lvl_child
    ,org_lvl_parent
    ,org_lvl_id
    ,org_name_full
    ,org_name_short
    ,org_lvl_number
    ,curr_code
    ,org_is_store
    ,web_store_ind
  FROM w_ii_orgmstee
  WHERE batch_id = i_batch_id
    AND NVL(processed_status,'NA') <> 'PROCESSED';
    
  UPDATE w_ii_orgmstee
  SET processed_status = 'PROCESSED'
  WHERE batch_id = i_batch_id;

  COMMIT;
    
    OPEN l_cursor FOR
        select * from w_ii_orgmstee;
        
  APEX_JSON.open_object;
  APEX_JSON.write('STORES', l_cursor);
  APEX_JSON.close_object;
EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    HTP.print(SQLERRM);
END;
/

withou using apex_jason
begin  
     owa_util.mime_header('application/json', true, null);  
     htp.p('{"hello":"world"}');  
end; 

BEGIN
    ORDS.DEFINE_MODULE(
       p_module_name    => 'w_ii_orgmstee',
       p_base_path      => 'w_ii_orgmstee/',
       p_items_per_page => 10,
       p_status         => 'PUBLISHED',
       p_comments       => 'ORG Module' );

    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'w_ii_orgmstee',
        p_pattern        => 'processedbatch/:batch_id');

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'w_ii_orgmstee',
        p_pattern        => 'processedbatch/:batch_id',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_plsql,
        p_source         => 'BEGIN process_org_batch(:batch_id); END;');

    COMMIT;

END;
/

curl -i -X POST --data-binary @w_ii_orgmstee.csv -H "Content-Type: text/csv" http://wwisdlap002/ords/cms/w_ii_orgmstee/batchload?dateFormat="DD-MON-YYYY"

http://wwisdlap002/ords/cms/w_ii_orgmstee/processedbatch/1

curl -i http://wwisdlap002/ords/cms/w_ii_orgmstee/processedbatch/1



