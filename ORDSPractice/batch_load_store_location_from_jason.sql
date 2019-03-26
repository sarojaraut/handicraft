SET SERVEROUTPUT ON
DECLARE
  l_cursor SYS_REFCURSOR;
BEGIN
  
  OPEN l_cursor FOR
    SELECT 
        storeid                as "storeid"
        ,location_id           as "location_id"
        ,tote_label_required   as "tote_label_required"
    FROM  store_location
    WHERE ROWNUM <=10;

  APEX_JSON.initialize_clob_output;

  APEX_JSON.open_object;
  APEX_JSON.write('store_location', l_cursor);
  APEX_JSON.close_object;

  DBMS_OUTPUT.put_line(APEX_JSON.get_clob_output);
  APEX_JSON.free_output;
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
    HTP.print('Number of records loaded='||l_store_location_tab.count());
EXCEPTION
    WHEN OTHERS THEN
    HTP.print(SQLERRM);
END;
/

DECLARE
  v_blob       BLOB;
BEGIN
   delete from my_docs;
  load_file_to_my_docs('store_location1.json');
  select doc into v_blob from my_docs where rownum=1;
  batch_load_store_location(v_blob);
  
  COMMIT;
END;

DROP TABLE my_docs;
DROP SEQUENCE my_docs_seq;
DROP PROCEDURE load_file_to_my_docs;

CREATE TABLE my_docs (
  id    NUMBER(10)     NOT NULL,
  name  VARCHAR2(200)  NOT NULL,
  doc   BLOB           NOT NULL
);

ALTER TABLE my_docs ADD (
  CONSTRAINT my_docs_pk PRIMARY KEY (id)
);

CREATE SEQUENCE my_docs_seq;

CREATE OR REPLACE DIRECTORY documents AS 'C:\temp';

CREATE OR REPLACE PROCEDURE load_file_to_my_docs (p_file_name  IN  my_docs.name%TYPE) AS
  v_bfile      BFILE;
  v_blob       BLOB;
BEGIN
  INSERT INTO my_docs (id, name, doc)
  VALUES (my_docs_seq.NEXTVAL, p_file_name, empty_blob())
  RETURN doc INTO v_blob;

  v_bfile := BFILENAME('DOCUMENTS', p_file_name);
  Dbms_Lob.Fileopen(v_bfile, Dbms_Lob.File_Readonly);
  Dbms_Lob.Loadfromfile(v_blob, v_bfile, Dbms_Lob.Getlength(v_bfile));
  Dbms_Lob.Fileclose(v_bfile);
  
  --INSERT INTO my_docs (id, name, doc) VALUES (my_docs_seq.NEXTVAL, p_file_name, v_blob);

  COMMIT;
END;
/

EXEC load_file_to_my_docs('child2.pdf');

EXEC load_file_to_my_docs('child3.pdf');

    PROCEDURE load_json_data_all(
        i_json   BLOB 
    )
    IS
        l_clob    CLOB;

    BEGIN
    
        DBMS_LOB.createtemporary(
            lob_loc => l_clob,
            cache   => FALSE,
            dur     => DBMS_LOB.call);

        DBMS_LOB.converttoclob(
            dest_lob      => l_clob,
            src_blob      => i_json,
            amount        => DBMS_LOB.lobmaxsize,
            dest_offset   => l_dest_offset,
            src_offset    => l_src_offset, 
            blob_csid     => DBMS_LOB.default_csid,
            lang_context  => l_lang_context,
            warning       => l_warning);
        
        insert into cms_call_log values(l_clob, sysdate);

        APEX_JSON.parse(l_clob);
          
        INSERT ALL
        INTO tmp_test_hdr
            (orderid, 
            eventsource, 
            orderPlacedDate, 
            language,
            currency, 
            grandTotal, 
            deliveryMethod,
            deliveryMode, 
            collectType, 
            shippingTotal,
            storeId, 
            earliestCollectionDate, 
            latestDeliveryDate, 
            customerCollectionDate)
        VALUES (
            APEX_JSON.get_varchar2(p_path => 'ord[%d].id', p0=>1), 
            APEX_JSON.get_varchar2(p_path => 'ord[%d].eventSource', p0=>1), 
            APEX_JSON.get_varchar2(p_path => 'ord[%d].order[%d].orderPlacedDate', p0=>1, p1=>1),
            APEX_JSON.get_varchar2(p_path => 'ord[%d].order[%d].language', p0=>1, p1=>1),
            APEX_JSON.get_varchar2(p_path => 'ord[%d].order[%d].currency', p0=>1, p1=>1),
            APEX_JSON.get_number(p_path   => 'ord[%d].order[%d].orderTotal[%d].grandTotal', p0=>1, p1=>1, p2=>1),
            APEX_JSON.get_varchar2(p_path => 'ord[%d].order[%d].shipment[%d].deliveryMethod', p0=>1, p1=>1, p2=>1),
            APEX_JSON.get_varchar2(p_path => 'ord[%d].order[%d].shipment[%d].deliveryMode', p0=>1, p1=>1, p2=>1),
            NULL,
            APEX_JSON.get_number(p_path   => 'ord[%d].order[%d].orderTotal[%d].shippingTotal', p0=>1, p1=>1, p2=>1),
            NULL,
            NULL,
            NULL,
            NULL)
        INTO tmp_test_item
            (orderId, 
            productid, 
            skuId, 
            description, 
            quantity, 
            netprice)
        VALUES  (
            APEX_JSON.get_varchar2(p_path => 'ord[%d].id', p0=>1), 
            APEX_JSON.get_number(p_path   => 'ord[%d].order[%d].productLineItems[%d].productId', p0=>1, p1=>1, p2=>1),
            APEX_JSON.get_number(p_path   => 'ord[%d].order[%d].productLineItems[%d].skuId', p0=>1, p1=>1, p2=>1),
            APEX_JSON.get_varchar2(p_path => 'ord[%d].order[%d].productLineItems[%d].description', p0=>1, p1=>1, p2=>1),
            APEX_JSON.get_number(p_path   => 'ord[%d].order[%d].productLineItems[%d].quantity', p0=>1, p1=>1, p2=>1),
            APEX_JSON.get_number(p_path   => 'ord[%d].order[%d].productLineItems[%d].netPrice', p0=>1, p1=>1, p2=>1))
        INTO tmp_test_tndr
            (orderId, 
            merchantAccount, 
            authorisationCode,
            paymentProvider, 
            transactionId, 
            amount,
            maskedcardNumber)
        VALUES  (
            APEX_JSON.get_varchar2(p_path => 'ord[%d].id', p0=>1), 
            APEX_JSON.get_varchar2(p_path => 'ord[%d].order[%d].payments[%d].merchantAccount', p0=>1, p1=>1, p2=>1),
            APEX_JSON.get_varchar2(p_path => 'ord[%d].order[%d].payments[%d].authorisationCode', p0=>1, p1=>1, p2=>1),
            APEX_JSON.get_varchar2(p_path => 'ord[%d].order[%d].payments[%d].paymentProvider', p0=>1, p1=>1, p2=>1),
            APEX_JSON.get_varchar2(p_path => 'ord[%d].order[%d].payments[%d].transactionId', p0=>1, p1=>1, p2=>1),
            APEX_JSON.get_number(p_path   => 'ord[%d].order[%d].payments[%d].amount', p0=>1, p1=>1, p2=>1),
            APEX_JSON.get_varchar2(p_path => 'ord[%d].order[%d].payments[%d].creditCardPaymentInstrument[%d].maskedcardNumber', p0=>1, p1=>1, p2=>1, p3=>1))
        INTO tmp_test_cntt
            (orderId, 
            firstname, 
            surname, 
            address1, 
            addressType, 
            title)
        VALUES  (
            APEX_JSON.get_varchar2(p_path => 'ord[%d].id', p0=>1), 
            APEX_JSON.get_varchar2(p_path => 'ord[%d].order[%d].shipment[%d].shippingAddress[%d].firstname', p0=>1, p1=>1, p2=>1, p3=>1),
            APEX_JSON.get_varchar2(p_path => 'ord[%d].order[%d].shipment[%d].shippingAddress[%d].surname', p0=>1, p1=>1, p2=>1, p3=>1),
            APEX_JSON.get_varchar2(p_path => 'ord[%d].order[%d].shipment[%d].shippingAddress[%d].address1', p0=>1, p1=>1, p2=>1, p3=>1),
            APEX_JSON.get_varchar2(p_path => 'ord[%d].order[%d].shipment[%d].shippingAddress[%d].addressType', p0=>1, p1=>1, p2=>1, p3=>1),
            APEX_JSON.get_varchar2(p_path => 'ord[%d].order[%d].shipment[%d].shippingAddress[%d].title', p0=>1, p1=>1, p2=>1, p3=>1))
        INTO tmp_test_addr
            (orderId, 
            addressType, 
            address1,
            townCity, 
            postCode, 
            countryCode)
        VALUES  (
            APEX_JSON.get_varchar2(p_path => 'ord[%d].id', p0=>1), 
            APEX_JSON.get_varchar2(p_path => 'ord[%d].order[%d].shipment[%d].shippingAddress[%d].addressType', p0=>1, p1=>1, p2=>1, p3=>1),
            APEX_JSON.get_varchar2(p_path => 'ord[%d].order[%d].shipment[%d].shippingAddress[%d].address1', p0=>1, p1=>1, p2=>1, p3=>1),
            APEX_JSON.get_varchar2(p_path => 'ord[%d].order[%d].shipment[%d].shippingAddress[%d].townCity', p0=>1, p1=>1, p2=>1, p3=>1),
            APEX_JSON.get_varchar2(p_path => 'ord[%d].order[%d].shipment[%d].shippingAddress[%d].postCode', p0=>1, p1=>1, p2=>1, p3=>1),
            APEX_JSON.get_varchar2(p_path => 'ord[%d].order[%d].shipment[%d].shippingAddress[%d].countryCode', p0=>1, p1=>1, p2=>1, p3=>1))
        INTO tmp_test_promo
            (orderId, 
            productid)
        VALUES  (
            APEX_JSON.get_varchar2(p_path => 'ord[%d].id', p0=>1), 
            APEX_JSON.get_number(p_path   => 'ord[%d].order[%d].productLineItems[%d].productId', p0=>1, p1=>1, p2=>1))
        SELECT * FROM DUAL;
        
        commit;
        
    END load_json_data_all;
    
--Sample JSON

{
	"store_location": [{
		"storeid": 3,
		"location_id": "224B",
		"tote_label_required": "Y"
	},
	{
		"storeid": 6,
		"location_id": "104B",
		"tote_label_required": "Y"
	},
	{
		"storeid": 7,
		"location_id": "109A",
		"tote_label_required": "Y"
	},
	{
		"storeid": 8,
		"location_id": "106A",
		"tote_label_required": "Y"
	},
	{
		"storeid": 9,
		"location_id": "215C",
		"tote_label_required": "Y"
	},
	{
		"storeid": 10,
		"location_id": "308B",
		"tote_label_required": "Y"
	},
	{
		"storeid": 11,
		"location_id": "419A",
		"tote_label_required": "Y"
	},
	{
		"storeid": 12,
		"location_id": "408A",
		"tote_label_required": "Y"
	},
	{
		"storeid": 13,
		"location_id": "311A",
		"tote_label_required": "Y"
	},
	{
		"storeid": 14,
		"location_id": "403B",
		"tote_label_required": "Y"
	}]
}

---- MISC

DROP TABLE my_docs;
DROP SEQUENCE my_docs_seq;
DROP PROCEDURE load_file_to_my_docs;

CREATE TABLE my_docs (
  id    NUMBER(10)     NOT NULL,
  name  VARCHAR2(200)  NOT NULL,
  doc   BLOB           NOT NULL
);

ALTER TABLE my_docs ADD (
  CONSTRAINT my_docs_pk PRIMARY KEY (id)
);

CREATE SEQUENCE my_docs_seq;

CREATE OR REPLACE DIRECTORY documents AS 'C:\temp';

CREATE OR REPLACE PROCEDURE load_file_to_my_docs (p_file_name  IN  my_docs.name%TYPE) AS
  v_bfile      BFILE;
  v_blob       BLOB;
BEGIN
  INSERT INTO my_docs (id, name, doc)
  VALUES (my_docs_seq.NEXTVAL, p_file_name, empty_blob())
  RETURN doc INTO v_blob;

  v_bfile := BFILENAME('DOCUMENTS', p_file_name);
  Dbms_Lob.Fileopen(v_bfile, Dbms_Lob.File_Readonly);
  Dbms_Lob.Loadfromfile(v_blob, v_bfile, Dbms_Lob.Getlength(v_bfile));
  Dbms_Lob.Fileclose(v_bfile);
  
  --INSERT INTO my_docs (id, name, doc) VALUES (my_docs_seq.NEXTVAL, p_file_name, v_blob);

  COMMIT;
END;
/



EXEC load_file_to_my_docs('child3.pdf');


utl_raw.cast_to_raw(vc)
