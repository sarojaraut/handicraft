BEGIN
    ORDS.ENABLE_OBJECT(p_enabled => TRUE,
                       p_schema => 'CMS',
                       p_object => 'W_II_ORGMSTEE',
                       p_object_type => 'TABLE',
                       p_object_alias => 'w_ii_orgmstee',
                       p_auto_rest_auth => FALSE);
    
    commit;

END;
/


GET Requests
All records 
http://wwisdlap002/ords/cms/w_ii_orgmstee
One specific record
http://wwisdlap002/ords/cms/w_ii_orgmstee/0
Meta data of the table, column name and data type, primary key
http://wwisdlap002/ords/cms/metadata-catalog/w_ii_orgmstee/item
List of all objects enabled for this schema
http://wwisdlap002/ords/cms/metadata-catalog/
Table data using pagination
http://wwisdlap002/ords/cms/w_ii_orgmstee/?offset=10&limit=5

cd C:\Saroj\Software\cURL\Extracted

Insert Table Row

{"org_lvl_child":0, "org_lvl_parent":0, "org_lvl_id":0, "org_name_full":0, "org_name_short":0, "org_lvl_number":0, "curr_code":0, "org_is_store":0, "web_store_ind":0}

curl -i -X POST --data-binary @update-payload.json -H "Content-Type: application/json" http://wwisdlap002/ords/cms/w_ii_orgmstee/

curl -H "Content-Type: application/json" -d "{\"org_lvl_child\":0, \"org_lvl_parent\":0, \"org_lvl_id\":0, \"org_name_full\":0, \"org_name_short\":0, \"org_lvl_number\":0, \"curr_code\":0, \"org_is_store\":0, \"web_store_ind\":0}" -X POST http://wwisdlap002/ords/cms/w_ii_orgmstee/

curl -H "Content-Type: application/json" -d "{\"org_lvl_child\":1, \"org_lvl_parent\":0, \"org_lvl_id\":0, \"org_name_full\":0, \"org_name_short\":0, \"org_lvl_number\":0, \"curr_code\":0, \"org_is_store\":0, \"web_store_ind\":0}" -X POST http://wwisdlap002/ords/cms/w_ii_orgmstee/

Update/Insert Table Row

curl -i -X PUT --data-binary @update-payload.json -H "Content-Type: application/json" http://wwisdlap002/ords/cms/w_ii_orgmstee/0

curl -H "Content-Type: application/json" -d "{\"org_lvl_child\":0, \"org_lvl_parent\":1, \"org_lvl_id\":0, \"org_name_full\":0, \"org_name_short\":0, \"org_lvl_number\":0, \"curr_code\":0, \"org_is_store\":0, \"web_store_ind\":0}" -X PUT http://wwisdlap002/ords/cms/w_ii_orgmstee/0

alter table W_II_ORGMSTEE add primary key org_lvl_child;

curl -i -X POST --data-binary @bulkinsert-payload.json -H "Content-Type: application/json" http://ol7-121.localdomain:8080/ords/pdb1/testuser2/employees/batchload?dateFormat="DD-MON-YYYY"

curl -i -X POST --data-binary @TEST.csv -H "Content-Type: text/csv" http://wwisdlap002/ords/cms/test/batchload?dateFormat="DD-MON-YYYY"

curl -i -X POST --data-binary @TEST.csv -H "Content-Type: text/csv" http://wwisdlap002/ords/cms/test/batchload?dateFormat="DD-MON-YYYY"

curl -i -X POST --data-binary @TEST.json -H "Content-Type: application/json" http://wwisdlap002/ords/cms/test/batchload?dateFormat="DD-MON-YYYY"