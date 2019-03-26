DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

    ORDS.ENABLE_SCHEMA(p_enabled => TRUE,
                       p_schema => 'ITSR1',
                       p_url_mapping_type => 'BASE_PATH',
                       p_url_mapping_pattern => 'itsr1',
                       p_auto_rest_auth => FALSE);
    
    commit;

END;
/

BEGIN
    ORDS.DROP_REST_FOR_SCHEMA( p_schema  => 'ITSR1');
    COMMIT;
END;
/

DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

    ORDS.ENABLE_OBJECT(p_enabled => TRUE,
                       p_schema => 'ITSR1',
                       p_object => 'IMS_SHIPMENT_HDR',
                       p_object_type => 'TABLE',
                       p_object_alias => 'ims_shipment_hdr',
                       p_auto_rest_auth => FALSE);
    
    commit;

END;
/

http://wwisdlap002/ords/itsr1/ims_shipment_hdr/
