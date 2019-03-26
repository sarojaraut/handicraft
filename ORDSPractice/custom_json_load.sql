http://wwisdlap002/ords/oms/storelocation/bulkload/

cd C:\Saroj\Software\cURL\Extracted
curl -i -X POST --data-binary @store_location.json -H "Content-Type: application/json" http://wwisdlap002/ords/oms/storelocation/bulkload/

DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

    ORDS.ENABLE_SCHEMA(p_enabled => TRUE,
                       p_schema => 'ORDERACTIVE',
                       p_url_mapping_type => 'BASE_PATH',
                       p_url_mapping_pattern => 'oms',
                       p_auto_rest_auth => FALSE);
    
    commit;

END;
/

BEGIN
    ORDS.DEFINE_MODULE(
       p_module_name    => 'storelocation',
       p_base_path      => 'storelocation/',
       p_items_per_page => 10,
       p_status         => 'PUBLISHED',
       p_comments       => 'storelocation Module' );

    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'storelocation',
        p_pattern        => 'bulkload/');
        
    ORDS.DEFINE_HANDLER(
        p_module_name    => 'storelocation',
        p_pattern        => 'bulkload/',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_query,
        p_source         => 'select * from store_location');

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'storelocation',
        p_pattern        => 'bulkload/',
        p_method         => 'POST',
        p_source_type    => ORDS.source_type_plsql,
        p_source         => 'BEGIN
                               batch_load_store_location(p_data => :body);
                            END;');

    COMMIT;

END;
/


DECLARE
    l_clob    CLOB;
    l_blob    BLOB;
BEGIN

    select doc into l_blob from my_docs where rownum=1;
    -- Get the XML response from the web service.
    l_clob := APEX_WEB_SERVICE.make_rest_request(
    p_url         => 'http://wwisdlap002/ords/oms/storelocation/bulkload/',
    p_http_method => 'POST',
    p_body_blob   => l_blob
    );

    -- Display the whole SOAP document returned.
    DBMS_OUTPUT.put_line('l_clob=' || l_clob);

END;
/


CREATE OR REPLACE PROCEDURE batch_load_store_location (p_data  IN  BLOB)
AS
    TYPE t_store_location_tab  IS TABLE OF store_location%ROWTYPE;
    l_store_location_tab      t_store_location_tab  := t_store_location_tab();
    l_clob         CLOB;
    l_dest_offset  PLS_INTEGER := 1;
    l_src_offset   PLS_INTEGER := 1;
    l_lang_context PLS_INTEGER := DBMS_LOB.default_lang_ctx;
    l_warning      PLS_INTEGER;

    l_store_location_count    PLS_INTEGER;
BEGIN

    -- Convert the BLOB to a CLOB.
    DBMS_LOB.createtemporary(
        lob_loc => l_clob,
        cache   => FALSE,
        dur     => DBMS_LOB.call);

    DBMS_LOB.converttoclob(
        dest_lob      => l_clob,
        src_blob      => p_data,
        amount        => DBMS_LOB.lobmaxsize,
        dest_offset   => l_dest_offset,
        src_offset    => l_src_offset, 
        blob_csid     => DBMS_LOB.default_csid,
        lang_context  => l_lang_context,
        warning       => l_warning);

    APEX_JSON.parse(l_clob);

    -- Loop through all the departments.
    l_store_location_count := APEX_JSON.get_count(p_path => 'store_location');
    FOR i IN 1 .. l_store_location_count LOOP
        l_store_location_tab.extend;
        l_store_location_tab(l_store_location_tab.last).storeid := APEX_JSON.get_number(p_path => 'store_location[%d].storeid', p0 => i);
        l_store_location_tab(l_store_location_tab.last).location_id  := APEX_JSON.get_varchar2(p_path => 'store_location[%d].location_id', p0 => i);
        l_store_location_tab(l_store_location_tab.last).tote_label_required  := APEX_JSON.get_varchar2(p_path => 'store_location[%d].tote_label_required', p0 => i);
    END LOOP;

    -- Populate the tables.
    DELETE FROM store_location;
    FORALL i IN l_store_location_tab.first .. l_store_location_tab.last
    INSERT INTO store_location(storeid, location_id, tote_label_required, created_dtm) 
    VALUES (l_store_location_tab(i).storeid, l_store_location_tab(i).location_id, l_store_location_tab(i).tote_label_required,SYSDATE);
    COMMIT;

    DBMS_LOB.freetemporary(lob_loc => l_clob);
    HTP.print('Number of records loaded Successfully='||l_store_location_tab.count());
EXCEPTION
    WHEN OTHERS THEN
    HTP.print(SQLERRM);
END;
/


